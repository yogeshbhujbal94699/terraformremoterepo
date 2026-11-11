terraform {
  backend "s3" {
    bucket = "yogesh9689"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
