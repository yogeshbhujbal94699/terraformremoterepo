terraform {
    backend "s3" {
        bucket = "yogesh83"
        key = "terraform.tfstate"
        region = "ap-south-1"
    }
}