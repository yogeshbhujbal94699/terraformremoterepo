
provider "aws" {
  
}

# Create S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "yogesh9689"

  tags = {
    Name = "bucket"
  }
}

# Create Key Pair
resource "aws_key_pair" "my_key" {
  key_name   = "cloud"
  public_key = file("C:/Users/Dell/.ssh/id_ed25519.pub")
}

# Create EC2 Instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = aws_key_pair.my_key.key_name
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
    tags = {
    Name = "EC2"
  }
}


# IAM Role for EC2 to access S3
resource "aws_iam_role" "ec2_role" {
  name = "terraform-ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "s3_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "terraform-ec2-profile"
  role = aws_iam_role.ec2_role.name
}

# Null Resource with Remote Exec
resource "null_resource" "s3_provisioner" {

  depends_on = [
    aws_s3_bucket.my_bucket,
    aws_instance.my_ec2
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("C:/Users/Dell/.ssh/id_ed25519")
    host        = aws_instance.my_ec2.public_ip
    timeout     = "5m"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Connected to EC2 successfully'",
      "sudo apt update -y",
      "sudo apt install awscli -y",
      "aws s3 ls",
      "aws s3 ls s3://${aws_s3_bucket.my_bucket.bucket}",
      "echo 'S3 bucket verification completed'"
    ]
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.bucket
}

output "ec2_public_ip" {
  value = aws_instance.my_ec2.public_ip
}
