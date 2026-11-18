variable "aws_region" {
    description = "The aws region to deploy resources in"
    type = string
    default = "ap-south-1"
}

variable "aws_profile" {
    description = "the aws cli profile to use for authentication"
    type = string
    default = "" #replace with your profile name if not using default
}
  