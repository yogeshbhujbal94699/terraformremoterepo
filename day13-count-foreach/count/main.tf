# # example-1 for same name 
# resource "aws_instance" "yogesh" {
#     ami = "ami-04b0b8ee9ce90920a"
#     instance_type = "t3.micro"
#     key_name = "south"
#     subnet_id = "subnet-00528fc82d6075296"
#     count = 3
    
#     # tags = {
#     #     Name = "yogesh"  # three resources will create on same name yogesh 
#     # }
#      tags = {
#         Name = "yogesh-${count.index}"    #three resources will create with names yogesh-0, yogesh-1, yogesh-2
#     }

# }

#example-2 for different names
variable "cloud" {
    type = list(string)
    default = [ "dev", "test", "prod" ]
}
resource "aws_instance" "yogesh" {
    ami = "ami-04b0b8ee9ce90920a"
    instance_type = "t3.micro"
    key_name = "south"
    subnet_id = "subnet-00528fc82d6075296"
    count = length(var.cloud)

     tags = {
        Name = var.cloud[count.index]    
    }

}
#if we remove dev value in default section once we apply terraform, prod gets deleted as it acts from last 
# and dev name will change to test and test name will change to prod ...2 changed and 1 destroyed 

#same if we remove test then prod gets deleted and test name change to prod
# 1 chnaged and 1 destryed

#same if we remove prod onle prod gets deleted as it acts from last
# 1 destroyed 0 changed
 
#due to above such practice count function is not best practice so for_each we can use