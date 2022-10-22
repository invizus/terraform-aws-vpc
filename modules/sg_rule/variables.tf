variable "type" {
  description = "The flow of traffic, ingress or egress."
  type        = list(string)
}

variable "ports" {
  description = "List of ports to allow."
  type        = list(number)
}

variable "protocol" {
  description = "Protocol udp or tcp. Defaults to tcp."
  type        = string
  default     = "tcp"
}

variable "cidr_blocks" {
  description = "List of CIDR blocks to allow."
  type        = list(string)
}

variable "id" {
  description = "id of a security group to attach the rules to."
  type        = string
}

