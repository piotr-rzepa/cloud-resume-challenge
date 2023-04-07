data "aws_s3_bucket" "state_backend" {
  bucket = var.aws_s3_terraform_state_bucket_name
}

output "bucket_data" {
  value = {
    id     = data.aws_s3_bucket.state_backend.id
    arn    = data.aws_s3_bucket.state_backend.arn
    domain = data.aws_s3_bucket.state_backend.bucket_domain_name
  }
}
