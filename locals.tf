locals {
  prefix = "${var.project_name}-${var.environment}"

  tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Application = "Axion"
  }

  address_space  = "10.40.0.0/16"
  app_subnet     = "10.40.1.0/24"
  appgw_subnet   = "10.40.2.0/24"
  bastion_subnet = "10.40.3.0/26"
  db_subnet      = "10.40.4.0/28"
}
