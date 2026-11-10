resource "aws_instance" "name" {
  ami = var.ami
  instance_type = "t3.nano"
  key_name = var.key
  subnet_id = var.subnet
}
