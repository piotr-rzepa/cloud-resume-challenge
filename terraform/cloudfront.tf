/*
* AWS CloudFront configuration
*/

resource "aws_cloudfront_origin_access_control" "s3_oac" {
  name                              = "${var.global_prefix}-${var.environment}-${random_pet.name.id}"
  description                       = "Origin Access Control for Cloud Resume Challenge S3 Bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"

}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name              = aws_s3_bucket.crc_website.bucket_regional_domain_name
    origin_id                = "${var.global_prefix}-${var.environment}-${random_pet.name.id}"
    origin_access_control_id = aws_cloudfront_origin_access_control.s3_oac.id
    s3_origin_config {
      origin_access_identity = ""
    }
  }

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    target_origin_id       = "${var.global_prefix}-${var.environment}-${random_pet.name.id}"
    viewer_protocol_policy = var.aws_cloudfront_viewer_protocol_policy
    cache_policy_id        = var.aws_cloudfront_cache_policy_id
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
  default_root_object = var.aws_cloudfront_default_root_object
  comment             = "Cloude Resume Challenge Distribution"
  price_class         = "PriceClass_100"
  is_ipv6_enabled     = false
  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = local.tags

  lifecycle {
    ignore_changes = [tags, origin]
  }
}
