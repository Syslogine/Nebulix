#!/bin/bash

# Source the utility script
source "$(dirname "$0")/../utils/utils.sh"

# Detect operating system
detect_os() {
    if [[ ! -f /etc/os-release ]]; then
        log error "Cannot detect OS. /etc/os-release not found."
        exit 1
    fi
    
    source /etc/os-release
    echo "$ID"
}

# Package installation function with error handling
install_packages() {
    local os_id="$1"
    shift
    local packages=("$@")

    case "$os_id" in
        debian|ubuntu|nebulixos)
            apt-get update -qq
            for pkg in "${packages[@]}"; do
                if apt-get install -y "$pkg"; then
                    log success "Installed: $pkg"
                else
                    log error "Failed to install: $pkg"
                fi
            done
            ;;
        *)
            log error "Unsupported package manager for: $os_id"
            exit 1
            ;;
    esac
}

# Display usage information
show_help() {
    cat <<EOF
Usage: $0 [options] package1 [package2 ...]

Options:
  --help       Show this help message
  --dry-run    Simulate the installation without making changes

Examples:
  $0 vim curl
  $0 --dry-run git filezilla
EOF
    exit 0
}

# Main script execution
main() {
    validate_root

    # Handle flags
    local dry_run=false
    local packages=()

    for arg in "$@"; do
        case "$arg" in
            --help)
                show_help
                ;;
            --dry-run)
                dry_run=true
                ;;
            *)
                packages+=("$arg")
                ;;
        esac
    done

    if [[ ${#packages[@]} -eq 0 ]]; then
        log error "No packages specified. Use --help for usage."
        exit 1
    fi

    local os_id
    os_id=$(detect_os)
    log info "Detected OS: $os_id"

    if [[ "$dry_run" == true ]]; then
        log info "Dry-run mode enabled. No changes will be made."
        log info "Packages to install: ${packages[*]}"
    else
        install_packages "$os_id" "${packages[@]}"
        log success "Package installation completed."
    fi
}

# Execute main function with all script arguments
main "$@"
