data "aws_region" "current" {}

locals {
  av_zones = [ "${data.aws_region.current.name}a", "${data.aws_region.current.name}b", "${data.aws_region.current.name}c" ]
}

resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_block
  tags = var.tags
#  main_route_table_id = aws_route_table.internet.id
  enable_dns_hostnames = true
}

resource "aws_main_route_table_association" "internet" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.internet.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = var.tags
}

resource "aws_route_table" "internet" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = var.tags
}

# Subnets don't cost so we create three subnets for each use case
resource "aws_subnet" "public" {
  for_each = toset(var.public_subnets)

  vpc_id = aws_vpc.vpc.id
  cidr_block = each.key
  availability_zone = local.av_zones[index(var.public_subnets, each.key) % length(local.av_zones)]
  map_public_ip_on_launch = true
  tags = merge(var.tags,
    {
    Name = "Public ${index(var.public_subnets, each.key)}"
  }
  )
}

resource "aws_subnet" "private" {
  for_each = toset(var.private_subnets)

  vpc_id = aws_vpc.vpc.id
  cidr_block = each.key
  availability_zone = local.av_zones[index(var.private_subnets, each.key) % length(local.av_zones)]
  map_public_ip_on_launch = false
  tags = merge(var.tags,
    {
    Name = "Private ${index(var.private_subnets, each.key)}"
    }
    )
}

