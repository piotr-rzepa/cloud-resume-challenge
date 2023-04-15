data "aws_s3_bucket" "state_backend" {
  bucket = "przepk-clp-test-bucket"
}

data "aws_iam_user" "user" {
  user_name = var.aws_user_name
}

resource "aws_s3_bucket" "crc_website" {
  bucket_prefix       = substr(var.aws_bucket_prefix, 0, 37)
  force_destroy       = true
  object_lock_enabled = false

  tags = var.aws_project_tags

}

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
      values   = ["arn:aws:cloudfront:::${data.aws_iam_user.user.user_id}:distribution/${aws_cloudfront_distribution.s3_distribution.id}"]
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
