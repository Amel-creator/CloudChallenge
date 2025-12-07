variable "name" {
  description = "Nom du projet ou du rôle à créer"
  type        = string
}

variable "repo_owner" {
  description = "Nom du propriétaire du repository GitHub"
  type        = string
}

variable "repo_name" {
  description = "Nom du repository GitHub"
  type        = string
}

variable "branch" {
  description = "Nom de la branche GitHub à autoriser"
  type        = string
  default     = "main"
}

variable "github_oidc_url" {
  description = "URL du provider OIDC GitHub"
  type        = string
  default     = "token.actions.githubusercontent.com"
}

variable "github_oidc_arn" {
  description = "ARN du provider OIDC GitHub dans AWS"
  type        = string
  default     = "arn:aws:iam::231838751459:oidc-provider/token.actions.githubusercontent.com"
}
