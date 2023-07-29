
variable "aws_region" {
  description = "AWS Region where resources will be deployed"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function to create an alarm for"
  type        = string
}

variable "sns_topic_arn" {
  description = "ARN of the SNS topic, which will receive information when alarm gooes to ALARM state"
  type        = string
}

variable "error_threshold" {
  description = "Value which denotes the alarm to go to ALARM state when all existing data points in the most recent consecutive periods are above this threshold"
  type        = number
}

variable "evaluation_periods" {
  description = "Number of the most recent periods, or data points, to evaluate when determining alarm state"
  type        = number
}

variable "datapoints_to_alarm" {
  description = "number of data points within the Evaluation Periods that must be breaching to cause the alarm to go to the ALARM state."
  type        = number
}

variable "period" {
  description = "Length of time to use to evaluate the metric or expression to create each individual data point for an alarm"
  type        = number
}
