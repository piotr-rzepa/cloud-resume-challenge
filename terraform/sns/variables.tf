
variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}

variable "email_endpoint" {
  description = "Email you want to use as a SNS topic endpoint"
  type        = string
}
