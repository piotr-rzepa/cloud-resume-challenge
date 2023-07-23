/*
* AWS CloudFront configuration
*/

data "aws_caller_identity" "current" {
}

module "cloudfront-label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25"

  attributes = ["oac"]

  context = module.this.context
}

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 3.2"

  comment                      = var.cf_description
  price_class                  = var.cf_price_class
  http_version                 = var.cf_http_version
  is_ipv6_enabled              = var.cf_is_ipv6_enabled
  default_root_object          = var.cf_default_root_object
  create_origin_access_control = var.cf_create_oac
  origin_access_control = {
    s3_oac = {
      description      = var.cf_oac_description
      origin_type      = var.cf_oac_origin_type
      signing_behavior = var.cf_oac_signinig_behavior
      signing_protocol = var.cf_oac_signinig_protocol
    }
  }

  origin = {
    s3_oac = {
      domain_name           = module.s3-bucket.s3_bucket_bucket_regional_domain_name
      origin_access_control = "s3_oac"

    }
  }

  default_cache_behavior = {
    target_origin_id           = "s3_oac"
    allowed_methods            = var.cf_cache_allowed_methods
    cached_methods             = var.cf_cache_cached_methods
    viewer_protocol_policy     = var.cf_cache_viewer_protocol_policy
    response_headers_policy_id = var.cf_cache_response_headers_policy_id

  }

  tags = module.cloudfront-label.tags
}
