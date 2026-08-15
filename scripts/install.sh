#!/usr/bin/env bash
set -euo pipefail
#
# Orbitux GRUB Theme Installer
#
# Version : 0.3.0
# Author : orbitux
#
readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")"&&pwd)"
readonly PROJECT_DIR="$(cd -- "$SCRIPT_DIR/.." && pwd)"
readonly GRUB_CONFIG="/etc/default/grub"
readonly THEME_NAME="orbitux"

GRUB_DIR=""
THEME_DIR=""
BACKUP_DIR=""

check_root(){
    if [[ $EUID -ne 0 ]]; then
        RED='\033[1;31m'
        echo -e "${RED} [ERROR] Please run this installer as root"
        exit 1
    fi
}
show_banner(){
    echo -e " hello, $(uname -n)!" | figlet
    cat << "EOF"
    =========================================
                ORBITUX GRUB THEME
                    Installer
                     v 0.3.0
    ========================================= 
EOF
}
show_welcome(){
    cat << "EOF"

    This installer will:

    • Backup your current GRUB configuration

    • Install Orbitux Theme

    • Configure GRUB

    • Regenerate grub.cfg

EOF
}
ask_confirmation(){
    RED='\033[1;31m'
    local answer
    read -rp "Continue? [Y/n]: " answer
    case "$answer" in
        [N/n]* )
            echo -e "${RED}Installation cancelled"
            exit 0
    esac
}
detect_grub(){
    BLUE='\033[1;34m'
    GREEN='\033[1;32m'
    RED='\033[1;31m'
    echo -e "${BLUE}detecting grub..."
    if [[ -d /boot/grub ]]; then
        GRUB_DIR="/boot/grub"
    elif [[ -d /boot/grub2 ]]; then
        GRUB_DIR="/boot/grub2"
    else
        echo -e "${RED}[ERROR] GRUB directory not found! "
        exit 1
    fi
    echo -e "${GREEN}[OK] GRUB directory : $GRUB_DIR"
}
main(){
    check_root
    show_banner
    show_welcome
    ask_confirmation
    detect_grub
}
main "$@"