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
        RED='\033[0;31m'
        echo -e "${RED} [ERROR] Please run this installer as root"
        exit 1
    fi
}
show_banner(){
    echo "hello, $(uname -n)!" | figlet
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
    
    local answer
    read -rp "Continue? [Y/n]: " answer
    case "$answer" in
        [N/n]* )
            echo "Installation cancelled"
            exit 0
    esac
}

main(){
    check_root
    show_banner
    show_welcome
    ask_confirmation

}
main "$@"