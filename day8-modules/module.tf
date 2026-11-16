module "test" {
    source = "../day0-sourcecodeformodule"
    ami = "ami-05fbd65e334e88c16"
    instance_type = "t3.micro"
    key_name = "south"
}