#!/bin/bash

# Strict mode for safer scripting
set -euo pipefail

# Enhanced logging with timestamp
log() {
    local type="$1"
    local message="$2"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    case "$type" in
        info)    echo -e "[$timestamp] \033[1;34m[INFO]\033[0m $message" ;;
        success) echo -e "[$timestamp] \033[1;32m[SUCCESS]\033[0m $message" ;;
        error)   echo -e "[$timestamp] \033[1;31m[ERROR]\033[0m $message" ;;
        warning) echo -e "[$timestamp] \033[1;33m[WARNING]\033[0m $message" ;;
    esac
}

# Check for root permissions
if [[ $EUID -ne 0 ]]; then
    log error "This script must be run as root. Use sudo."
    exit 1
fi

# Backup existing files before modification
backup_file() {
    local file="$1"
    if [[ -f "$file" ]]; then
        cp "$file" "${file}.bak"
        log info "Backed up $file to ${file}.bak"
    else
        log warning "$file does not exist. Skipping backup."
    fi
}

# Main configuration function
configure_os_identity() {
    local os_name="NebulixOS"
    local os_version="1.0"
    local base_distro="Debian 12 Bookworm"

    # Files to configure
    local files=("/etc/os-release" "/etc/debian_version" "/etc/lsb-release")

    # Backup existing files
    for file in "${files[@]}"; do
        backup_file "$file"
    done

    # Update /etc/os-release
    log info "Configuring /etc/os-release..."
    cat > /etc/os-release <<EOF
NAME="$os_name"
VERSION="$os_version (Based on $base_distro)"
ID=$(echo "$os_name" | tr '[:upper:]' '[:lower:]')
ID_LIKE=debian
PRETTY_NAME="$os_name $os_version"
VERSION_ID="$os_version"
HOME_URL="https://$(echo "$os_name" | tr '[:upper:]' '[:lower:]').org"
SUPPORT_URL="https://$(echo "$os_name" | tr '[:upper:]' '[:lower:]').org/support"
BUG_REPORT_URL="https://$(echo "$os_name" | tr '[:upper:]' '[:lower:]').org/issues"
EOF

    # Update /etc/debian_version
    log info "Configuring /etc/debian_version..."
    echo "$base_distro ($os_name $os_version)" > /etc/debian_version

    # Update /etc/lsb-release
    log info "Configuring /etc/lsb-release..."
    cat > /etc/lsb-release <<EOF
DISTRIB_ID=$os_name
DISTRIB_RELEASE=$os_version
DISTRIB_CODENAME=$(echo "$base_distro" | awk '{print tolower($2)}')
DISTRIB_DESCRIPTION="$os_name $os_version (Based on $base_distro)"
EOF

    # Validate changes
    log info "Verifying configuration..."
    for file in "${files[@]}"; do
        if [[ -f "$file" ]]; then
            log success "Configured: $file"
        else
            log error "Failed to configure: $file"
        fi
    done
}

# Execute main function
configure_os_identity

log success "System identification configuration completed successfully!"