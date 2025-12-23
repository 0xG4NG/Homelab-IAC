resource "proxmox_lxc" "ct" {
  hostname      = var.hostname
  target_node   = var.target_node
  ostemplate    = var.template
  unprivileged  = var.unprivileged
  password      = var.password

  # Hardware Resources
  cores  = var.lxc_cores
  memory = var.lxc_memory

  # Root Disk (rootfs)
  rootfs {
    storage = "local-lvm" # You can pass this as a variable if you use multiple storages
    size    = "${var.lxc_disk_size}G"
  }

  # Network Configuration
  network {
    name   = var.network_name
    bridge = var.network_bridge
    ip     = var.network_ip
    gw     = var.network_gateway
  }

  # SSH Keys
  ssh_public_keys = var.ssh_public_key
  
  # Start the container after creation
  start = true
}