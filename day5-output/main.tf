resource "aws_instance" "dev" {
    ami = "ami-04b0b8ee9ce90920a"
    instance_type = "t3.micro"
    key_name = "south"
    subnet_id = "subnet-0c559f43e0ae4d2bc"
    associate_public_ip_address = true
    tags = {
        Name = "dev"
    }
  
}