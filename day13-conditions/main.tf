# # example-1
# provider "aws" {

# }
# variable "cloud" {
#     description = "set to true to create bucket"
#     type = bool
#     default = true

#     # description = "set to false to not create bucket"
#     # type = bool
#     # default = false  
# }
 
# resource "random_string" "suffix" {   # to generate a unique 8-character suffix
#     count = var.cloud ? 1 : 0 # if default is true it will count as 1 and bucket will create
#     length = 8           # if default is false it will count as 0 and bucket will not be create or random string/bucket created
#     special = false
#     upper = false
# }

# resource "aws_s3_bucket_acl" "bucket" {
#   count = var.cloud ? 1 : 0
# #   bucket = "my-conditional-bucket-${random_string.suffix[count.index].id}"
#   bucket = "yogesh9689"
#   acl = "private"

# }


# example-2
provider "aws" {
  
}

variable "aws_region" {
    description = "the region in which to create infrastructure"
    type = string
    nullable = false    # optional 
    default = "ap-south-1"  #here we need to define ap-south-1 or us-east-1. If i give other region error will occure
    validation {
      condition = var.aws_region == "ap-south-1" || var.aws_region == "us-east-1"
      error_message = "the variable 'aws_region must be one of the following regions: ap-south-1, us-east-1"
    }

}
resource "aws_s3_bucket" "bucket" {
  bucket = "yogesh9689"
}