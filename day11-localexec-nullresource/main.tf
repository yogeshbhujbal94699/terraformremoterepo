
provider "aws" {
  region = "ap-south-1"
}

# Create S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-demo-bucket-2026-unique"

  tags = {
    Name = "MyS3Bucket"
  }
}

# Create EC2 Instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}

# Null Resource with Local Exec
resource "null_resource" "s3_provisioner" {

  depends_on = [
    aws_s3_bucket.my_bucket,
    aws_instance.my_ec2
  ]

  provisioner "local-exec" {
    command = "aws s3 ls"

    environment = {
      BUCKET_NAME = aws_s3_bucket.my_bucket.bucket
      EC2_IP      = aws_instance.my_ec2.public_ip
    }
  }

  provisioner "local-exec" {
    command = "aws s3 ls s3://${aws_s3_bucket.my_bucket.bucket}"
  }

  provisioner "local-exec" {
    command = "echo S3 Bucket Created Successfully"
  }
}

# Outputs
output "s3_bucket_name" {
  value = aws_s3_bucket.my_bucket.bucket
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
