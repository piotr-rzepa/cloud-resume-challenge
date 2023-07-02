
variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}

variable "protocol_type" {
  description = "The API protocol. Valid values: HTTP, WEBSOCKET"
  type        = string

  validation {
    condition     = var.protocol_type != "HTTP" || var.protocol_type != "WEBSOCKET"
    error_message = "Valid protocol values are HTTP and WEBSOCKET"
  }
}

variable "allowed_http_methods" {
  description = "Allowed HTTP methods for API Gateway"
  type        = list(string)
}

variable "allowed_http_headers" {
  description = "Allowed HTTP headers for API Gateway"
  type        = list(string)
}

variable "create_api_domain_name" {
  description = "Whether to create API domain name resource"
  type        = bool
}

variable "create_vpc_link" {
  description = "Whether to create VPC links"
  type        = bool
}

variable "lambda_name" {
  description = "Name of the Lambda function"
  type        = string
  default     = null

}

variable "lambda_description" {
  description = "Description of Lambda function"
  type        = string
  default     = ""
}

variable "lambda_handler" {
  description = "Name of the Lambda Function entrypoint in code"
  type        = string

}

variable "lambda_runtime" {
  description = "Lambda Function runtime"
  type        = string

}

variable "lambda_compatible_runtimes" {
  description = "A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified"
  type        = list(string)

  validation {
    condition     = length(var.lambda_compatible_runtimes) <= 5
    error_message = "You can specify up to 5 compatible runtimes"
  }
}

variable "lambda_architectures" {
  description = "Instruction set architecture for your Lambda function. Valid values are x86_64 and arm64"
  type        = list(string)

  validation {
    condition     = contains(var.lambda_architectures, "x86_64") || contains(var.lambda_architectures, "arm64")
    error_message = "Valid values are ['x86_64'] and ['arm64']"
  }

}

variable "lambda_source_path" {
  description = "The absolute path to a local file or directory containing your Lambda source code"
  type        = string

}

variable "lambda_publish_new_version" {
  description = "Whether to publish creation/change as new Lambda Function Version"
  type        = bool

}
variable "lambda_create_package" {
  description = "Controls whether Lambda package should be created"
  type        = bool
}

variable "lambda_create_layer" {
  description = "Controls whether Lambda Layer resource should be created"
  type        = bool

}

variable "lambda_create_latest_alias" {
  description = "Whether to use unqualified alias pointing to $LATEST version in Lambda Function URL"
  type        = bool

}

variable "lambda_create_async_latest_alias" {
  description = "Whether to allow async event configuration on unqualified alias pointing to $LATEST version"
  type        = bool
}

variable "lambda_create_trigger_latest_alias" {
  description = "Whether to allow triggers on unqualified alias pointing to $LATEST version"
  type        = bool
}

variable "lambda_create_current_async_alias" {
  description = "Whether to allow async event configuration on current version of Lambda Function"
  type        = bool
}

variable "lambda_create_current_trigger_alias" {
  description = "Whether to allow triggers on current version of Lambda Function"
  type        = bool
}

variable "lambda_authorization_type" {
  description = "The type of authentication that the Lambda Function URL uses. Set to 'AWS_IAM' to restrict access to authenticated IAM users only. Set to 'NONE' to bypass IAM authentication and create a public endpoint."
  type        = string

  validation {
    condition     = contains(["AWS_IAM", "NONE"], var.lambda_authorization_type)
    error_message = "Allowed values are AWS_IAM, NONE"
  }

}

variable "lambda_timeout" {
  description = "The amount of time Lambda function has to run in seconds, before being timed out"
  type        = number
}

variable "lambda_memory_size" {
  description = "The amount of memory in MB for Lambda function to use at runtime"
  type        = number
}

variable "dynamodb_table_name" {
  description = "Name of the DynamoDB table to give the Lambda access to"
  type        = string
}

variable "cloudfront_domain_name" {
  description = "Name of the CloudFront Domain which is accessing the content of S3 Bucket"
  type        = string
}
