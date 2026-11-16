
def lambda_handler(event, context):
    return {
        "statusCode": 200,
        "body": "Hello from Terraform Lambda!"
    }

# For creating zip file--
# In bash terminal type below command 
#  python -m zipfile -c lambda_function.zip lambda_function.py
