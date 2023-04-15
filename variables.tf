variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}

variable "aws_project_tags" {
  description = "Map of key=value pairs, which are assigned to AWS resources as tags"
  type        = map(string)
  default = {
    "Project" = "Cloud-Resume-Challenge"
    "Deployment" : "Terraform"
  }

}

variable "aws_bucket_prefix" {
  description = "Prefix of the bucket to store all the data for Cloud Resume Challenge website"
  type        = string
}

variable "aws_user_name" {
  description = "Name of AWS user used to deploy the resources"
  type        = string
}

variable "aws_cloudfront_oac_name" {
  description = "Name od AWS Cloudfront Origin Access Control"
  type        = string

}

variable "aws_cloudfront_distribution_origin_id" {
  description = "Name/Id of AWS CloudFront Distribution"
  type        = string

}

variable "aws_dynamodb_table_name" {
  description = "Name of AWS DynamoDB Table"
  type        = string

}

variable "aws_dynamodb_table_key_data" {
  description = "Key=value pair describing Hash key of DynamoDB Table and its type"
  type        = map(string)
}
