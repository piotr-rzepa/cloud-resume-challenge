aws_region = "eu-west-1"
aws_dynamodb_table_key_data = {
  "hash_key"      = "CounterName"
  "hash_key_type" = "S"
}
aws_api_gateway_allow_headers   = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent", "origin"]
aws_api_gateway_allowed_methods = ["GET", "POST", "OPTIONS"]
