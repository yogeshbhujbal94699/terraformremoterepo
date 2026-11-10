resource "aws_instance" "name" {
    ami = "ami-0f19324397f53458f"
    instance_type = "t3.micro"
    key_name = "cloud"
    subnet_id = "subnet-0f3e1c8d9e1f2a1b2"
  
}
