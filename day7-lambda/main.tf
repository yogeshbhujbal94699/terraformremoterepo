#     ---For creating new IAM role--- 
# resource "aws_iam_role" "new_lambda_role" {
#   name = "terraform-lambda-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [{
#       Action = "sts:AssumeRole"
#       Effect = "Allow"
#       Principal = {
#         Service = "lambda.amazonaws.com"
#       }
#     }]
#   })
# }

# For creating existing IAM role
data "aws_iam_role" "existing_role" {
  name = var.name     # already created through console approach
}
# for attaching policy for new IAM role---
# resource "aws_iam_role_policy_attachment" "lambda_policy" {
#   role = aws_iam_role.new_lambda_role.name

#   policy_arn = "arn:aws:iam::aws:policy/service-role/<policy name>"
# }

# For attaching policy for existing IAM role--
# resource "aws_iam_role_policy_attachment" "lambda_policy" {
#   role = data.aws_iam_role.existing_role.name

#   policy_arn = "arn:aws:iam::aws:policy/service-role/<policy name>"
# }

resource "aws_lambda_function" "my_lambda" {
  function_name = var.function_name
#   role          = aws_iam_role.new_lambda_role.arn  <-- for attaching new role
    role = data.aws_iam_role.existing_role.arn   # <--- for attaching existing role
    # role = "arn:aws:iam::684304642738:role/lambda"  <-- u can directly give ARN also instaed of calling
  runtime = var.runtime
  handler = var.handler
  timeout = var.timeout
  memory_size = var.memory_size

  filename         = var.filename
  source_code_hash = filebase64sha256("lambda_function.zip")
}
