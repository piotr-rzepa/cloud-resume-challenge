/*
* AWS Lambda configuration
*/

module "lambda-label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25"

  attributes = ["proxy"]

  context = module.this.context
}

module "lambda_function" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 4.17"

  function_name       = coalesce(var.lambda_name, module.lambda-label.id)
  description         = var.lambda_description
  handler             = var.lambda_handler
  runtime             = var.lambda_runtime
  compatible_runtimes = var.lambda_compatible_runtimes
  architectures       = var.lambda_architectures

  source_path = var.lambda_source_path
  publish     = var.lambda_publish_new_version

  create_package                               = var.lambda_create_package
  create_layer                                 = var.lambda_create_layer
  create_unqualified_alias_lambda_function_url = var.lambda_create_latest_alias
  create_unqualified_alias_async_event_config  = var.lambda_create_async_latest_alias
  create_unqualified_alias_allowed_triggers    = var.lambda_create_trigger_latest_alias
  create_current_version_async_event_config    = var.lambda_create_current_async_alias
  create_current_version_allowed_triggers      = var.lambda_create_current_trigger_alias
  authorization_type                           = var.lambda_authorization_type



  environment_variables = {
    DYNAMODB_TABLE            = var.dynamodb_table_name
    WEBSITE_CLOUDFRONT_DOMAIN = "https://${var.cloudfront_domain_name}"
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
  attach_policies        = true
  attach_policy_jsons    = true
  number_of_policy_jsons = 1
  policy_jsons           = [data.aws_iam_policy_document.lambda_dynamodb_access_policy.json]

  allowed_triggers = {
    APIGatewayPost = {
      service    = "apigateway"
      source_arn = "${module.api_gateway.apigatewayv2_api_execution_arn}/*/*"
    }
  }

  role_tags = module.lambda-label.tags
  tags      = module.lambda-label.tags
}
