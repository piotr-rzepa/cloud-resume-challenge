module "cloudwatch-label" {
  source  = "cloudposse/label/null"
  version = "~> 0.25"

  attributes = ["cloudwatch", "monitoring"]

  context = module.this.context
}

module "cloudwatch" {
  source  = "terraform-aws-modules/cloudwatch/aws//modules/metric-alarm"
  version = "~> 3.0"

  alarm_name          = module.cloudwatch-label.id
  alarm_description   = "Number of erroneous responses of Lambda invocations"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = var.evaluation_periods
  threshold           = var.error_threshold
  datapoints_to_alarm = var.datapoints_to_alarm

  metric_query = [{
    id = "e1"

    return_data = true
    expression  = "m2/m1*100"
    label       = "Lambda Invocations resulting in error (%)"
    },
    {
      id = "m1"

      metric = [{
        namespace   = "AWS/Lambda"
        metric_name = "Invocations"
        period      = var.period
        stat        = "Sum"
        unit        = "Count"

        dimensions = {
          FunctionName = var.lambda_function_name
        }
      }]
    },
    {
      id = "m2"

      metric = [{
        namespace   = "AWS/Lambda"
        metric_name = "Errors"
        period      = var.period
        stat        = "Sum"
        unit        = "Count"

        dimensions = {
          FunctionName = var.lambda_function_name
        }
      }]
  }]

  alarm_actions = [var.sns_topic_arn]
  tags          = module.cloudwatch-label.tags
}
