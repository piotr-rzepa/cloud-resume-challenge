output "apigatewayv2_api_id" {
  description = "The API identifier"
  value       = module.api_gateway.apigatewayv2_api_id
}

output "apigatewayv2_api_api_endpoint" {
  description = "The URI of the API"
  value       = module.api_gateway.apigatewayv2_api_api_endpoint
}

output "apigatewayv2_api_arn" {
  description = "The ARN of the API"
  value       = module.api_gateway.apigatewayv2_api_arn
}

# default stage
output "default_apigatewayv2_stage_id" {
  description = "The default stage identifier"
  value       = module.api_gateway.default_apigatewayv2_stage_id
}

output "default_apigatewayv2_stage_arn" {
  description = "The default stage ARN"
  value       = module.api_gateway.default_apigatewayv2_stage_arn
}

output "default_apigatewayv2_stage_invoke_url" {
  description = "The URL to invoke the API pointing to the stage"
  value       = module.api_gateway.default_apigatewayv2_stage_invoke_url
}

# Lambda Function

output "lambda_function_arn" {
  description = "The ARN of the Lambda Function"
  value       = module.lambda_function.lambda_function_arn
}

output "lambda_function_invoke_arn" {
  description = "The Invoke ARN of the Lambda Function"
  value       = module.lambda_function.lambda_function_invoke_arn
}

output "lambda_function_name" {
  description = "The name of the Lambda Function"
  value       = module.lambda_function.lambda_function_name
}

output "lambda_function_qualified_arn" {
  description = "The ARN identifying your Lambda Function Version"
  value       = module.lambda_function.lambda_function_qualified_arn
}

output "lambda_function_qualified_invoke_arn" {
  description = "The Invoke ARN identifying your Lambda Function Version"
  value       = module.lambda_function.lambda_function_qualified_invoke_arn
}

output "lambda_function_version" {
  description = "Latest published version of Lambda Function"
  value       = module.lambda_function.lambda_function_version
}

output "lambda_function_last_modified" {
  description = "The date Lambda Function resource was last modified"
  value       = module.lambda_function.lambda_function_last_modified
}

output "lambda_function_source_code_hash" {
  description = "Base64-encoded representation of raw SHA-256 sum of the zip file"
  value       = module.lambda_function.lambda_function_source_code_hash
}

output "lambda_function_source_code_size" {
  description = "The size in bytes of the function .zip file"
  value       = module.lambda_function.lambda_layer_source_code_size
}

output "lambda_function_url" {
  description = "The URL of the Lambda Function URL"
  value       = module.lambda_function.lambda_function_url
}
