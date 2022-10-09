output "public_subnets" {
  value = aws_subnet.public
}

output "private_subnets" {
  value = aws_subnet.private
}

output "id" {
  value = aws_vpc.vpc.id
}

output "vpc" {
  value = aws_vpc.vpc
}

output "internet_gateway" {
  value = aws_internet_gateway.igw
}

output "route_table" {
  value = aws_route_table.internet
}

