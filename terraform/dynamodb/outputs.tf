output "dynamodb_table_arn" {
  value       = module.dynamodb-table.dynamodb_table_arn
  description = "ARN of the DynamoDB table"

}

output "dynamodb_table_id" {
  value       = module.dynamodb-table.dynamodb_table_id
  description = "ID of the DynamoDB table"

}
