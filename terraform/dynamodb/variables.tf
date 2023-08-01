variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}

variable "table_name" {
  type        = string
  description = "Name of the DynamoDB Table"
  default     = null
}

variable "hash_key" {
  type        = string
  description = "The name of the attribute to use as the hash (partition) key. Must also be defined as the attribute"
}

variable "attributes_list" {
  type        = list(map(string))
  description = "List of nested attribute definitions"
}

variable "billing_mode" {
  type        = string
  description = "Name of the Billing mode for read/write capacity usage."
  validation {
    condition     = var.billing_mode == "PROVISIONED" || var.billing_mode == "PAY_PER_REQUEST"
    error_message = "The valid values for billing modes are: PROVISIONED, PAY_PER_REQUEST."
  }
}

variable "read_capacity" {
  type        = number
  description = "The number of read units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"

}

variable "write_capacity" {
  type        = number
  description = "The number of write units for this table. If the billing_mode is PROVISIONED, this field should be greater than 0"
}
