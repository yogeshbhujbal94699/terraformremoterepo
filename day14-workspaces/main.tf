resource "aws_instance" "ec2" {
    instance_type = "t3.micro"
  ami = "ami-04b0b8ee9ce90920a"
  key_name = "south"
  
}
# terraform workspace will create mutiple state files 
# Subcommands:terraform workspace 
#     delete    Delete a workspace
#     list      List Workspaces
#     new       Create a new workspace
#     select    Select a workspace
#     show      Show the name of the current workspace