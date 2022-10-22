resource "aws_security_group_rule" "rule" {
  type              = var.type
  for_each          = { for port in var.ports : port => port }
  from_port         = each.key
  to_port           = each.key
  protocol          = var.protocol
  cidr_blocks       = var.cidr_blocks
  security_group_id = var.id
}

