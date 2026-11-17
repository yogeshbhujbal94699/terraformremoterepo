data "aws_vpc" "select" {
    filter {
        name = "tag:Name"
        values = ["myvpc"]     #insert vpc value here which already  available in aws console
    }
}
data "aws_subnet" "select" {
    filter {
        name = "tag:Name"
        values = ["subnet1"]     #insert subnet value here which already  available in aws console
    }
}
data "aws_security_groups" "select" {
    filter {
        name = "tag:Name"
        values = ["mysg"]     #insert security group value here which already  available in aws console
    }
}
resource "aws_instance" "ec2" {
    ami = "ami-04b0b8ee9ce90920a"
    instance_type = "t3.micro"
    key_name = "south"
    
    subnet_id = data.aws_subnet.select.id #instaed of putting hard coded value use datasource value
    vpc_security_group_ids = data.aws_security_groups.select.ids
}