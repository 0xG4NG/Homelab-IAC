# Ansible

## Running playbooks

All playbooks are executed from the `ansible/` directory. The `ansible.cfg` in that directory is picked up automatically.

```bash
cd ansible

# Bootstrap all nodes
ansible-playbook playbooks/bootstrap.yml -e "bws_access_token=$BWS_ACCESS_TOKEN"

# Target a specific group
ansible-playbook playbooks/bootstrap.yml -l LXC -e "bws_access_token=$BWS_ACCESS_TOKEN"

# Dry run (check mode)
ansible-playbook playbooks/bootstrap.yml --check -e "bws_access_token=$BWS_ACCESS_TOKEN"

# Show diff of changes
ansible-playbook playbooks/bootstrap.yml --diff -e "bws_access_token=$BWS_ACCESS_TOKEN"
```

## Roles

### `common`
Sets the timezone (`Europe/Madrid`), locale (`es_ES.UTF-8`), and installs essential packages (`curl`, `git`, `btop`, `neovim`, `unzip`, `gnupg`, etc.).

**Key variables** (set in `group_vars/all/main.yml`):

| Variable | Default | Description |
|----------|---------|-------------|
| `common_timezone` | `Europe/Madrid` | System timezone |
| `common_locale` | `es_ES.UTF-8` | System locale |
| `common_packages` | *(list)* | Base packages to install |
| `common_extra_packages` | `[]` | Additional packages (per-group override) |

---

### `ssh`
Hardens SSH configuration and deploys the Ansible public key from Bitwarden Secrets Manager.

Config deployed: `PermitRootLogin prohibit-password`, `PasswordAuthentication no`, `AuthenticationMethods publickey`.

The template is validated with `sshd -t` before being applied.

**Key variables**:

| Variable | Default | Description |
|----------|---------|-------------|
| `ssh_port` | `22` | SSH listen port |
| `ssh_authorized_key` | *(from BWS)* | Public key to deploy |
| `ssh_deploy_user` | `root` | User to receive the key |
| `ssh_max_auth_tries` | `3` | Max authentication attempts |

---

### `lldap`
Configures SSSD to authenticate users against an [LLDAP](https://github.com/lldap/lldap) server. Enables PAM mkhomedir so home directories are created on first login.

**Key variables**:

| Variable | Default | Description |
|----------|---------|-------------|
| `lldap_ldap_server` | `ldap://lldap.g4ng.es:3890` | LDAP server URI |
| `lldap_ldap_basedn` | `dc=g4ng,dc=es` | LDAP base DN |
| `lldap_test_user` | `g4ng` | User to verify LDAP works |
| `lldap_default_shell` | `/bin/bash` | Default shell for LDAP users |

---

### `bitwarden_cli`
Installs the Bitwarden CLI (`bw`) on the **control node** (`localhost`). Run once with `setup_bw_cli.yml`.

---

## Inventory

Hosts are defined in `inventories/homelab/hosts.yml`. Groups:

- **PVE** — Proxmox hypervisor (`192.168.1.100`)
- **LXC** — All LXC containers (`192.168.1.102–118`)
- **local** — Control node (localhost)

To add a new container, add an entry to `LXC` in `hosts.yml` and create a `host_vars/<hostname>.yml` if it needs specific overrides.
