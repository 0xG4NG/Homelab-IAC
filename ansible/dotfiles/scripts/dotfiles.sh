#!/usr/bin/bash

# Modo estricto: detiene el script si hay errores, variables no definidas o fallos en pipes
set -euo pipefail

DOTFILES_DIR="$HOME/.dotfiles"

function _cmd {
  echo "Running: $*"
  "$@"
}

function detect_os {
  # shellcheck source=/dev/null
  [[ -f /etc/os-release ]] && source /etc/os-release && echo "${ID:-unknown}" || echo "unknown"
}

function install_ansible {
  if command -v ansible &> /dev/null; then
    echo "Ansible ya está instalado."
    return
  fi

  case $1 in
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
    echo "Supported OS: ubuntu, fedora"
    ;;
  esac
}

function clone_dotfiles {
  if [[ -d "$DOTFILES_DIR" ]]; then
    echo "Dotfiles already exists. Updating the repo"
    _cmd git -C "$DOTFILES_DIR" pull --quiet
  else
    echo "Cloning @0xG4NG/dotfiles repo"
    _cmd git clone --quiet --branch main https://github.com/0xG4NG/Dotfiles.git "$DOTFILES_DIR"
  fi
}



# Main execution
os=$(detect_os)
echo "Detected OS: $os"
install_ansible "$os"
clone_dotfiles

# _cmd ansible-playbook "$DOTFILES_DIR/main.yml" --limit local --ask-become-pass
