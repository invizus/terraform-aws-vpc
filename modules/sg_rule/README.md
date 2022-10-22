# Terraform submodule to create security groups rules.

This module is usable externally.

You can use this submodule to create Security Group rules easily.
The idea is that you can create ingress or egress rule for one
protocol, but for multiple CIDR subnets and ports.

This submodule is too small to be a separate module, and SG rules
are part of VPC, hence I added this as a submodule here.

Example usage:

```
resource "aws_security_group" "in" {
  vpc_id = "<vpc.id>"
}

module "ingress_rules" {
  source = "github.com/invizus/terraform-aws-vpc/modules/sg_rule"
  type = "ingress"
  ports = [
    22
  ]
  protocol = "tcp"
  cidr_blocks = [
    "0.0.0.0/0"
  ]
  id = aws_security_group.in.id
}
```

