## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.9.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_api_gateway"></a> [api\_gateway](#module\_api\_gateway) | terraform-aws-modules/apigateway-v2/aws | ~> 2.2 |
| <a name="module_apigateway-label"></a> [apigateway-label](#module\_apigateway-label) | cloudposse/label/null | ~> 0.25 |
| <a name="module_lambda-label"></a> [lambda-label](#module\_lambda-label) | cloudposse/label/null | ~> 0.25 |
| <a name="module_lambda_function"></a> [lambda\_function](#module\_lambda\_function) | terraform-aws-modules/lambda/aws | ~> 4.17 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/dynamodb_table) | data source |
| [aws_iam_policy_document.lambda_dynamodb_access_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_allowed_http_headers"></a> [allowed\_http\_headers](#input\_allowed\_http\_headers) | Allowed HTTP headers for API Gateway | `list(string)` | n/a | yes |
| <a name="input_allowed_http_methods"></a> [allowed\_http\_methods](#input\_allowed\_http\_methods) | Allowed HTTP methods for API Gateway | `list(string)` | n/a | yes |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where resources will be deployed | `string` | n/a | yes |
| <a name="input_cloudfront_domain_name"></a> [cloudfront\_domain\_name](#input\_cloudfront\_domain\_name) | Name of the CloudFront Domain which is accessing the content of S3 Bucket | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_create_api_domain_name"></a> [create\_api\_domain\_name](#input\_create\_api\_domain\_name) | Whether to create API domain name resource | `bool` | n/a | yes |
| <a name="input_create_vpc_link"></a> [create\_vpc\_link](#input\_create\_vpc\_link) | Whether to create VPC links | `bool` | n/a | yes |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_dynamodb_table_name"></a> [dynamodb\_table\_name](#input\_dynamodb\_table\_name) | Name of the DynamoDB table to give the Lambda access to | `string` | n/a | yes |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_lambda_architectures"></a> [lambda\_architectures](#input\_lambda\_architectures) | Instruction set architecture for your Lambda function. Valid values are x86\_64 and arm64 | `list(string)` | n/a | yes |
| <a name="input_lambda_authorization_type"></a> [lambda\_authorization\_type](#input\_lambda\_authorization\_type) | The type of authentication that the Lambda Function URL uses. Set to 'AWS\_IAM' to restrict access to authenticated IAM users only. Set to 'NONE' to bypass IAM authentication and create a public endpoint. | `string` | n/a | yes |
| <a name="input_lambda_compatible_runtimes"></a> [lambda\_compatible\_runtimes](#input\_lambda\_compatible\_runtimes) | A list of Runtimes this layer is compatible with. Up to 5 runtimes can be specified | `list(string)` | n/a | yes |
| <a name="input_lambda_create_async_latest_alias"></a> [lambda\_create\_async\_latest\_alias](#input\_lambda\_create\_async\_latest\_alias) | Whether to allow async event configuration on unqualified alias pointing to $LATEST version | `bool` | n/a | yes |
| <a name="input_lambda_create_current_async_alias"></a> [lambda\_create\_current\_async\_alias](#input\_lambda\_create\_current\_async\_alias) | Whether to allow async event configuration on current version of Lambda Function | `bool` | n/a | yes |
| <a name="input_lambda_create_current_trigger_alias"></a> [lambda\_create\_current\_trigger\_alias](#input\_lambda\_create\_current\_trigger\_alias) | Whether to allow triggers on current version of Lambda Function | `bool` | n/a | yes |
| <a name="input_lambda_create_latest_alias"></a> [lambda\_create\_latest\_alias](#input\_lambda\_create\_latest\_alias) | Whether to use unqualified alias pointing to $LATEST version in Lambda Function URL | `bool` | n/a | yes |
| <a name="input_lambda_create_layer"></a> [lambda\_create\_layer](#input\_lambda\_create\_layer) | Controls whether Lambda Layer resource should be created | `bool` | n/a | yes |
| <a name="input_lambda_create_package"></a> [lambda\_create\_package](#input\_lambda\_create\_package) | Controls whether Lambda package should be created | `bool` | n/a | yes |
| <a name="input_lambda_create_trigger_latest_alias"></a> [lambda\_create\_trigger\_latest\_alias](#input\_lambda\_create\_trigger\_latest\_alias) | Whether to allow triggers on unqualified alias pointing to $LATEST version | `bool` | n/a | yes |
| <a name="input_lambda_description"></a> [lambda\_description](#input\_lambda\_description) | Description of Lambda function | `string` | `""` | no |
| <a name="input_lambda_handler"></a> [lambda\_handler](#input\_lambda\_handler) | Name of the Lambda Function entrypoint in code | `string` | n/a | yes |
| <a name="input_lambda_memory_size"></a> [lambda\_memory\_size](#input\_lambda\_memory\_size) | The amount of memory in MB for Lambda function to use at runtime | `number` | n/a | yes |
| <a name="input_lambda_name"></a> [lambda\_name](#input\_lambda\_name) | Name of the Lambda function | `string` | `null` | no |
| <a name="input_lambda_publish_new_version"></a> [lambda\_publish\_new\_version](#input\_lambda\_publish\_new\_version) | Whether to publish creation/change as new Lambda Function Version | `bool` | n/a | yes |
| <a name="input_lambda_runtime"></a> [lambda\_runtime](#input\_lambda\_runtime) | Lambda Function runtime | `string` | n/a | yes |
| <a name="input_lambda_source_path"></a> [lambda\_source\_path](#input\_lambda\_source\_path) | The absolute path to a local file or directory containing your Lambda source code | `string` | n/a | yes |
| <a name="input_lambda_timeout"></a> [lambda\_timeout](#input\_lambda\_timeout) | The amount of time Lambda function has to run in seconds, before being timed out | `number` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_protocol_type"></a> [protocol\_type](#input\_protocol\_type) | The API protocol. Valid values: HTTP, WEBSOCKET | `string` | n/a | yes |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apigatewayv2_api_api_endpoint"></a> [apigatewayv2\_api\_api\_endpoint](#output\_apigatewayv2\_api\_api\_endpoint) | The URI of the API |
| <a name="output_apigatewayv2_api_arn"></a> [apigatewayv2\_api\_arn](#output\_apigatewayv2\_api\_arn) | The ARN of the API |
| <a name="output_apigatewayv2_api_id"></a> [apigatewayv2\_api\_id](#output\_apigatewayv2\_api\_id) | The API identifier |
| <a name="output_default_apigatewayv2_stage_arn"></a> [default\_apigatewayv2\_stage\_arn](#output\_default\_apigatewayv2\_stage\_arn) | The default stage ARN |
| <a name="output_default_apigatewayv2_stage_id"></a> [default\_apigatewayv2\_stage\_id](#output\_default\_apigatewayv2\_stage\_id) | The default stage identifier |
| <a name="output_default_apigatewayv2_stage_invoke_url"></a> [default\_apigatewayv2\_stage\_invoke\_url](#output\_default\_apigatewayv2\_stage\_invoke\_url) | The URL to invoke the API pointing to the stage |
| <a name="output_lambda_function_arn"></a> [lambda\_function\_arn](#output\_lambda\_function\_arn) | The ARN of the Lambda Function |
| <a name="output_lambda_function_invoke_arn"></a> [lambda\_function\_invoke\_arn](#output\_lambda\_function\_invoke\_arn) | The Invoke ARN of the Lambda Function |
| <a name="output_lambda_function_last_modified"></a> [lambda\_function\_last\_modified](#output\_lambda\_function\_last\_modified) | The date Lambda Function resource was last modified |
| <a name="output_lambda_function_name"></a> [lambda\_function\_name](#output\_lambda\_function\_name) | The name of the Lambda Function |
| <a name="output_lambda_function_qualified_arn"></a> [lambda\_function\_qualified\_arn](#output\_lambda\_function\_qualified\_arn) | The ARN identifying your Lambda Function Version |
| <a name="output_lambda_function_qualified_invoke_arn"></a> [lambda\_function\_qualified\_invoke\_arn](#output\_lambda\_function\_qualified\_invoke\_arn) | The Invoke ARN identifying your Lambda Function Version |
| <a name="output_lambda_function_source_code_hash"></a> [lambda\_function\_source\_code\_hash](#output\_lambda\_function\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file |
| <a name="output_lambda_function_source_code_size"></a> [lambda\_function\_source\_code\_size](#output\_lambda\_function\_source\_code\_size) | The size in bytes of the function .zip file |
| <a name="output_lambda_function_url"></a> [lambda\_function\_url](#output\_lambda\_function\_url) | The URL of the Lambda Function URL |
| <a name="output_lambda_function_version"></a> [lambda\_function\_version](#output\_lambda\_function\_version) | Latest published version of Lambda Function |
