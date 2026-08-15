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

#Colors
BLUE='\033[1;34m'
GREEN='\033[1;32m'
RED='\033[1;31m'
ORANGE='\033[1;33m'
RESET_COLOR='\033[0m'
check_root(){
    if [[ $EUID -ne 0 ]]; then
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
    local answer
    read -rp "Continue? [Y/n]: " answer
    case "$answer" in
        [N/n]* )
            echo -e "${RED}Installation cancelled"
            exit 0
    esac
}
detect_grub(){
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
backup_grub(){
    if [[ ! -f "$GRUB_CONFIG" ]];then
        echo -e "${RED}[ERROR] GRUB configuration not found! : $GRUB_CONFIG"
        exit 1
    fi
    echo -e "${BLUE}backup grub..."
    BACKUP_DIR="/boot/orbitux-backup/$(date '+%Y-%m-%d_%H-%M-%S')"
    mkdir -p "$BACKUP_DIR"
    cp -- "$GRUB_CONFIG" "$BACKUP_DIR/grub.backup"
    echo -e "${GREEN}[OK] Backup created: ${RESET_COLOR}"
    echo -e "Backup directory: ${ORANGE}$BACKUP_DIR"
}
install_theme(){
    THEME_DIR="$GRUB_DIR/themes/$THEME_NAME"
    mkdir -p "$THEME_DIR"
    echo -e "${BLUE}[INFO] Installing orbitux theme..."
    cp -- "$PROJECT_DIR/theme.txt" "$THEME_DIR/"
    if [[ -d "$PROJECT_DIR/icons" ]]; then
        cp -r -- "$PROJECT_DIR/icons" "$THEME_DIR"
    fi
    if [[ -f "$PROJECT_DIR/background.png" ]]; then
        cp -- "$PROJECT_DIR/background.png" "$THEME_DIR/"
    fi
    if [[ -f "$PROJECT_DIR/arrow_w.png" ]]; then
        cp -- "$PROJECT_DIR/arrow_w.png" "$THEME_DIR/"
    fi
    if [[ -f "$PROJECT_DIR/orbitux-Regular-22.pf2" ]];then
        cp -- "$PROJECT_DIR/orbitux-Regular-22.pf2" "$THEME_DIR/"
    fi
    echo -e "${GREEN}[OK] Theme intalled."
}
configure-grub(){
    echo -e "${BLUE}configuring grub..."
    local theme_path="$THEME_DIR/theme.txt"
    if grep -q '^GRUB_THEME=' "$GRUB_CONFIG"; then
        sed -i "s|^GRUB_THEME=.*|GRUB_THEME\"$theme_path\"|""${GRUB_CONFIG}"
    else
        printf '\nGRUB_THEME="%s"\n' "$theme_path" >> "$GRUB_CONFIG"
    fi
    echo -e "${GREEN}[OK] GRUB theme configured"
}
main(){
    check_root
    show_banner
    show_welcome
    ask_confirmation
    detect_grub
    backup_grub
    install_theme
    configure-grub
}

main "$@"