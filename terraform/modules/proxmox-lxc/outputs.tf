output "id" {
  description = "The VMID of the created LXC container."
  value       = proxmox_lxc.ct.id
}

output "hostname" {
  description = "Hostname of the container."
  value       = proxmox_lxc.ct.hostname
}

output "ip_address" {
  description = "IP address (as configured)."
  value       = var.network_ip
}
