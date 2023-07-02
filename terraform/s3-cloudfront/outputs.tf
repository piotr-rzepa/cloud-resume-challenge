output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3-bucket.s3_bucket_arn

}

output "bucket_id" {
  description = "The name of the bucket"
  value       = module.s3-bucket.s3_bucket_id

}

output "bucket_domain_name" {
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com"
  value       = module.s3-bucket.s3_bucket_bucket_domain_name

}

output "bucket_regional_domain_name" {
  description = "The bucket region-specific domain name"
  value       = module.s3-bucket.s3_bucket_bucket_regional_domain_name
}

output "bucket_policy" {
  description = "The policy of the bucket, if the bucket is configured with a policy"
  value       = module.s3-bucket.s3_bucket_policy

}

output "bucket_region" {
  description = "The AWS region this bucket resides in"
  value       = module.s3-bucket.s3_bucket_region

}

output "cloudfront_distribution_arn" {
  description = "The ARN (Amazon Resource Name) for the distribution"
  value       = module.cloudfront.cloudfront_distribution_arn

}
output "cloudfront_distribution_domain_name" {
  description = "The domain name corresponding to the distribution"
  value       = module.cloudfront.cloudfront_distribution_domain_name

}
output "cloudfront_distribution_id" {
  description = "The identifier for the distribution"
  value       = module.cloudfront.cloudfront_distribution_id

}
output "cloudfront_distribution_last_modified_time" {
  description = "The date and time the distribution was last modified"
  value       = module.cloudfront.cloudfront_distribution_last_modified_time

}
output "cloudfront_distribution_trusted_signers" {
  description = "List of nested attributes for active trusted signers, if the distribution is set up to serve private content with signed URLs"
  value       = module.cloudfront.cloudfront_distribution_trusted_signers

}
output "cloudfront_origin_access_controls" {
  description = "The origin access controls created"
  value       = module.cloudfront.cloudfront_origin_access_controls

}

output "cloudfront_origin_access_controls_ids" {
  description = "The IDS of the origin access identities created"
  value       = module.cloudfront.cloudfront_origin_access_controls_ids
}
