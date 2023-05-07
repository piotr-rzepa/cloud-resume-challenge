/*
* AWS Lambda configuration
*/

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.17.0"

  function_name       = "${var.global_prefix}-${var.environment}-${random_pet.name.id}"
  description         = "Lambda function for handling visitors' count"
  handler             = var.aws_lambda_handler_name
  runtime             = "python3.10"
  compatible_runtimes = ["python3.10", "python3.9", "python3.8"]
  architectures       = ["x86_64"]

  source_path = var.aws_lambda_source_path
  publish     = true

  create_package                               = true
  lambda_at_edge                               = false
  create_layer                                 = false
  attach_dead_letter_policy                    = false
  attach_network_policy                        = false
  attach_tracing_policy                        = false
  attach_async_event_policy                    = false
  create_unqualified_alias_lambda_function_url = true
  create_unqualified_alias_async_event_config  = false
  create_unqualified_alias_allowed_triggers    = true
  create_current_version_async_event_config    = false
  create_current_version_allowed_triggers      = true



  environment_variables = {
    DYNAMODB_TABLE            = aws_dynamodb_table.crc_table.id
    WEBSITE_CLOUDFRONT_DOMAIN = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}"
  }

  assume_role_policy_statements = {
    lambda_assume = {
      effect = "Allow"
      principals = {
        lambda_principal = {
          type        = "Service"
          identifiers = ["lambda.amazonaws.com"]
        }
      }
      actions = ["sts:AssumeRole"]
    }
  }

  attach_policy_statements = true
  policy_statements = {
    dynamodb = {
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

  allowed_triggers = {
    APIGatewayPost = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*"
    }
  }

  tags = local.tags
}
