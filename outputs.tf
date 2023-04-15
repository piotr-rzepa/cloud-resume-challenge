output "aws_cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.s3_distribution.domain_name
  description = "Domain name of created Cloudfront distribution, without schema"
}

output "aws_s3_website_bucket" {
  value       = aws_s3_bucket.crc_website.id
  description = "Name of creates AWS S3 Bucket for storing website configuration"
}
