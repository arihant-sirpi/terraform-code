 variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "az" {
  default = ["us-east-1a",   "us-east-1b"]
}
variable "prv_cidr" {
default     = [ "10.0.128.0/18", "10.0.192.0/18" ]
}
variable "pub_cidr" {
  default     = [ "10.0.0.0/18", "10.0.64.0/18" ]
}
variable "pub_rt_cidr" {
  default = "0.0.0.0/0" 
}
variable "prv_rt_cidr" {
  default = "0.0.0.0/0" 
}
variable "instance_type" {
  default = "t2.micro"
}