# debug_bitwarden.tf
terraform {
  required_version = ">= 0.13.0"

  required_providers {
    bitwarden-secrets = {
      source = "bitwarden/bitwarden-secrets"
      version = "0.5.4-pre"
    }
  }
}

provider "bitwarden-secrets" {
  api_url         = "https://api.bitwarden.com"
  identity_url    = "https://identity.bitwarden.com"
  access_token    = "" 
  organization_id = ""
}
data "bitwarden-secrets_secret" "test" {}
output "test_value" {
  value     = data.bitwarden-secrets_secret.projects
}