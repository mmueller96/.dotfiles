#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# capture working directory
working_dir=$(pwd)
dependencies=(curl stow git)
snap_dependencies=(codium)

# prints an info to the screen
info() {
    printf "\r  [\033[00;34mINFO\033[0m] $1\n"
}

# prints a success-message to the screen
success() {
    printf "\r\033[2K  [\033[00;32m OK \033[0m] $1\n"
    echo ""
}

# verifies that dependencies are installed on Linux
verify_linux_dependencies() {
    sudo apt update -q > /dev/null
    for lib in "${dependencies[@]}"
    do
        info "Installing $lib if not present"
        sudo apt install $lib -q --yes > /dev/null
        success "$lib is installed"
    done
}

# verifies that dependencies are installed with snap (os specific)
verify_snap_dependencies() {
    for lib in "${snap_dependencies[@]}"
    do
        info "Installing $lib if not present"
        sudo snap install $lib --classic > /dev/null
        success "$lib is installed"
    done
}

# verifies environment and installs dependencies (os specific)
verify_runtime(){
    os_type=$(uname)
    case "$os_type" in 
        "Linux" )
        {
            info "Running on Linux"
            verify_linux_dependencies
            verify_snap_dependencies
        };;
        *)
        {
            error "Unsupported OS"
        };;
    esac
}

# creates a file link
link_file(){
    info "Linking with stow adopt"
    stow --adopt . > /dev/null
    success "everything linked"
}

verify_runtime
link_file

bash install-vscode-extensions.sh

success "All done! 🚀"