# calling default ami
data "aws_ami" "amazon" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
    filter {
        name = "root-device-type"
        values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#calling custom ami created by me
# data "aws_ami" "amazon" {
#   most_recent = true

#   owners = ["self"]

#   filter {
#     name   = "name"
#     values = ["<ami name>"]
#   }    
# }

data "aws_subnet" "select" {
    filter {
        name = "tag:Name"
        values = ["subnet1"]     #insert subnet value here which already  available in aws console
    }
}

resource "aws_instance" "ec2" {
    ami = data.aws_ami.amazon.id
    instance_type = "t3.micro"
    key_name = "south"
    subnet_id = data.aws_subnet.select.id

}