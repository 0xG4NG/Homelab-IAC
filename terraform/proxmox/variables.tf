# ── Proxmox ───────────────────────────────────────────────────────────────────

variable "proxmox_api_url" {
  type        = string
  description = "Proxmox API URL (e.g. 'https://192.168.1.100:8006/api2/json')."
}

variable "proxmox_token_id" {
  type        = string
  description = "Proxmox API token ID (e.g. 'root@pam!terraform')."
}

variable "proxmox_token_secret" {
  type        = string
  description = "Proxmox API token secret."
  sensitive   = true
}

variable "proxmox_tls_insecure" {
  type        = bool
  description = "Skip TLS verification (set true for self-signed certs)."
  default     = true
}

variable "proxmox_node" {
  type        = string
  description = "Target Proxmox node name."
  default     = "pve"
}

# ── Bitwarden Secrets Manager ─────────────────────────────────────────────────

variable "bws_access_token" {
  type        = string
  description = "Bitwarden Secrets Manager access token."
  sensitive   = true
}

variable "bws_organization_id" {
  type        = string
  description = "Bitwarden organization ID."
}

# ── LXC defaults ──────────────────────────────────────────────────────────────

variable "lxc_root_password" {
  type        = string
  description = "Default root password for new LXC containers."
  sensitive   = true
}

variable "lxc_template" {
  type        = string
  description = "Default LXC template to use."
  default     = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
}
