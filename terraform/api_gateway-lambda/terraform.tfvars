protocol_type          = "HTTP"
allowed_http_headers   = ["content-type", "x-amz-date", "authorization", "x-api-key", "x-amz-security-token", "x-amz-user-agent", "origin"]
allowed_http_methods   = ["GET", "POST", "OPTIONS"]
create_api_domain_name = false
create_vpc_link        = false
name                   = "api-gateway"

lambda_description                  = "Lambda function for handling visitors' count of Cloud Resume Challenge page"
lambda_handler                      = "app.handler"
lambda_runtime                      = "python3.10"
lambda_compatible_runtimes          = ["python3.10", "python3.9", "python3.8"]
lambda_architectures                = ["x86_64"]
lambda_source_path                  = "../../src/backend/lambda"
lambda_publish_new_version          = true
lambda_create_package               = true
lambda_create_layer                 = false
lambda_create_latest_alias          = true
lambda_create_async_latest_alias    = false
lambda_create_trigger_latest_alias  = true
lambda_create_current_async_alias   = false
lambda_create_current_trigger_alias = true
lambda_authorization_type           = "AWS_IAM"
lambda_memory_size                  = 128
lambda_timeout                      = 15
