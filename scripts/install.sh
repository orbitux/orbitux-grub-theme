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
        echo "[ERROR Please run this installer as root]"
        exit 1
    fi
}
show_banner(){
    figlet -f slant "ORBITUX GRUB"
    cat << "EOF"
    =========================================
                ORBITUX GRUB THEME
                    Installer
                     v 0.3.0
    ========================================= 
EOF
}





main(){
    check_root
    show_banner
}
main "$@"