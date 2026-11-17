provider "aws" {

}

resource "aws_s3_bucket" "bucket" {
    bucket = "yogesh9689"
}

resource "aws_instance" "ec2" {
    ami = "ami-04b0b8ee9ce90920a"
    instance_type = "t3.micro"
    key_name = "south"
    subnet_id = "subnet-028a37779c89cde0c"
    depends_on = [aws_s3_bucket.bucket]  #it means that first should create s3 bucket and then ec2 instance
}