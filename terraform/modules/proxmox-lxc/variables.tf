variable "tags" {
  type    = list(string)
  default = []
}

variable "hostname" {
  type        = string
  description = "The hostname for the LXC container."
}

variable "template" {
  type        = string
  description = "The name of the LXC template file to use (e.g., 'local:vztmpl/ubuntu-22.04-standard_22.04-1_amd64.tar.zst')."
}

variable "target_node" {
  type        = string
  description = "The Proxmox node where the container will be created."
}

variable "password" {
  type        = string
  description = "The password for the container's root user."
  sensitive   = true
}

variable "cores" {
  type        = number
  description = "Number of CPU cores for the container."
  default     = 1
}

variable "memory" {
  type        = number
  description = "RAM in MB for the container."
  default     = 512
}

variable "swap" {
  type    = string
  default = "512"
}

variable "nameserver" {
  type    = string
  default = null
}

variable "network_name" {
  type    = string
  default = "eth0"
}

variable "network_bridge" {
  type        = string
  description = "The Proxmox network bridge to use (e.g., 'vmbr0')."
  default     = "vmbr0"
}

variable "network_ip" {
  type        = string
  description = "The CIDR IP address for the container (e.g., '192.168.1.100/24'). Leave as 'dhcp' to use DHCP."
  default     = "dhcp"
}

variable "network_gateway" {
  type        = string
  description = "The gateway for the container's network."
  default     = "" # Empty so Proxmox won't set it when using DHCP
}

variable "network_tag" {
  type    = string
  default = null
}

variable "ssh_public_key" {
  type        = string
  description = "The public SSH key to allow passwordless access."
}

variable "unprivileged" {
  type        = bool
  description = "Defines if the container should be unprivileged (more secure)."
  default     = true
}

variable "rootfs_storage" {
  type    = string
  default = "local-lvm"
}

variable "rootfs_size" {
  type    = string
  default = "10G"
}

variable "features_nesting" {
  type    = bool
  default = true
}

variable "onboot" {
  type    = bool
  default = true
}

variable "start" {
  type    = bool
  default = true
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
  default = []
}