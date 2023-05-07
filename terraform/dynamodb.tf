/*
* AWS DynamoDB configuration
*/

resource "aws_dynamodb_table" "crc_table" {
  name           = "${var.global_prefix}-${var.environment}-${random_pet.name.id}"
  billing_mode   = "PROVISIONED"
  read_capacity  = var.aws_dynamodb_capacity.read
  write_capacity = var.aws_dynamodb_capacity.write
  hash_key       = var.aws_dynamodb_table_key_data["hash_key"]

  attribute {
    name = var.aws_dynamodb_table_key_data["hash_key"]
    type = var.aws_dynamodb_table_key_data["hash_key_type"]
  }

  tags = local.tags
}
