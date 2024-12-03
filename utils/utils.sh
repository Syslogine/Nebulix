#!/bin/bash

# Strict mode for safer scripting
set -euo pipefail

# Enhanced logging function
log() {
    local type="$1"
    local message="$2"
    local timestamp
    timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    local color
    case "$type" in
        info)    color="\033[1;34m" ;;
        success) color="\033[1;32m" ;;
        error)   color="\033[1;31m" ;;
        warning) color="\033[1;33m" ;;
    esac
    echo -e "[$timestamp] ${color}[${type^^}]\033[0m $message" >&2
}

# Validate root permissions
validate_root() {
    if [[ $EUID -ne 0 ]]; then
        log error "This script requires root privileges. Use sudo."
        exit 1
    fi
}
