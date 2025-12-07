output "parameters" {
  description = "All SSM parameters created"
  value       = var.parameters
  sensitive   = true
}
