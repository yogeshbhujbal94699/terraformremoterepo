resource "aws_instance" "ec2-userdata" {
    ami = "ami-04b0b8ee9ce90920a"
    instance_type = "t3.micro"
    key_name = "south"
    subnet_id = "subnet-00528fc82d6075296"
    user_data = file("test.sh")
    associate_public_ip_address = true
    tags = {
        Name = "ec2-userdata"

    }
}