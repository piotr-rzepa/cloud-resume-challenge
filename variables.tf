variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}

variable "aws_s3_terraform_state_bucket_name" {
  description = "Name of the already existing bucket to store Terraform state file using AWS backend"
  type        = string
}
