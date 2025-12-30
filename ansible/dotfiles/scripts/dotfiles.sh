#!/usr/bin/bash

# Strict mode: fail on error, undefined vars, or pipe failures. Safety first!
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"
REPO_URL="https://github.com/0xG4NG/Homelab-IAC.git"

# Wrapper to log the command being executed for better visibility
function _cmd {
  echo "Running: $*"
  "$@"
}

# Identify the OS distribution to choose the right package manager later
function detect_os {
  # shellcheck source=/dev/null
  [[ -f /etc/os-release ]] && source /etc/os-release && echo "${ID:-unknown}" || echo "unknown"
}

# Install Ansible only if it's missing to keep things fast
function install_ansible {
  if command -v ansible &> /dev/null; then
    echo "Ansible is already installed."
    return
  fi

  case $1 in
  debian)
  _cmd sudo apt-get update
  _cmd sudo apt-get install -y ansible
  ;;
  ubuntu)
    _cmd sudo apt-get update
    _cmd sudo apt-get install -y software-properties-common
    _cmd sudo add-apt-repository --yes --update ppa:ansible/ansible
    _cmd sudo apt-get install -y ansible
    ;;
  fedora)
    _cmd sudo dnf install -y ansible
    ;;
  *)
    echo "Unsupported OS: $1"
    echo "Supported OS: ubuntu, debian, fedora"
    ;;
  esac
}

# Clone the repo or update it if I already have it locally
function clone_dotfiles {
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "Dotfiles already exists. Updating the repo"
    _cmd git -C "$DOTFILES_DIR" pull --quiet
  else
    echo "Cloning @0xG4NG/Homelab-IAC repo"
    _cmd git clone --quiet --branch main "$REPO_URL" "$DOTFILES_DIR"
  fi
}


# --- Main Execution Flow ---
os=$(detect_os)
echo "Detected OS: $os"
install_ansible "$os"
clone_dotfiles

# Finally, run the playbook (commented out for now until I'm ready)
_cmd ansible-playbook "$DOTFILES_DIR/ansible/dotfiles/configure_dotfiles.yml" --limit local --ask-become-pass

# curl -sSL https://raw.githubusercontent.com/0xG4NG/Homelab-IAC/main/ansible/dotfiles/scripts/dotfiles.sh | bash