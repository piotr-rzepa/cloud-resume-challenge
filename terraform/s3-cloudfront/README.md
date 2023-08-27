## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.5 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.7.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | terraform-aws-modules/cloudfront/aws | ~> 3.2 |
| <a name="module_cloudfront-label"></a> [cloudfront-label](#module\_cloudfront-label) | cloudposse/label/null | ~> 0.25 |
| <a name="module_s3-bucket"></a> [s3-bucket](#module\_s3-bucket) | terraform-aws-modules/s3-bucket/aws | ~> 3.14 |
| <a name="module_s3-label"></a> [s3-label](#module\_s3-label) | cloudposse/label/null | ~> 0.25 |
| <a name="module_this"></a> [this](#module\_this) | cloudposse/label/null | 0.25.0 |

## Resources

| Name | Type |
|------|------|
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.bucket_policy_cloudfront](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tag_map"></a> [additional\_tag\_map](#input\_additional\_tag\_map) | Additional key-value pairs to add to each map in `tags_as_list_of_maps`. Not added to `tags` or `id`.<br>This is for some rare cases where resources want additional configuration of tags<br>and therefore take a list of maps with tag key, value, and additional configuration. | `map(string)` | `{}` | no |
| <a name="input_attributes"></a> [attributes](#input\_attributes) | ID element. Additional attributes (e.g. `workers` or `cluster`) to add to `id`,<br>in the order they appear in the list. New attributes are appended to the<br>end of the list. The elements of the list are joined by the `delimiter`<br>and treated as a single ID element. | `list(string)` | `[]` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | AWS Region where resources will be deployed | `string` | n/a | yes |
| <a name="input_cf_cache_allowed_methods"></a> [cf\_cache\_allowed\_methods](#input\_cf\_cache\_allowed\_methods) | List of HTTP methods allowed by ths distribution | `list(string)` | n/a | yes |
| <a name="input_cf_cache_cached_methods"></a> [cf\_cache\_cached\_methods](#input\_cf\_cache\_cached\_methods) | List of cachable HTTP methods by this distirbution | `list(string)` | n/a | yes |
| <a name="input_cf_cache_response_headers_policy_id"></a> [cf\_cache\_response\_headers\_policy\_id](#input\_cf\_cache\_response\_headers\_policy\_id) | The ID of AWS managed cache policy for CloudFront, which adds or removes headers in responses to viewers | `string` | n/a | yes |
| <a name="input_cf_cache_viewer_protocol_policy"></a> [cf\_cache\_viewer\_protocol\_policy](#input\_cf\_cache\_viewer\_protocol\_policy) | How to handle HTTP and HTTPS request to CloudFront | `string` | n/a | yes |
| <a name="input_cf_create_oac"></a> [cf\_create\_oac](#input\_cf\_create\_oac) | Set to true to create CloudFront Origin Access Control | `bool` | n/a | yes |
| <a name="input_cf_default_root_object"></a> [cf\_default\_root\_object](#input\_cf\_default\_root\_object) | The object that you want CloudFront to return when an end user requests the root URL | `string` | `"index.html"` | no |
| <a name="input_cf_description"></a> [cf\_description](#input\_cf\_description) | Comments about given distribution | `string` | `""` | no |
| <a name="input_cf_http_version"></a> [cf\_http\_version](#input\_cf\_http\_version) | The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3, and http3. The default is http2 | `string` | n/a | yes |
| <a name="input_cf_is_ipv6_enabled"></a> [cf\_is\_ipv6\_enabled](#input\_cf\_is\_ipv6\_enabled) | Set to true to enable IPv6 for the distribution | `bool` | n/a | yes |
| <a name="input_cf_oac_description"></a> [cf\_oac\_description](#input\_cf\_oac\_description) | Description of Origin Access Control for the Distribution | `string` | `""` | no |
| <a name="input_cf_oac_origin_type"></a> [cf\_oac\_origin\_type](#input\_cf\_oac\_origin\_type) | Type of the Origin for Origin Access Control | `string` | n/a | yes |
| <a name="input_cf_oac_signinig_behavior"></a> [cf\_oac\_signinig\_behavior](#input\_cf\_oac\_signinig\_behavior) | Wheter CloudFront should sign each request | `string` | n/a | yes |
| <a name="input_cf_oac_signinig_protocol"></a> [cf\_oac\_signinig\_protocol](#input\_cf\_oac\_signinig\_protocol) | What protocol to use for CloudFront to sign the requestes | `string` | n/a | yes |
| <a name="input_cf_price_class"></a> [cf\_price\_class](#input\_cf\_price\_class) | The price class for this distribution. One of PriceClass\_All, PriceClass\_200, PriceClass\_100 | `string` | n/a | yes |
| <a name="input_context"></a> [context](#input\_context) | Single object for setting entire context at once.<br>See description of individual variables for details.<br>Leave string and numeric variables as `null` to use default value.<br>Individual variable settings (non-null) override settings in context object,<br>except for attributes, tags, and additional\_tag\_map, which are merged. | `any` | <pre>{<br>  "additional_tag_map": {},<br>  "attributes": [],<br>  "delimiter": null,<br>  "descriptor_formats": {},<br>  "enabled": true,<br>  "environment": null,<br>  "id_length_limit": null,<br>  "label_key_case": null,<br>  "label_order": [],<br>  "label_value_case": null,<br>  "labels_as_tags": [<br>    "unset"<br>  ],<br>  "name": null,<br>  "namespace": null,<br>  "regex_replace_chars": null,<br>  "stage": null,<br>  "tags": {},<br>  "tenant": null<br>}</pre> | no |
| <a name="input_delimiter"></a> [delimiter](#input\_delimiter) | Delimiter to be used between ID elements.<br>Defaults to `-` (hyphen). Set to `""` to use no delimiter at all. | `string` | `null` | no |
| <a name="input_descriptor_formats"></a> [descriptor\_formats](#input\_descriptor\_formats) | Describe additional descriptors to be output in the `descriptors` output map.<br>Map of maps. Keys are names of descriptors. Values are maps of the form<br>`{<br>   format = string<br>   labels = list(string)<br>}`<br>(Type is `any` so the map values can later be enhanced to provide additional options.)<br>`format` is a Terraform format string to be passed to the `format()` function.<br>`labels` is a list of labels, in order, to pass to `format()` function.<br>Label values will be normalized before being passed to `format()` so they will be<br>identical to how they appear in `id`.<br>Default is `{}` (`descriptors` output will be empty). | `any` | `{}` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to prevent the module from creating any resources | `bool` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | ID element. Usually used for region e.g. 'uw2', 'us-west-2', OR role 'prod', 'staging', 'dev', 'UAT' | `string` | `null` | no |
| <a name="input_id_length_limit"></a> [id\_length\_limit](#input\_id\_length\_limit) | Limit `id` to this many characters (minimum 6).<br>Set to `0` for unlimited length.<br>Set to `null` for keep the existing setting, which defaults to `0`.<br>Does not affect `id_full`. | `number` | `null` | no |
| <a name="input_label_key_case"></a> [label\_key\_case](#input\_label\_key\_case) | Controls the letter case of the `tags` keys (label names) for tags generated by this module.<br>Does not affect keys of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper`.<br>Default value: `title`. | `string` | `null` | no |
| <a name="input_label_order"></a> [label\_order](#input\_label\_order) | The order in which the labels (ID elements) appear in the `id`.<br>Defaults to ["namespace", "environment", "stage", "name", "attributes"].<br>You can omit any of the 6 labels ("tenant" is the 6th), but at least one must be present. | `list(string)` | `null` | no |
| <a name="input_label_value_case"></a> [label\_value\_case](#input\_label\_value\_case) | Controls the letter case of ID elements (labels) as included in `id`,<br>set as tag values, and output by this module individually.<br>Does not affect values of tags passed in via the `tags` input.<br>Possible values: `lower`, `title`, `upper` and `none` (no transformation).<br>Set this to `title` and set `delimiter` to `""` to yield Pascal Case IDs.<br>Default value: `lower`. | `string` | `null` | no |
| <a name="input_labels_as_tags"></a> [labels\_as\_tags](#input\_labels\_as\_tags) | Set of labels (ID elements) to include as tags in the `tags` output.<br>Default is to include all labels.<br>Tags with empty values will not be included in the `tags` output.<br>Set to `[]` to suppress all generated tags.<br>**Notes:**<br>  The value of the `name` tag, if included, will be the `id`, not the `name`.<br>  Unlike other `null-label` inputs, the initial setting of `labels_as_tags` cannot be<br>  changed in later chained modules. Attempts to change it will be silently ignored. | `set(string)` | <pre>[<br>  "default"<br>]</pre> | no |
| <a name="input_name"></a> [name](#input\_name) | ID element. Usually the component or solution name, e.g. 'app' or 'jenkins'.<br>This is the only ID element not also included as a `tag`.<br>The "name" tag is set to the full `id` string. There is no tag with the value of the `name` input. | `string` | `null` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | ID element. Usually an abbreviation of your organization name, e.g. 'eg' or 'cp', to help ensure generated IDs are globally unique | `string` | `null` | no |
| <a name="input_regex_replace_chars"></a> [regex\_replace\_chars](#input\_regex\_replace\_chars) | Terraform regular expression (regex) string.<br>Characters matching the regex will be removed from the ID elements.<br>If not set, `"/[^a-zA-Z0-9-]/"` is used to remove all characters other than hyphens, letters and digits. | `string` | `null` | no |
| <a name="input_s3_attach_deny_incorrect_encryption_headers"></a> [s3\_attach\_deny\_incorrect\_encryption\_headers](#input\_s3\_attach\_deny\_incorrect\_encryption\_headers) | Set to true to make S3 bucket policy deny incorrect encryption headers policy | `bool` | n/a | yes |
| <a name="input_s3_attach_deny_incorrect_kms_key_sse"></a> [s3\_attach\_deny\_incorrect\_kms\_key\_sse](#input\_s3\_attach\_deny\_incorrect\_kms\_key\_sse) | Set to true to make S3 bucket policy deny usage of uncorreect KMS key SSE | `bool` | n/a | yes |
| <a name="input_s3_attach_deny_insecure_transport_policy"></a> [s3\_attach\_deny\_insecure\_transport\_policy](#input\_s3\_attach\_deny\_insecure\_transport\_policy) | Set to true to make S3 bucket policy deny non-SSL transport policy | `bool` | n/a | yes |
| <a name="input_s3_block_public_acls"></a> [s3\_block\_public\_acls](#input\_s3\_block\_public\_acls) | Set to true to make Amazon3 block public ACLs for this bucket | `bool` | n/a | yes |
| <a name="input_s3_block_public_policy"></a> [s3\_block\_public\_policy](#input\_s3\_block\_public\_policy) | Set to true to make Amazon3 block public bucket policies for this bucket | `bool` | n/a | yes |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | Name of the S3 Bucket | `string` | `null` | no |
| <a name="input_s3_force_destroy"></a> [s3\_force\_destroy](#input\_s3\_force\_destroy) | Set to true if all objects should be deleted from the bucket, so that the bucket can be destoryed without errors. | `bool` | n/a | yes |
| <a name="input_s3_ignore_public_acls"></a> [s3\_ignore\_public\_acls](#input\_s3\_ignore\_public\_acls) | Set to true to make Amazon S3 ignore public ACLs for this bucket | `bool` | n/a | yes |
| <a name="input_s3_object_lock_enabled"></a> [s3\_object\_lock\_enabled](#input\_s3\_object\_lock\_enabled) | Set to true to enable Object Lock configuration on a S3 Bucket | `bool` | n/a | yes |
| <a name="input_s3_restrict_public_buckets"></a> [s3\_restrict\_public\_buckets](#input\_s3\_restrict\_public\_buckets) | Set to true to make Amazon S3 restrict public bucket policies for this bucket | `bool` | n/a | yes |
| <a name="input_stage"></a> [stage](#input\_stage) | ID element. Usually used to indicate role, e.g. 'prod', 'staging', 'source', 'build', 'test', 'deploy', 'release' | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags (e.g. `{'BusinessUnit': 'XYZ'}`).<br>Neither the tag keys nor the tag values will be modified by this module. | `map(string)` | `{}` | no |
| <a name="input_tenant"></a> [tenant](#input\_tenant) | ID element \_(Rarely used, not included by default)\_. A customer identifier, indicating who this instance of a resource is for | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | The ARN of the S3 bucket |
| <a name="output_bucket_domain_name"></a> [bucket\_domain\_name](#output\_bucket\_domain\_name) | The bucket domain name. Will be of format bucketname.s3.amazonaws.com |
| <a name="output_bucket_id"></a> [bucket\_id](#output\_bucket\_id) | The name of the bucket |
| <a name="output_bucket_policy"></a> [bucket\_policy](#output\_bucket\_policy) | The policy of the bucket, if the bucket is configured with a policy |
| <a name="output_bucket_region"></a> [bucket\_region](#output\_bucket\_region) | The AWS region this bucket resides in |
| <a name="output_bucket_regional_domain_name"></a> [bucket\_regional\_domain\_name](#output\_bucket\_regional\_domain\_name) | The bucket region-specific domain name |
| <a name="output_cloudfront_distribution_arn"></a> [cloudfront\_distribution\_arn](#output\_cloudfront\_distribution\_arn) | The ARN (Amazon Resource Name) for the distribution |
| <a name="output_cloudfront_distribution_domain_name"></a> [cloudfront\_distribution\_domain\_name](#output\_cloudfront\_distribution\_domain\_name) | The domain name corresponding to the distribution |
| <a name="output_cloudfront_distribution_id"></a> [cloudfront\_distribution\_id](#output\_cloudfront\_distribution\_id) | The identifier for the distribution |
| <a name="output_cloudfront_distribution_last_modified_time"></a> [cloudfront\_distribution\_last\_modified\_time](#output\_cloudfront\_distribution\_last\_modified\_time) | The date and time the distribution was last modified |
| <a name="output_cloudfront_distribution_trusted_signers"></a> [cloudfront\_distribution\_trusted\_signers](#output\_cloudfront\_distribution\_trusted\_signers) | List of nested attributes for active trusted signers, if the distribution is set up to serve private content with signed URLs |
| <a name="output_cloudfront_origin_access_controls"></a> [cloudfront\_origin\_access\_controls](#output\_cloudfront\_origin\_access\_controls) | The origin access controls created |
| <a name="output_cloudfront_origin_access_controls_ids"></a> [cloudfront\_origin\_access\_controls\_ids](#output\_cloudfront\_origin\_access\_controls\_ids) | The IDS of the origin access identities created |
