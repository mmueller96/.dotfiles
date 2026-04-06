#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# capture working directory
working_dir=$(pwd)
dependencies=(curl stow git vscodium-bin)

# prints an info to the screen
info() {
    printf "\r  [\033[00;34mINFO\033[0m] $1\n"
}

# prints a success-message to the screen
success() {
    printf "\r\033[2K  [\033[00;32m OK \033[0m] $1\n"
    echo ""
}

# prints an error-message to the screen
error() {
    printf "\r  [\033[00;31mERROR\033[0m] $1\n"
    exit 1
}

# installs yay (AUR helper) if not present
install_yay() {
    if command -v yay &> /dev/null; then
        success "yay is already installed"
        return 0
    fi
    
    info "yay not found. Installing yay (AUR helper)..."
    
    # Install base-devel and git if not present
    if ! pacman -Qi base-devel &> /dev/null; then
        info "Installing base-devel group..."
        sudo pacman -S --noconfirm --needed base-devel > /dev/null
    fi
    
    if ! pacman -Qi git &> /dev/null; then
        info "Installing git..."
        sudo pacman -S --noconfirm --needed git > /dev/null
    fi
    
    # Clone and build yay
    local temp_dir=$(mktemp -d)
    info "Cloning yay from AUR..."
    git clone https://aur.archlinux.org/yay.git "$temp_dir" > /dev/null 2>&1
    
    info "Building and installing yay..."
    cd "$temp_dir"
    makepkg -si --noconfirm > /dev/null 2>&1
    cd "$working_dir"
    
    # Cleanup
    rm -rf "$temp_dir"
    
    if command -v yay &> /dev/null; then
        success "yay has been installed successfully"
    else
        error "Failed to install yay"
    fi
}

# verifies that dependencies are installed on Arch Linux (with AUR support)
verify_arch_dependencies_aur() {
    # Install yay first if needed
    install_yay
    
    # Check if yay or paru is installed (AUR helpers)
    if command -v yay &> /dev/null; then
        AUR_HELPER="yay"
    elif command -v paru &> /dev/null; then
        AUR_HELPER="paru"
    else
        info "No AUR helper found, using pacman for official packages only"
        AUR_HELPER="pacman"
    fi
    
    # Update package databases
    sudo pacman -Sy --noconfirm > /dev/null
    
    for lib in "${dependencies[@]}"
    do
        info "Installing $lib if not present"
        
        if pacman -Qi "$lib" &> /dev/null; then
            success "$lib is already installed"
        else
            # Install with appropriate package manager
            if [[ "$AUR_HELPER" == "pacman" ]]; then
                sudo pacman -S --noconfirm --needed "$lib" > /dev/null
            else
                $AUR_HELPER -S --noconfirm --needed "$lib" > /dev/null
            fi
            success "$lib is installed"
        fi
    done
}

# verifies environment and installs dependencies (os specific)
verify_runtime(){
    os_type=$(uname)
    case "$os_type" in 
        "Linux" )
        {
            info "Running on Linux"
            verify_arch_dependencies_aur
        };;
        *)
        {
            error "Unsupported OS"
        };;
    esac
}

# creates a file link - excludes .sh and .md files
link_file(){
    info "Linking dotfiles from $working_dir to $HOME (excluding scripts and README)"
    stow --adopt --target "$HOME" \
         --ignore '\.sh$' \
         --ignore 'README\.md$' \
         --ignore '\.md$' \
         . > /dev/null
    success "everything linked to $HOME (excluding .sh and .md files)"
}

verify_runtime
link_file

bash install-vscode-extensions.sh

success "All done! 🚀"