variable "cloud" {
    type = list(string)
    default = [ "dev", "prod" ]
}
resource "aws_instance" "yogesh" {
    ami = "ami-04b0b8ee9ce90920a"
    instance_type = "t3.micro"
    key_name = "south"
    subnet_id = "subnet-00528fc82d6075296"
    for_each = toset(var.cloud)
    # count = length(var.cloud) 

     tags = {
        Name = each.value  #for a set each.value and each.key is the same
    }
}
# so if i remove test from above so only test wull gets deleted not prod and test will change to prod like in count
# only 1 destroyed