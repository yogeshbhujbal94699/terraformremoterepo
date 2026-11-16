

# Fetch existing IAM role
data "aws_iam_role" "existing_role" {
  name = "lambda"
}

# Fetch existing S3 object
data "aws_s3_object" "mybucket" {
  bucket = "yogesh83"
  key    = "day5/lambda.zip"
}

# Create Lambda function using existing S3 ZIP
resource "aws_lambda_function" "my_lambda" {
  function_name = "my-existing-s3-lambda"

  role = data.aws_iam_role.existing_role.arn

  runtime = "python3.12"
  handler = "lambda_function.lambda_handler"

  s3_bucket         = data.aws_s3_object.mybucket.bucket
  s3_key            = data.aws_s3_object.mybucket.key
}
