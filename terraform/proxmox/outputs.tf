output "pihole_id" {
  description = "Container ID of the pihole LXC."
  value       = module.pihole.id
}

output "pihole_ip" {
  description = "IP address of the pihole LXC."
  value       = module.pihole.ip_address
}
