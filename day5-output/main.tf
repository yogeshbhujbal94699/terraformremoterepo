resource "aws_instance" "dev" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name
    subnet_id = var.subnet_id
    associate_public_ip_address = true
    tags = {
        Name = var.Name
    }
  
}