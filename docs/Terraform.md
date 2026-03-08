# Terraform

## Prerequisites

- Terraform >= 1.6.0
- A Proxmox API token with LXC create/manage permissions
- Bitwarden Secrets Manager access token

## Setup

```bash
cd terraform/proxmox
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars — it is excluded from git
terraform init
```

## Usage

```bash
# Preview changes
terraform plan

# Apply changes
terraform apply

# Destroy all managed resources
terraform destroy
```

## Module: `proxmox-lxc`

Located at `terraform/modules/proxmox-lxc/`. Creates a single Proxmox LXC container.

### Inputs

| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `hostname` | string | — | Container hostname |
| `target_node` | string | — | Proxmox node name |
| `template` | string | — | LXC template path |
| `password` | string | — | Root password (sensitive) |
| `cores` | number | `1` | CPU cores |
| `memory` | number | `512` | RAM in MB |
| `rootfs_size` | string | `10G` | Root disk size |
| `network_ip` | string | `dhcp` | IP in CIDR or `dhcp` |
| `network_gateway` | string | `""` | Gateway IP |
| `ssh_public_key` | string | — | Authorized public key |
| `unprivileged` | bool | `true` | Unprivileged container |
| `features_nesting` | bool | `false` | Enable Docker-in-LXC |
| `tags` | list(string) | `[]` | Proxmox tags |

### Outputs

| Output | Description |
|--------|-------------|
| `id` | Proxmox VMID |
| `hostname` | Container hostname |
| `ip_address` | Configured IP |

### Example

```hcl
module "my_service" {
  source = "../../modules/proxmox-lxc"

  hostname        = "my-service"
  target_node     = "pve"
  template        = var.lxc_template
  password        = var.lxc_root_password
  cores           = 2
  memory          = 1024
  rootfs_size     = "20G"
  network_ip      = "192.168.1.50/24"
  network_gateway = "192.168.1.1"
  ssh_public_key  = data.bitwarden-secrets_secret.ssh_public_key.value
  tags            = ["app", "homelab"]
}
```

## Proxmox API Token

Create a token in Proxmox UI → Datacenter → Permissions → API Tokens. Required permissions:

```
VM.Allocate, VM.Config.*, VM.PowerMgmt, Datastore.AllocateSpace, SDN.Use
```
