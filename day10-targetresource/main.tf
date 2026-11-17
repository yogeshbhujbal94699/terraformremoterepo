provider "aws" {

}
resource "aws_s3_bucket" "bucket" {
  bucket = "yogesh9689"
}

resource "aws_instance" "ec2" {
  ami           = "ami-04b21f8ea06746e05"
  instance_type = "t3.micro"
  key_name      = "south"

}
# if want to create/delete specific resource instead of multiple resource
# terraform apply/delete -target=aws_s3_bucket.bucket -auto-approve

# for multiple resources
#a) terraform apply/delete -target=resource1 -target=resource2 and so on.... 
