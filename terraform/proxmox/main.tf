
data "bitwarden-secrets_secret" "ssh_public_key_secret" {
  id = "77ff9ac7-55d2-44fb-9a0a-b37300b5cbcb"
}

module "pihole_lxc" {
  source = "../../modules/proxmox-lxc"
  
  lxc_hostname    = "pihole"
  lxc_target_node = "pve"
  lxc_template    = "local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst"
  lxc_password    = var.lxc_root_password
  lxc_ip          = "192.168.1.5/24"
  lxc_gateway     = "192.168.1.1"
}