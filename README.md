# IAC Project

This repository contains Infrastructure as Code (IAC) resources for automating the deployment and management of services using Ansible and Terraform.

## Structure

- **ansible/**: Contains Ansible playbooks, roles, inventories, and configuration files for automating server setup and application deployment.
  - `playbooks/`: Main playbooks for provisioning and updating services.
  - `roles/`: Custom roles for specific services (e.g., Bitwarden CLI, LDAP, SSH keys).
  - `inventories/`: Host and group variable definitions for different environments.
  - `logs/`, `tmp/`, `facts_cache/`: Directories for logs, temporary files, and cached facts (excluded from version control).
- **terraform/**: (Empty) Placeholder for future Terraform configurations.