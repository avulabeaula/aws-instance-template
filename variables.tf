variable "ami_id" {
  description = "The AMI from which to launch the instance"
  type        = string
  default     = "ami-053b0d53c279acc90"
}

variable "lt_name" {
  description = "Name of launch template to be created"
  type        = string
  default     = ""
}


variable "lt_description" {
  description = "Description of the launch template"
  type        = string
  default     = null
}

variable "instance_type" {
  description = "The type of the instance. If present then `instance_requirements` cannot be present"
  type        = string
  default     = "t2.micro"
}

variable "env" {
  description = "Environment details"
  type        = string
  default     = ""
}

variable "root_volume_size" {
  description = "root volume size"
  type        = number
  default     = 20
}

variable "root_volume_type" {
  type        = string
  default     = "gp2"
}

variable "subnet_id" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "key_name" {}
variable "sg_name" {}
variable "sg_description" {}
variable "from_port" {}
variable "to_port" {}
variable "protocol" {}
variable "sg_cidr" {}