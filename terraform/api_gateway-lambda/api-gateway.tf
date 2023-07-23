/*
* AWS API Gateway configuration (REST)
*/

module "apigateway-label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25"

  attributes = ["api"]

  context = module.this.context
}

module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 2.2"

  name          = module.apigateway-label.id
  description   = "REST API for Cloud Resume Challenge Website"
  protocol_type = var.protocol_type

  cors_configuration = {
    allow_headers = var.allowed_http_headers
    allow_methods = var.allowed_http_methods
    allow_origins = ["https://${var.cloudfront_domain_name}"]
  }

  create_api_domain_name = var.create_api_domain_name
  create_vpc_link        = var.create_vpc_link

  integrations = {
    "POST /visitors" = {
      lambda_arn             = module.lambda_function.lambda_function_arn
      integration_type       = "AWS_PROXY"
      payload_format_version = "2.0"
    }
  }

  tags = module.apigateway-label.tags

}
