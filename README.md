# Axion Azure Infrastructure + Terraform CI/CD

This repository is a production-style pre-production baseline for deploying the Axion application on Azure.

## Architecture

Internet -> Azure Application Gateway -> private Axion Linux VM -> Docker container -> private PostgreSQL Flexible Server

Management: Azure Bastion
Container registry: Azure Container Registry
IaC: Terraform
CI/CD: Azure DevOps multi-stage YAML
Monitoring: Azure Monitor + Log Analytics + metric alerts
Backup/DR: Recovery Services Vault with Geo-Redundant storage + daily VM backups; PostgreSQL geo-redundant backups enabled

## What the pipeline does

1. Runs Terraform formatting and validation.
2. Runs secret/IaC security scanner hooks.
3. Builds the Axion Docker image.
4. Creates an immutable Terraform plan.
5. Publishes the plan as an artifact.
6. Pauses for manual pre-production approval.
7. Applies exactly the reviewed Terraform plan.
8. Builds and pushes Axion to Azure Container Registry using the commit SHA as the image tag.
9. Uses Azure VM Run Command and the VM managed identity to pull and run the image.
10. Prints the Application Gateway URL.

## Required Azure DevOps setup

Create one Azure Resource Manager service connection named `Azure-Terraform-Connection` (or change the YAML variable).

Create these secret pipeline variables:

- `TF_ADMIN_USERNAME`
- `TF_ADMIN_SSH_PUBLIC_KEY`
- `TF_POSTGRES_ADMIN_USERNAME`
- `TF_POSTGRES_ADMIN_PASSWORD`
- `TF_ALERT_EMAIL`
- `TF_APPROVER_EMAIL`

The service connection identity needs permission to create/manage the resources in the target subscription/resource group. For a production implementation, scope permissions to the required resource groups and use workload identity federation rather than client secrets.

## Remote Terraform state

For a real shared team setup, configure an Azure Storage backend. The repository intentionally does not contain storage-account credentials. The recommended pattern is an existing bootstrap state resource group/storage account and an Azure DevOps service connection with access to it.

Example backend block:

```hcl
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "staxiontfstate"
    container_name       = "tfstate"
    key                  = "preprod.tfstate"
  }
}
```

Do not put access keys in Git.

## Important Axion application note

The supplied ZIP did not contain an actual Axion application source tree. Therefore `axion/` contains a small runnable health-enabled sample so the infrastructure and pipeline can be tested end-to-end.

Replace only the contents of `axion/` with the real Axion application and keep these requirements:

- application listens on `0.0.0.0:8080`
- `GET /health` returns HTTP 200 when healthy
- `Dockerfile` builds a production image

If the real Axion application already has a different port, change `axion_container_port` and the deployment command in the pipeline.

## DR / backup boundary

This implementation provides Azure Backup for the VM with 30 daily recovery points and geo-redundant vault storage, plus PostgreSQL geo-redundant backups. This is backup-based recovery, not a zero-RPO active-active DR solution.

For a production multi-region DR design, add Azure Site Recovery or a warm-standby region with replicated application/database services, plus a tested DNS/traffic failover runbook.

## First run

1. Import this repository into GitHub.
2. Connect the repository to an Azure DevOps pipeline.
3. Use a self-hosted agent pool named `Rahul`, or change `pool.name` in the YAML.
4. Add the secret variables listed above.
5. Confirm the Azure service connection.
6. Run the pipeline from `main`.
7. Approve the Terraform plan.
8. Open the printed Application Gateway URL.

Never commit real passwords, private keys, tfstate files, or service-principal secrets.
