module "sns-label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25"

  attributes = ["sns"]

  context = module.this.context
}

module "sns" {
  source  = "terraform-aws-modules/sns/aws"
  version = "~> 5.3.0"

  name                = module.sns-label.id
  create_topic_policy = true

  topic_policy_statements = {
    pub = {
      actions = ["sns:Publish"]
      principals = [{
        type        = "Service"
        identifiers = ["cloudwatch.amazonaws.com"]
      }]
    }
  }

  subscriptions = {
    admin = {
      protocol = "email"
      endpoint = var.email_endpoint
    }
  }


  tags = module.sns-label.tags
}
