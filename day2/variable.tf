variable "ami" {
  type = string
  default = "ami-05fbd65e334e88c16"
}

variable "instance"{
    type = string 
    default = "t3.nano"
}

variable "key"{
    type = string
    default = "south"

}

variable "subnet"{
    type = string
    default = "subnet-077e35484843c5975"
}