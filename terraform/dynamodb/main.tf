/*
* AWS DynamoDB configuration
*/

module "dynamodb-table-label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25"

  attributes = ["visitors", "table"]

  context = module.this.context
}

module "dynamodb-table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 3.3"

  name           = coalesce(var.table_name, module.dynamodb-table-label.id)
  billing_mode   = upper(var.billing_mode)
  read_capacity  = var.read_capacity
  write_capacity = var.write_capacity
  hash_key       = var.hash_key

  attributes = var.attributes_list

  tags = module.dynamodb-table-label.tags
}
