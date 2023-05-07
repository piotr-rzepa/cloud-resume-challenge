output "aws_cloudfront_domain_name" {
  value       = "https://${aws_cloudfront_distribution.s3_distribution.domain_name}"
  description = "Domain name of created Cloudfront distribution, without schema"
}

output "aws_s3_website_bucket" {
  value       = aws_s3_bucket.crc_website.id
  description = "Name of creates AWS S3 Bucket for storing website configuration"
}

output "aws_api_gateway_invoke_url" {
  value       = "${module.api_gateway.apigatewayv2_api_api_endpoint}/visitors"
  description = "API Gateway invoke URL"
}

output "aws_cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.s3_distribution.id
  description = "Identifier for the distribution, used to invalidate cache in CI/CD"
}
