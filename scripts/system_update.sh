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

# Detect package manager
detect_package_manager() {
    for cmd in apt dnf yum pacman zypper; do
        if command -v "$cmd" &> /dev/null; then
            echo "$cmd"
            return 0
        fi
    done
    log error "No supported package manager found."
    exit 1
}

# Detect distribution name
detect_distribution() {
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        echo "$PRETTY_NAME"
    else
        log warning "Unable to detect distribution name."
        echo "Unknown Distribution"
    fi
}

# Perform system update
perform_update() {
    local package_manager="$1"
    
    case "$package_manager" in
        apt)
            log info "Updating package list..."
            apt-get update -qq
            log info "Upgrading packages..."
            DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
            log info "Performing distribution upgrade..."
            DEBIAN_FRONTEND=noninteractive apt-get dist-upgrade -y
            ;;
        dnf)
            log info "Updating and upgrading packages..."
            dnf upgrade -y
            ;;
        yum)
            log info "Updating and upgrading packages..."
            yum update -y
            ;;
        pacman)
            log info "Synchronizing package databases..."
            pacman -Syu --noconfirm
            ;;
        zypper)
            log info "Refreshing repositories..."
            zypper refresh
            log info "Upgrading packages..."
            zypper update -y
            ;;
        *)
            log error "Unsupported package manager: $package_manager"
            exit 1
            ;;
    esac
    
    log success "System update completed."
}

# Remove unused packages
perform_cleanup() {
    local package_manager="$1"
    
    case "$package_manager" in
        apt)
            apt-get autoremove -y
            apt-get autoclean
            ;;
        dnf)
            dnf autoremove -y
            dnf clean all
            ;;
        yum)
            yum autoremove -y
            yum clean all
            ;;
        pacman)
            pacman -Rns $(pacman -Qdtq) --noconfirm || log warning "No orphaned packages to remove."
            ;;
        zypper)
            zypper remove --clean-deps
            ;;
        *)
            log warning "Cleanup not supported for: $package_manager"
            ;;
    esac
    
    log success "System cleanup completed."
}

# Show help message
show_help() {
    cat <<EOF
Usage: $0 [options]

Options:
  --help       Show this help message
  --cleanup    Perform cleanup after updates

Examples:
  $0           Perform system update
  $0 --cleanup Update system and remove unused packages
EOF
    exit 0
}

# Main script execution
main() {
    validate_root

    local cleanup=false
    local package_manager
    local distribution

    # Parse arguments
    for arg in "$@"; do
        case "$arg" in
            --help)    show_help ;;
            --cleanup) cleanup=true ;;
            *)
                log warning "Unknown option: $arg"
                show_help
                ;;
        esac
    done

    package_manager=$(detect_package_manager)
    distribution=$(detect_distribution)
    log info "Detected distribution: $distribution"
    log info "Using package manager: $package_manager"

    perform_update "$package_manager"

    if [[ "$cleanup" == true ]]; then
        perform_cleanup "$package_manager"
    fi

    log success "Update process completed successfully."
}

# Execute main function with all script arguments
main "$@"
