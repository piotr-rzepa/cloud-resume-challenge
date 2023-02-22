import json
import logging
import os

import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

client = boto3.resource("dynamodb", region_name=os.getenv("REGION", "eu-west-1"))

dynamodb_table = client.Table(os.getenv("DYNAMODB_TABLE"))


def handler(event, context):
    response = dynamodb_table.get_item(Key={"CounterName": "visitorsCounter"})

    if "Item" not in response:
        logging.info("No Visitor Counter in DynamoDB Table. Creating...")
        dynamodb_table.put_item(
            Item={"CounterName": "visitorsCounter", "visits": 0},
        )
        currentVisitCount = 1
    else:
        # Convert from decimal.Decimal to int
        currentVisitCount = int(response["Item"]["visits"]) + 1

    logging.info("Incrementing visits counter by 1")
    dynamodb_table.update_item(
        Key={"CounterName": "visitorsCounter"},
        UpdateExpression="SET visits = visits + :newVisitor",
        ExpressionAttributeValues={":newVisitor": 1},
    )

    data = {"visits": currentVisitCount}

    response = {
        "statusCode": 200,
        "body": json.dumps(data),
        "headers": {
            "Content-Type": "application/json",
            "Access-Control-Allow-Headers": "Content-Type, Origin",
            "Access-Control-Allow-Origin": os.getenv("WEBSITE_CLOUDFRONT_DOMAIN", "*"),
            "Access-Control-Allow-Methods": "OPTIONS,POST,GET",
        },
    }

    return response
