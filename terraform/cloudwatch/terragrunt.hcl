include "root" {
    path = find_in_parent_folders()
}

dependency "lambda" {
    config_path = "../api_gateway-lambda"
}

dependency "sns" {
    config_path = "../sns"
}

inputs = {
    lambda_function_name = dependency.lambda.outputs.lambda_function_name
    sns_topic_arn = dependency.sns.outputs.topic_arn
}
