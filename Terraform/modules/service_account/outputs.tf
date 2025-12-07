output "role_arn" {
  value       = aws_iam_role.github.arn
  description = "ARN du rôle IAM pour GitHub Actions"
}
