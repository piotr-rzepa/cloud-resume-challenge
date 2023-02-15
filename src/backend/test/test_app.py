import importlib
import json
import os
import sys
from unittest import mock

import boto3
import pytest
from moto import mock_dynamodb

sys.path.append("src/backend")


@pytest.fixture()
def aws_credentials():
    """Mocked AWS Credentials for moto library."""
    os.environ["AWS_ACCESS_KEY_ID"] = "testing"
    os.environ["AWS_SECRET_ACCESS_KEY"] = "testing"
    os.environ["AWS_SECURITY_TOKEN"] = "testing"
    os.environ["AWS_SESSION_TOKEN"] = "testing"
    os.environ["AWS_DEFAULT_REGION"] = "us-east-1"
    os.environ["DYNAMODB_TABLE"] = "test-dynamodb"
    os.environ["WEBSITE_CLOUDFRONT_DOMAIN"] = "http://localhost"


@mock_dynamodb
def test_lambda_handler_existing_entries(aws_credentials):
    """Testing visitors updating when there are entries available in dynamodb table."""
    app_module = importlib.import_module("lambda.app")
    table = app_module.client.create_table(
        TableName=os.getenv("DYNAMODB_TABLE"),
        KeySchema=[{"AttributeName": "CounterName", "KeyType": "HASH"}],
        AttributeDefinitions=[
            {
                "AttributeName": "CounterName",
                "AttributeType": "S",
            },
        ],
        ProvisionedThroughput={"ReadCapacityUnits": 1, "WriteCapacityUnits": 1},
    )
    table.wait_until_exists()

    app_module.dynamodb_table.put_item(
        Item={"CounterName": "visitorsCounter", "visits": 1},
    )

    response = app_module.handler({}, {})

    assert response["statusCode"] == 200
    assert response["body"] == json.dumps({"visits": 2})
    assert response["headers"]["Content-Type"] == "application/json"
    assert response["headers"]["Access-Control-Allow-Headers"] == "Content-Type, Origin"
    assert response["headers"]["Access-Control-Allow-Origin"] == "http://localhost"
    assert response["headers"]["Access-Control-Allow-Methods"] == "OPTIONS,POST,GET"

    dynamodb_response = app_module.dynamodb_table.get_item(
        Key={"CounterName": "visitorsCounter"}
    )

    assert int(dynamodb_response["Item"]["visits"]) == 2


@mock_dynamodb
def test_lambda_handler_empty_table(aws_credentials):
    """Testing visitors updating when there are no entries in dynamodb table."""
    app_module = importlib.import_module("lambda.app")
    table = app_module.client.create_table(
        TableName=os.getenv("DYNAMODB_TABLE"),
        KeySchema=[{"AttributeName": "CounterName", "KeyType": "HASH"}],
        AttributeDefinitions=[
            {
                "AttributeName": "CounterName",
                "AttributeType": "S",
            },
        ],
        ProvisionedThroughput={"ReadCapacityUnits": 1, "WriteCapacityUnits": 1},
    )
    table.wait_until_exists()

    response = app_module.handler({}, {})

    assert response["statusCode"] == 200
    assert response["body"] == json.dumps({"visits": 1})
    assert response["headers"]["Content-Type"] == "application/json"
    assert response["headers"]["Access-Control-Allow-Headers"] == "Content-Type, Origin"
    assert response["headers"]["Access-Control-Allow-Origin"] == "http://localhost"
    assert response["headers"]["Access-Control-Allow-Methods"] == "OPTIONS,POST,GET"

    dynamodb_response = app_module.dynamodb_table.get_item(
        Key={"CounterName": "visitorsCounter"}
    )

    assert int(dynamodb_response["Item"]["visits"]) == 1
