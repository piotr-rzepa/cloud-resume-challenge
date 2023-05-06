data "aws_s3_bucket" "state_backend" {
  bucket = "przepk-clp-test-bucket"
}

data "aws_caller_identity" "current" {
}

/*
* AWS S3 configuration (terraform state file storage backend)
*/

resource "aws_s3_bucket" "crc_website" {
  bucket_prefix       = substr(var.aws_bucket_prefix, 0, 37)
  force_destroy       = true
  object_lock_enabled = false

  tags = var.aws_project_tags

}

/*
* AWS CloudFront configuration
*/

resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = var.aws_cloudfront_oac_name
  description                       = "Origin Access Control for Cloud Resume Challenge S3 Bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"

}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.crc_website.bucket_regional_domain_name
    origin_id                = var.aws_cloudfront_distribution_origin_id
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_oac.id
    s3_origin_config {
      origin_access_identity = ""
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    target_origin_id       = var.aws_cloudfront_distribution_origin_id
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = "b2884449-e4de-46a7-ac36-70bc7f1ddd6d"
    cached_methods         = ["GET", "HEAD"]
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }
  enabled             = true
  http_version        = "http2"
  default_root_object = "index.html"
  comment             = "Cloude Resume Challenge Distribution"
  price_class         = "PriceClass_100"
  is_ipv6_enabled     = false
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = var.aws_project_tags
}

/*
* AWS S3 configuration (website storage)
*/

resource "aws_s3_bucket_ownership_controls" "crc_ownership" {
  bucket = aws_s3_bucket.crc_website.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

data "aws_iam_policy_document" "allow_cloudfront_service_principal_read" {
  statement {
    sid       = "AllowCloudFrontServicePrincipalReadOnly"
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.crc_website.arn}/*"]
    effect    = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    condition {
      test     = "StringLike"
      values   = ["arn:aws:cloudfront::${data.aws_caller_identity.current.account_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"]
      variable = "AWS:SourceArn"
    }
  }

}

resource "aws_s3_bucket_policy" "allow_cloudfront_service_principal_read" {
  bucket = aws_s3_bucket.crc_website.id
  policy = data.aws_iam_policy_document.allow_cloudfront_service_principal_read.json
}

resource "aws_s3_bucket_public_access_block" "crc_pab_config" {
  bucket = aws_s3_bucket.crc_website.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

/*
* AWS DynamoDB configuration
*/

resource "aws_dynamodb_table" "crc_table" {
  name           = var.aws_dynamodb_table_name
  billing_mode   = "PROVISIONED"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = var.aws_dynamodb_table_key_data["hash_key"]

  attribute {
    name = var.aws_dynamodb_table_key_data["hash_key"]
    type = var.aws_dynamodb_table_key_data["hash_key_type"]
  }

  tags = var.aws_project_tags
}

/*
* AWS API Gateway configuration (REST)
*/

module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 2.2.2"

  name          = var.aws_api_gateway_name
  description   = "REST API for Cloud Resume Challenge Website"
  protocol_type = "HTTP"

  cors_configuration = {
    allow_headers = var.aws_api_gateway_allow_headers
    allow_methods = var.aws_api_gateway_allowed_methods
    allow_origins = ["https://${aws_cloudfront_distribution.s3_distribution.domain_name}"]
  }

  create_api_domain_name = false
  create_vpc_link        = false

  integrations = {
    "POST /visitors" = {
      lambda_arn = aws_lambda_function.crc_lambda.arn
    }
  }

  tags = var.aws_project_tags

}

/*
* AWS Lambda configuration
*/

resource "aws_lambda_permission" "api_gateway" {
  statement_id  = "AllowApiGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.crc_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*"

}

data "aws_iam_policy_document" "lambda_dynamodb_crud" {
  statement {
    effect = "Allow"
    actions = [
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:PutItem",
      "dynamodb:Scan",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:BatchGetItem",
      "dynamodb:DescribeTable",
      "dynamodb:ConditionCheckItem",
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      aws_dynamodb_table.crc_table.arn,
      "${aws_dynamodb_table.crc_table.arn}/index/*"
    ]
  }
}

data "aws_iam_policy_document" "lambda_assume_role" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "lambda_dynamodb" {
  name               = "przepk-cloud-resume-lambda-dynamo-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role.json


  inline_policy {
    name   = "inline-policy-przepk-cloud-resume"
    policy = data.aws_iam_policy_document.lambda_dynamodb_crud.json
  }

  tags = var.aws_project_tags
}

data "archive_file" "lambda_content" {
  type             = "zip"
  source_dir       = "${path.module}/src/backend/lambda/"
  output_path      = "${path.module}/lambda.zip"
  output_file_mode = "0666"

}


resource "aws_lambda_function" "crc_lambda" {
  filename         = "lambda.zip"
  function_name    = "test-przepk-lambda-cloud-resume"
  handler          = "app.handler"
  source_code_hash = data.archive_file.lambda_content.output_base64sha256
  role             = aws_iam_role.lambda_dynamodb.arn
  runtime          = "python3.9"

  environment {
    variables = {
      DYNAMODB_TABLE            = aws_dynamodb_table.crc_table.id
      WEBSITE_CLOUDFRONT_DOMAIN = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}"
    }
  }

  tags = var.aws_project_tags
}
