#!/bin/bash

pkg_list=(
    pkief.material-icon-theme
)

# prints an info to the screen
info() {
    printf "\r  [\033[00;34mINFO\033[0m] $1\n"
}

# prints a success-message to the screen
success() {
    printf "\r\033[2K  [\033[00;32m OK \033[0m] $1\n"
    echo ""
}


for lib in ${pkg_list[@]}; do
    info "Installing $lib if not present"
    codium --install-extension $lib > /dev/null
    success "Extension $lib is installed"
done