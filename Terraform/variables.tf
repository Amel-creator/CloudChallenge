variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "sa-east-1"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "management_subnet_cidr" {
  description = "CIDR block for the management subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the first private subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-04b4f1a9cf54c11d0" // AMI Ubuntu la plus recente par defaut
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "az1" {
  description = "Availability zone 1"
  type        = string
  default     = "us-east-1a"
}

variable "az2" {
  description = "Availability zone 2"
  type        = string
  default     = "us-east-1b"
}

variable "az3" {
  description = "Availability zone 3"
  type        = string
  default     = "us-east-1c"
}

variable "key1" {
  description = "SSH key pair name for application servers"
  type        = string
  default     = "key1" // Remplacer par ton nom de clé
}

variable "key2" {
  description = "SSH key pair name for management server"
  type        = string
  default     = "key2" // Remplacer par ton nom de clé
}

variable "private_key_path1" {
  description = "Path to the private key file for SSH"
  type        = string
  default     = "./key1.pem"
}

variable "private_key_path" {
  description = "Path to the private key file for SSH"
  type        = string
  default     = "./key2.pem"
}

variable "vpc_name" {
  description = "Le nom du VPC"
  type        = string
  default     = "app_vpc"  # Valeur par défaut
}

variable "user" {
  description = "Le user selon la distribution"
  type        = string
  default     = "ubuntu"  # Valeur par défaut
}


variable "sg_app" {
  description = "Le user selon la distribution"
  type        = string
  default     = "sg_app_lab"  # Valeur par défaut
}

variable "project_name" {
  default = "cloud-challenge"

}

variable "environment" {
  default = "dev"
}

variable "db_password" {
  type = string
}

variable "api_key" {
  type = string
}

variable "repo_owner" {
  default = "Amel-creator"
}
variable "repo_name" {
  default = "CloudChallenge"

}
variable "branch" {
  default = "main"

}

variable "github_oidc_arn" {
  default = "arn:aws:iam::231838751459:role/github-actions-role"

}
variable "github_oidc_url" {
  default = "token.actions.githubusercontent.com"

}


