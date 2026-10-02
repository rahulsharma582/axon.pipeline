variable "project_name" {
  type        = string
  description = "Short project name used in Azure resource names."
  default     = "axion"
}

variable "environment" {
  type    = string
  default = "preprod"
}

variable "location" {
  type    = string
  default = "Central India"
}

variable "dr_location" {
  type    = string
  default = "South India"
}

variable "admin_username" {
  type    = string
  default = "azureadmin"
}

variable "admin_ssh_public_key" {
  type        = string
  description = "SSH public key used for the Linux VM. Store it as an Azure DevOps secret variable."
  sensitive   = true
}

variable "postgres_admin_username" {
  type    = string
  default = "axionadmin"
}

variable "postgres_admin_password" {
  type        = string
  sensitive   = true
  description = "PostgreSQL admin password. Store it as an Azure DevOps secret variable."
}

variable "postgres_version" {
  type    = string
  default = "16"
}

variable "postgres_database_name" {
  type    = string
  default = "axiondb"
}

variable "vm_size" {
  type    = string
  default = "Standard_D2s_v6"
}

variable "axion_container_port" {
  type    = number
  default = 8080
}

variable "axion_health_path" {
  type    = string
  default = "/health"
}

variable "alert_email" {
  type        = string
  description = "Email receiving Azure Monitor alerts."
}

variable "docker_image_tag" {
  type    = string
  default = "latest"
}

variable "enable_bastion" {
  type    = bool
  default = true
}
