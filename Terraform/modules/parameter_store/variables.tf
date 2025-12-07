# Map des paramètres à créer dans AWS Parameter Store
variable "parameters" {
  description = "Map of SSM parameters to create in AWS Parameter Store"
  type        = map(string)
}

# Nom de l'environnement (ex: dev, prod)
variable "environment" {
  description = "Environment name for this deployment"
  type        = string
}

# Optionnel : tu peux ajouter un préfixe pour nommer les paramètres
variable "project_name" {
  description = "Project name prefix for parameters"
  type        = string
}

# (Optionnel) Valeurs spécifiques à la DB ou API si tu veux passer individuellement
variable "db_password" {
  description = "Database password (sensitive)"
  type        = string
  sensitive   = true
}

variable "api_key" {
  description = "API key (sensitive)"
  type        = string
  sensitive   = true
}
