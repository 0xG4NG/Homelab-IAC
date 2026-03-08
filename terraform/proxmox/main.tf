# ── Secrets from Bitwarden ────────────────────────────────────────────────────

data "bitwarden-secrets_secret" "ssh_public_key" {
  id = "77ff9ac7-55d2-44fb-9a0a-b37300b5cbcb"
}

# ── LXC Containers ────────────────────────────────────────────────────────────

module "pihole" {
  source = "../../modules/proxmox-lxc"

  hostname    = "pihole"
  target_node = var.proxmox_node
  template    = var.lxc_template
  password    = var.lxc_root_password

  cores          = 1
  memory         = 512
  rootfs_size    = "4G"
  network_ip     = "192.168.1.5/24"
  network_gateway = "192.168.1.1"

  ssh_public_key = data.bitwarden-secrets_secret.ssh_public_key.value
  tags           = ["dns", "infrastructure"]
}

# Add more containers following the same pattern:
#
# module "my_service" {
#   source = "../../modules/proxmox-lxc"
#   ...
# }
