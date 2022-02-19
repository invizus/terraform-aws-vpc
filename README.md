# Terraform VPC module for AWS

This is simple module to create a VPC with internet gateway and subnets.
I am using it for my quick tests, developmet and as a low-cost homelab in the
cloud.

This module is also cheap as it does not implement NAT gateway, which would be
too expensive to run in each subnet.

Security Groups are not part of this module because SGs are added and
configured with other resources, therefore flexible and should be part of
other modules and projects.

## Usage
```
module "vpc1" {
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
    Environment  = "kubelab"
  }
  region = "eu-west-2"
}
```

## Inputs

`region` - AWS region, useful to create availability zones.

`cidr_block` - VPC CIDR block.

`public_subnets` - list of public subnets in CIDR format, create as many as
you need, but 3 probably is enough. Each subnet will be created in different
availability zone. Instances in this subnet will be created with a public
routable IP address.

`private_subnets` - list of private subnets in CIDR format, each subnet will be
created in different availability zone. Instances in this subnet will have no
public routable IP address.

`tags` - map of tags.

## Outputs

`id` - VPC id.

`public_subnets` - exports all attributes of the subnets. Useful would be the
id of subnets. Example: `module.vpc.public_subnets["10.0.0.0/24"].id`.

`private_subnets` - exports all attributes of the subnets. Useful would be the
id of subnets. Example: `module.vpc.private_subnets["10.0.0.0/24"].id`.
