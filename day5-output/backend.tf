terraform {
    backend "s3" {
        bucket = "yogesh83"
        key = "day5/terraform.tfstate"
        region = "ap-south-1"
        use_lockfile = true
        encrypt = true
    }
}