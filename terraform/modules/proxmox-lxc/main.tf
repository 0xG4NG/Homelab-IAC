resource "proxmox_lxc" "ct" {
  hostname     = var.hostname
  target_node  = var.target_node
  ostemplate   = var.template
  unprivileged = var.unprivileged
  password     = var.password
  onboot       = var.onboot
  start        = var.start
  nameserver   = var.nameserver

  tags = join(";", var.tags)

  cores  = var.cores
  memory = var.memory
  swap   = var.swap

  rootfs {
    storage = var.rootfs_storage
    size    = var.rootfs_size
  }

  network {
    name   = var.network_name
    bridge = var.network_bridge
    ip     = var.network_ip
    gw     = var.network_gateway
    tag    = var.network_tag
  }

  features {
    nesting = var.features_nesting
  }

  dynamic "mountpoint" {
    for_each = var.bind_mounts
    content {
      key       = tostring(mountpoint.key)
      volume    = mountpoint.value.volume
      mp        = mountpoint.value.mp
      size      = mountpoint.value.size
      storage   = mountpoint.value.storage
      shared    = mountpoint.value.shared
      replicate = mountpoint.value.replicate
      backup    = mountpoint.value.backup
    }
  }

  ssh_public_keys = var.ssh_public_key

  lifecycle {
    ignore_changes = [
      password,    # avoid drift if manually changed post-create
      ssh_public_keys,
    ]
  }
}
