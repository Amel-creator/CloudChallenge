resource "aws_ssm_parameter" "params" {
  for_each = var.parameters

  name  = each.key
  type  = "SecureString"
  value = each.value

  tags = {
    Environment = var.environment
  }
}

