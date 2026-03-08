terraform {
  required_version = ">= 1.6.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "~> 3.0"
    }
    bitwarden-secrets = {
      source  = "bitwarden/bitwarden-secrets"
      version = "~> 0.5"
    }
  }

  # Uncomment to use remote state (recommended for teams)
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "homelab/proxmox/terraform.tfstate"
  #   region = "eu-west-1"
  # }
}

provider "proxmox" {
  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_token_id
  pm_api_token_secret = var.proxmox_token_secret
  pm_tls_insecure     = var.proxmox_tls_insecure

  pm_log_enable = false
  pm_log_file   = "terraform-plugin-proxmox.log"
}

provider "bitwarden-secrets" {
  api_url         = "https://api.bitwarden.com"
  identity_url    = "https://identity.bitwarden.com"
  access_token    = var.bws_access_token
  organization_id = var.bws_organization_id
}
