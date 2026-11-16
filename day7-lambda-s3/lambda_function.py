def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": "Hello from Terraform yogesh!"
    }

# For creating zip file in s3 bucket
# type below code in bash terminal
# python -m zipfile -c lambda.zip lambda_function.py 