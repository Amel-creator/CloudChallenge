output "bucket" {
  value = module.s3.bucket_name
}

output "ssm_params" {
  value     = module.parameter_store.parameters
  sensitive = true
}

output "github_role" {
  value = module.github_sa.role_arn
}

