include "root" {
    path = find_in_parent_folders()
}

dependency "dynamodb" {
    config_path = "../dynamodb"
}

dependency "cloudfront" {
    config_path = "../s3-cloudfront"
}

inputs = {
    dynamodb_table_name = dependency.dynamodb.outputs.dynamodb_table_id
    cloudfront_domain_name = dependency.cloudfront.outputs.cloudfront_distribution_domain_name
}
