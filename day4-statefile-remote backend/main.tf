resource "aws_instance" "name" {
    ami = "ami-05fbd65e334e88c16"
    instance_type = "t3.micro"
    key_name = "south"
    subnet_id = "subnet-077e35484843c5975"
    tags = {
        Name = "public"
    }
  
}

resource "aws_s3_bucket" "name" {
     bucket = "yogesh96897"
    
}