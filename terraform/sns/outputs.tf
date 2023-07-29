output "subscriptions" {
  description = "Map of subscriptions created and their attributes"
  value       = module.sns.subscriptions
}

output "topic_arn" {
  description = "The ARN of the SNS topic"
  value       = module.sns.topic_arn
}

output "topic_name" {
  description = "The name of the topic"
  value       = module.sns.topic_name
}

output "topic_owner" {
  description = "The AWS Account ID of the SNS topic owner"
  value       = module.sns.topic_owner
}
