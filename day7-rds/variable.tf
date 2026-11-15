variable "allocated_storage" {
    type = string
    default = ""
}
variable "db_name" {
    type = string
    default = ""
}
variable "engine" {
    type = string
    default = ""
}
variable "engine_version" {
    type = string
    default = ""
}
variable "instance_class" {
    type = string
    default = ""
}
variable "username" {
    type = string
    default = ""
}
variable "password" {
    type = string
    default = ""
}
variable "parameter_group_name" {
    type = string
    default = ""
}
variable "name" {
    type = string
    default = ""
}
variable "subnet_ids" {
    type = list(string)
    
}