variable "layer" {
    type = string
    default = "web"
}
variable "env" {
    type = string
    default = "test"
}

locals {
  bucket-name = "${var.layer}-${var.env}-bucket-yogesh9689"
}

resource "aws_s3_bucket" "demo" {
    # bucket = "web-test-bucket-yogesh9689"
    # bucket = "${var.layer}-{var.env}-bucket-yogesh9689"
    bucket = local.bucket-name
    tags = {
        # Name = "${var.layer}-{var.env}-bucket-yogesh9689"
        Name = local.bucket-name
    }
  
}


#example-2

provider "aws" {

}

locals {
  region = "ap-south-1"
  environment = "dev"
  instance_type = "t3.micro"
  ami = "ami-04b0b8ee9ce90920a"
}

resource "aws_instance" "ec2" {
    instance_type = local.instance_type
    ami = local.ami
    tags = {
        Name = "ec2"
        Environment = local.environment
    }
  
}