# create vpc 
resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "prod"
    }
}
# create public subnet
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "public"
    }
}
#create private subnet
resource "aws_subnet" "private" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "private"
    }
}
#create internet gateway
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.prod.id
    tags = {
        Name = "igw"
    }
}
#create route table and edit route
resource "aws_route_table" "rt" {
    vpc_id = aws_vpc.prod.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = { 
        Name = "rt"
    }
}
#create route table association
resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.public.id
}
#create nat gateway
#create elastic ip
resource "aws_eip" "janeman" {
    domain = "vpc"
    tags = {
        Name = "janeman"
    }
}
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.janeman.id 
    subnet_id = aws_subnet.private.id
    tags = {
        Name = "nat"
    }
}
#create private route table and edit route
resource "aws_route_table" "prt" {
    vpc_id = aws_vpc.prod.id
    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "prt"
    }
}
#create private route table association
resource "aws_route_table_association" "name1" {
    route_table_id = aws_route_table.prt.id
    subnet_id = aws_subnet.private.id

}
#craete security group
resource "aws_security_group" "sg" {
    name = "sg"
    description = "allow ssh and http"
    vpc_id = aws_vpc.prod.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "sg"
    }

}