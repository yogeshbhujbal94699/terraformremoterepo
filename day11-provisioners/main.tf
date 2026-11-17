provider "aws" {

}

#create custom keypair using terraform
resource "aws_key_pair" "example" {     
    key_name = "cloud"  
    public_key = file("C:/Users/Dell/.ssh/id_ed25519.pub")    #public key path created through ssh-keygen 
}

#custom VPC
resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "myvpc"
    }
}

#custom subnet
resource "aws_subnet" "public"{
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "public"
    }
}

#create internet gateway
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
    tags = {
        Name = "igw"
    }
}

#create route table
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt"
  }
}

#create route table association
resource "aws_route_table_association" "rta" {
    route_table_id = aws_route_table.rt.id
    subnet_id = aws_subnet.public.id
  
}

#create securiity group
resource "aws_security_group" "mysg" {
     name = "mysg"
    description = "allow ssh "
    vpc_id = aws_vpc.myvpc.id
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
        Name = "mysg"
    }

}

#create ec2 instance
resource "aws_instance" "ec2" {
    ami = "ami-04b21f8ea06746e05"
    instance_type = "t3.micro"
    key_name = aws_key_pair.example.key_name
    subnet_id = aws_subnet.public.id
    vpc_security_group_ids = [aws_security_group.mysg.id]
    associate_public_ip_address = true

#connect ec2 instance
    connection{
        type = "ssh"
        user = "ec2-user"
        private_key = file("C:/Users/Dell/.ssh/id_ed25519")  #private key path
        # private_key = file("C:/Users/Dell/OneDrive/yogesh/south.pem")  
        host = self.public_ip
        agent = false
    
    }

#local execution process
provisioner "local-exec" {
    command = "touch file500"      #mysql -h -u -p <test.sql
}

#file provisioner to copy file from local to the remote EC2 instance
provisioner "file" {
    source = "file10"  #replace with the path to your local file
    destination = "/home/ec2-user/file10" #replace with the path on remote instance
}

#remote execution process
provisioner "remote-exec" {
    inline = [
"touch file200",               #mysql -h -u -p <test.sql
"echo hello from aws >> file200",
]
}
}