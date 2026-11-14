#creating a custom ec2 instance
resource "aws_instance" "ec2" {
    ami = "ami-04b0b8ee9ce90920a"
    instance_type = "t3.micro"
    key_name = "south"
    subnet_id = aws_subnet.subnet1.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "ec2"
    }
}
#creating a custom private ec2 instance
resource "aws_instance" "private_ec2" {
    ami = "ami-04b0b8ee9ce90920a"
    instance_type = "t3.micro"
    key_name = "south"  
    subnet_id = aws_subnet.private_subnet.id
    vpc_security_group_ids = [aws_security_group.sg.id]
    tags = {
        Name = "private_ec2"
    }
}