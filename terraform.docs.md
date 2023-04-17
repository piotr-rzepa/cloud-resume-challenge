<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.4 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | 2.3.0 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.62.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | terraform-aws-modules/apigateway-v2/aws | ~> 2.2.2 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.s3_distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.s3_oac](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_dynamodb_table.crc_table](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_role.lambda_dynamodb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_lambda_function.crc_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_lambda_permission.api_gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_s3_bucket.crc_website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_ownership_controls.crc_ownership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.allow_cloudfront_service_principal_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.crc_pab_config](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [archive_file.lambda_content](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.allow_cloudfront_service_principal_read](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_assume_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.lambda_dynamodb_crud](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_s3_bucket.state_backend](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_api_gateway_allow_headers"></a> [aws\_api\_gateway\_allow\_headers](#input\_aws\_api\_gateway\_allow\_headers) | Allowed HTTP headers for API Gateway | `list(string)` | n/a | yes |
| <a name="input_aws_api_gateway_allowed_methods"></a> [aws\_api\_gateway\_allowed\_methods](#input\_aws\_api\_gateway\_allowed\_methods) | Allowed HTTP methods for API Gateway | `list(string)` | n/a | yes |
| <a name="input_aws_api_gateway_name"></a> [aws\_api\_gateway\_name](#input\_aws\_api\_gateway\_name) | Name of the AWS API Gateway resource to handle requests | `string` | n/a | yes |
| <a name="input_aws_bucket_prefix"></a> [aws\_bucket\_prefix](#input\_aws\_bucket\_prefix) | Prefix of the bucket to store all the data for Cloud Resume Challenge website | `string` | n/a | yes |
| <a name="input_aws_cloudfront_distribution_origin_id"></a> [aws\_cloudfront\_distribution\_origin\_id](#input\_aws\_cloudfront\_distribution\_origin\_id) | Name/Id of AWS CloudFront Distribution | `string` | n/a | yes |
| <a name="input_aws_cloudfront_oac_name"></a> [aws\_cloudfront\_oac\_name](#input\_aws\_cloudfront\_oac\_name) | Name od AWS Cloudfront Origin Access Control | `string` | n/a | yes |
| <a name="input_aws_dynamodb_table_key_data"></a> [aws\_dynamodb\_table\_key\_data](#input\_aws\_dynamodb\_table\_key\_data) | Key=value pair describing Hash key of DynamoDB Table and its type | `map(string)` | n/a | yes |
| <a name="input_aws_dynamodb_table_name"></a> [aws\_dynamodb\_table\_name](#input\_aws\_dynamodb\_table\_name) | Name of AWS DynamoDB Table | `string` | n/a | yes |
| <a name="input_aws_project_tags"></a> [aws\_project\_tags](#input\_aws\_project\_tags) | Map of key=value pairs, which are assigned to AWS resources as tags | `map(string)` | <pre>{<br>  "Deployment": "Terraform",<br>  "Project": "Cloud-Resume-Challenge"<br>}</pre> | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where resources will be deployed | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_api_gateway_invoke_url"></a> [aws\_api\_gateway\_invoke\_url](#output\_aws\_api\_gateway\_invoke\_url) | API Gateway invoke URL |
| <a name="output_aws_cloudfront_domain_name"></a> [aws\_cloudfront\_domain\_name](#output\_aws\_cloudfront\_domain\_name) | Domain name of created Cloudfront distribution, without schema |
| <a name="output_aws_s3_website_bucket"></a> [aws\_s3\_website\_bucket](#output\_aws\_s3\_website\_bucket) | Name of creates AWS S3 Bucket for storing website configuration |
<!-- END_TF_DOCS -->
