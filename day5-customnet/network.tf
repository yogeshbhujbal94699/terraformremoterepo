# creating a custom vpc
resource "aws_vpc" "prod" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "prod"
    }
}

#creating a custom subnet
resource "aws_subnet" "subnet1" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "subnet1"
    }
}
#crfeating a custom private subnet
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.prod.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "private_subnet"
    }
}
# creating a custom internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.prod.id
    tags = {
        Name = "igw"
    }
}
#creating a custom route table
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
#creating a custom route table association
resource "aws_route_table_association" "name" {
    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.subnet1.id
    
}
#creating a custom nat gateway
 #creating a custom elastic ip
resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "eip"
  }
}
resource "aws_nat_gateway" "nat" {
    allocation_id = aws_eip.eip.id
    subnet_id = aws_subnet.private_subnet.id
    tags = {
        Name = "nat"
    }
}
#creating a custom private route table
resource "aws_route_table" "private_rt" {
    vpc_id = aws_vpc.prod.id
    route { 
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.nat.id
    }
    tags = {
        Name = "private_rt"
    }
}
#creating a custom private route table association
resource "aws_route_table_association" "name1" {
    route_table_id = aws_route_table.private_rt.id
    subnet_id = aws_subnet.private_subnet.id
}



#creating a custom security group
resource "aws_security_group" "sg" {
    name = "sg"
    description = "Allow SSH and HTTP"
    vpc_id = aws_vpc.prod.id

    ingress {
        from_port = 22
        to_port = 22
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
