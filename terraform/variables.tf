variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}

variable "aws_project_tags" {
  description = "Map of key=value pairs, which are assigned to AWS resources as tags"
  type        = map(string)
  default = {
    "Project"    = "Cloud Resume Challenge"
    "Deployment" = "Terraform"
  }
}

variable "environment" {
  description = "Name of the environment the infrastructure is provisioned in"
  type        = string
  default     = "dev"

}

variable "global_prefix" {
  description = "Prefix value for all provided resources"
  type        = string
  default     = "cloud-resume-challenge"

}

variable "aws_dynamodb_table_key_data" {
  description = "Key=value pair describing Hash key of DynamoDB Table and its type"
  type        = map(string)
}

variable "aws_api_gateway_allowed_methods" {
  description = "Allowed HTTP methods for API Gateway"
  type        = list(string)
}

variable "aws_api_gateway_allow_headers" {
  description = "Allowed HTTP headers for API Gateway"
  type        = list(string)
}

variable "aws_cloudfront_cache_policy_id" {
  description = "Id of cache policy for controlling cache behavior"
  type        = string
  default     = "b2884449-e4de-46a7-ac36-70bc7f1ddd6d"
}

variable "aws_cloudfront_viewer_protocol_policy" {
  description = "Name of the protocol users can use to access files in the origin"
  type        = string
  default     = "redirect-to-https"
  validation {
    condition     = contains(["redirect-to-https", "allow-all", "https-only"], var.aws_cloudfront_viewer_protocol_policy)
    error_message = "A viewer protocol policy must be one of ${join(", ", ["redirect-to-https", "allow-all", "https-only"])}"
  }
}

variable "aws_cloudfront_default_root_object" {
  description = "Object that is returned by CloudFront when root URL is requested"
  type        = string
  default     = "index.html"
}

variable "aws_dynamodb_capacity" {
  description = "Read and write capacity for DynamoDB table"
  type = object({
    read  = number
    write = number
  })

  default = {
    read  = 1
    write = 1
  }

}

variable "aws_lambda_handler_name" {
  description = "Name for the function to be called on requests to Lambda"
  type        = string
  default     = "app.handler"

}

variable "aws_lambda_source_path" {
  description = "Path to the source code for AWS Lambda, relative to the terraform/ directory"
  type        = string
  default     = "../src/backend/lambda"

}
