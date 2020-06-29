variable "aws_access_key" {
  type        = string
  description = "AWS access key used to create infrastructure"
}

# Required
variable "aws_secret_key" {
  type        = string
  description = "AWS secret key used to create AWS infrastructure"
}

variable "aws_region" {
  type        = string
  description = "AWS region used for all resources"
  default     = "eu-west-1"
}

variable "instance_type" {
  type        = string
  description = "Instance type used for all EC2 instances"
  default     = "t3a.medium"
}
 
locals {
  node_username = "ubuntu"
}

variable "subnet_depends_on" {
  type    = any
  default = null
}