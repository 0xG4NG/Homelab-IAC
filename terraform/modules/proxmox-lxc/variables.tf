variable "hostname" {
  type        = string
  description = "Hostname for the LXC container."
}

variable "template" {
  type        = string
  description = "LXC template path (e.g. 'local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst')."
}

variable "target_node" {
  type        = string
  description = "Proxmox node where the container will be created."
}

variable "password" {
  type        = string
  description = "Root password for the container."
  sensitive   = true
}

variable "unprivileged" {
  type        = bool
  description = "Run container in unprivileged mode (recommended)."
  default     = true
}

variable "onboot" {
  type        = bool
  description = "Start container automatically on Proxmox boot."
  default     = true
}

variable "start" {
  type        = bool
  description = "Start container immediately after creation."
  default     = true
}

variable "cores" {
  type        = number
  description = "Number of CPU cores."
  default     = 1
}

variable "memory" {
  type        = number
  description = "RAM in MB."
  default     = 512
}

variable "swap" {
  type        = number
  description = "Swap in MB."
  default     = 512
}

variable "rootfs_storage" {
  type        = string
  description = "Storage backend for the root filesystem."
  default     = "local-lvm"
}

variable "rootfs_size" {
  type        = string
  description = "Root disk size (e.g. '10G')."
  default     = "10G"
}

variable "network_name" {
  type        = string
  description = "Network interface name inside the container."
  default     = "eth0"
}

variable "network_bridge" {
  type        = string
  description = "Proxmox bridge to attach to (e.g. 'vmbr0')."
  default     = "vmbr0"
}

variable "network_ip" {
  type        = string
  description = "CIDR IP address (e.g. '192.168.1.100/24') or 'dhcp'."
  default     = "dhcp"
}

variable "network_gateway" {
  type        = string
  description = "Default gateway. Leave empty when using DHCP."
  default     = ""
}

variable "network_tag" {
  type        = number
  description = "VLAN tag. Set to null to disable."
  default     = null
}

variable "nameserver" {
  type        = string
  description = "DNS server for the container. Leave null to inherit from Proxmox."
  default     = null
}

variable "ssh_public_key" {
  type        = string
  description = "SSH public key for passwordless root access."
}

variable "features_nesting" {
  type        = bool
  description = "Enable LXC nesting (required for Docker inside LXC)."
  default     = false
}

variable "tags" {
  type        = list(string)
  description = "List of tags to apply to the container."
  default     = []
}

variable "bind_mounts" {
  type = list(object({
    volume    = string
    mp        = string
    size      = optional(string)
    storage   = optional(string)
    shared    = optional(bool)
    replicate = optional(bool)
    backup    = optional(bool)
  }))
  description = "Additional bind mounts / mount points."
  default     = []
}
