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
