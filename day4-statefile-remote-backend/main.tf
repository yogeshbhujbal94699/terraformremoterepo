resource "aws_instance" "name" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = var.key_name  
    subnet_id = var.subnet_id
    tags = {
        Name = var.Name
    }

}   
resource "aws_s3_bucket" "name" {
    bucket = var.bucket
}



