terraform_version_constraint = ">= 1.5"
terragrunt_version_constraint = ">= 0.45.10"

locals {
    aws_region = get_env("AWS_REGION", "eu-west-1")
    tf_state_bucket = get_env("STATE_S3_BUCKET")
}

terraform {
    extra_arguments "common_var" {
        commands = [
            "apply",
            "plan",
            "import",
            "push",
            "refresh"
        ]
        required_var_files = [
            "${get_parent_terragrunt_dir()}/common.tfvars"
        ]
    }
}

remote_state {
    backend = "s3"
    disable_dependency_optimization = true
    config = {
        bucket = local.tf_state_bucket
        region = "${local.aws_region}"
        key    = "${path_relative_to_include()}/terraform.tfstate"
    }

    generate = {
        path = "backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}

generate "provider" {
    path = "provider.tf"
    if_exists = "overwrite_terragrunt"
    contents = <<EOF
terraform {
  required_version = "~> 1.5"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5"
    }
  }
}
provider "aws" {
  region = "${local.aws_region}"
}
EOF
}
