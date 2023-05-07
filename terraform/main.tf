data "aws_s3_bucket" "state_backend" {
  bucket = "przepk-clp-test-bucket"
}

data "aws_caller_identity" "current" {
}

resource "random_pet" "name" {
  length = 1
}

locals {
  tags = merge(var.aws_project_tags, { "Environment" = upper(var.environment) }, { "Region" : var.aws_region })
}
