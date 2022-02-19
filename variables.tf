variable "region" {
}

variable "cidr_block" {
  description = "VPC CIDR, for example 10.0.0.0/16"
  type = string
}

variable "public_subnets" {
  description = "List of public subnets you want to create, they will be created all in different availability zones. CIDR format, i.e. 10.0.0.0/24"
  type = list(string)
  default = []
}

variable "private_subnets" {
  description = "List of private subnets you want to create, they will be created all in different availability zones. Private subnets will not get public routable IP addresses assigned. CIDR format, i.e. 10.0.0.0/24"
  type = list(string)
  default = []
}

variable "tags" {
  description = "Map of tags"
}
