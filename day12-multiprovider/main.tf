provider "aws" {
    region = "ap-south-1"
}
provider "aws" {
    region = "us-east-1"
    alias = "yogesh"
  
}
resource "aws_s3_bucket" "bucket" {
    bucket = "yogesh9689"
    provider = aws.yogesh           #bucket will create in us region
}
resource "aws_instance" "ec2" {
    ami = ""
    instance_type = "t3.micro"
    key_name = "south"               #instance will create in default region that is ap-south-1
    tags = {
        Name = "ec2"
    }
  
}