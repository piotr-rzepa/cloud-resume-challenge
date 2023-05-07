/*
* AWS API Gateway configuration (REST)
*/

module "api_gateway" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 2.2.2"

  name          = "${var.global_prefix}-${var.environment}-${random_pet.name.id}"
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
      lambda_arn = module.lambda_function.lambda_function_arn
    }
  }

  tags = local.tags

}
