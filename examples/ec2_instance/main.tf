module "vpc" {
  source     = "github.com/invizus/terraform-aws-vpc"
  cidr_block = "10.0.0.0/16"
  public_subnets = [
    "10.0.0.0/24",
    "10.0.1.0/24",
    "10.0.2.0/24",
  ]
  private_subnets = [
    "10.0.3.0/24"
  ]
  tags = {
    Environment  = "Development"
  }
  region = "eu-west-2"
}

resource "aws_instance" "k3s" {
  count         = 1
  ami           = "ami-0d527b8c289b4af7f"
  instance_type = "t2.medium"
  subnet_id     = module.vpc.public_subnets["10.0.0.0/24"].id
  tags = {
    Name    = "instance-${count.index}"
  }
}

output "instances" {
  value = aws_instance.k3s[*].public_ip
}

