/*
* AWS S3 configuration
*/

module "s3-label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25"

  attributes = ["frontend"]

  context = module.this.context
}

module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 3.14"

  bucket                                   = coalesce(var.s3_bucket_name, module.s3-label.id)
  force_destroy                            = var.s3_force_destroy
  object_lock_enabled                      = var.s3_object_lock_enabled
  attach_deny_insecure_transport_policy    = var.s3_attach_deny_insecure_transport_policy
  attach_deny_incorrect_encryption_headers = var.s3_attach_deny_incorrect_encryption_headers
  attach_deny_incorrect_kms_key_sse        = var.s3_attach_deny_incorrect_kms_key_sse
  block_public_acls                        = var.s3_block_public_acls
  block_public_policy                      = var.s3_block_public_policy
  restrict_public_buckets                  = var.s3_restrict_public_buckets
  ignore_public_acls                       = var.s3_ignore_public_acls
  attach_policy                            = true
  policy                                   = data.aws_iam_policy_document.bucket_policy_cloudfront.json


  tags = module.s3-label.tags
}
