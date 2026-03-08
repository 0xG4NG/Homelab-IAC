# 🏠 Homelab IAC

Infrastructure as Code for a Proxmox-based homelab. Manages LXC containers using **Ansible** for configuration and **Terraform** for provisioning. Secrets are stored in **Bitwarden Secrets Manager**.

---

## 📁 Repository Structure

```
.
├── ansible/
│   ├── ansible.cfg                        # Ansible configuration
│   ├── inventories/homelab/
│   │   ├── hosts.yml                      # Host definitions
│   │   └── group_vars/
│   │       ├── all/main.yml               # Global variables (BWS keys, timezone...)
│   │       ├── LXC/main.yml               # Variables for all LXC containers
│   │       └── PVE/main.yml               # Variables for the Proxmox hypervisor
│   └── playbooks/
│       ├── bootstrap.yml                  # Full node bootstrap (common + ssh + lldap)
│       ├── update.yml                     # Weekly package updates
│       ├── setup_bw_cli.yml               # Install Bitwarden CLI on control node
│       ├── ssh_agent.yml                  # Load SSH key into ssh-agent from BWS
│       ├── collections/requirements.yml   # Ansible Galaxy collections
│       └── roles/
│           ├── common/                    # Timezone, locale, essential packages
│           ├── ssh/                       # SSH hardening + authorized key deployment
│           ├── lldap/                     # SSSD configuration for LLDAP auth
│           └── bitwarden_cli/             # Bitwarden CLI installation
│
├── terraform/
│   ├── modules/proxmox-lxc/               # Reusable LXC container module
│   └── proxmox/                           # Proxmox environment (provider, containers)
│
├── .github/workflows/
│   ├── ci.yml                             # Lint + validate on every push
│   └── update.yml                         # Scheduled weekly updates
│
└── docs/
    ├── Ansible.md
    ├── Terraform.md
    └── Hardware.md
```

---

## 🚀 Quick Start

### Prerequisites

```bash
pip install ansible ansible-lint pre-commit
ansible-galaxy collection install -r ansible/playbooks/collections/requirements.yml
pre-commit install
```

### Bootstrap a new node

```bash
# Export your Bitwarden Secrets Manager token
export BWS_ACCESS_TOKEN="your_token_here"

# Bootstrap all nodes (common + SSH + LDAP)
cd ansible
ansible-playbook playbooks/bootstrap.yml -e "bws_access_token=$BWS_ACCESS_TOKEN"

# Bootstrap only a specific host
ansible-playbook playbooks/bootstrap.yml -l lxc-102 -e "bws_access_token=$BWS_ACCESS_TOKEN"
```

### Run updates manually

```bash
cd ansible
ansible-playbook playbooks/update.yml
```

### Provision a new LXC with Terraform

```bash
cd terraform/proxmox
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
terraform init
terraform plan
terraform apply
```

---

## 🔐 Secrets Management

All secrets are stored in **Bitwarden Secrets Manager** and fetched at runtime. No secrets are committed to this repository.

| Secret | BWS ID | Used by |
|--------|--------|---------|
| Ansible SSH public key | `ddd446f9-...` | `ssh` role |
| Ansible SSH private key | `REPLACE_ME` | `ssh_agent.yml` |
| Proxmox API token | Terraform var | Terraform provider |

---

## 🧪 Linting & CI

```bash
# Run all pre-commit hooks locally
pre-commit run --all-files

# Ansible lint only
cd ansible && ansible-lint

# Terraform format check
terraform fmt -check -recursive terraform/
```

CI runs automatically on every push via GitHub Actions (see `.github/workflows/ci.yml`).

---

## 📖 Documentation

- [Ansible roles & playbooks](docs/Ansible.md)
- [Terraform modules](docs/Terraform.md)
- [Hardware inventory](docs/Hardware.md)
