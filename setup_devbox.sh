#!/bin/bash
set -e

# Get the directory where this script is located
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE:-$0}")"; pwd)

echo "Setting up Devbox environment..."

# -----------------------------------------------------------------------------
# Zsh / Prezto Setup
# -----------------------------------------------------------------------------
echo "Setting up Zsh and Prezto..."

# Install zprezto if not exists
if [ ! -d "${HOME}/.zprezto" ]; then
    echo "Cloning zprezto..."
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
fi

# Link zsh config files
# Files in repo: zlogin, zlogout, zpreztorc, zprofile, zshenv, zshrc, .p10k.zsh
# Target: ~/.zlogin, ~/.zlogout, etc.

FILES=("zlogin" "zlogout" "zpreztorc" "zprofile" "zshenv" "zshrc" ".p10k.zsh")

for file in "${FILES[@]}"; do
    if [[ "$file" == .p10k.zsh ]]; then
       src="${SCRIPT_DIR}/${file}"
       dst="${HOME}/${file}"
    else
       src="${SCRIPT_DIR}/${file}"
       dst="${HOME}/.${file}"
    fi

    # Check if src exists
    if [ -f "$src" ]; then
        ln -sf "$src" "$dst"
        echo "Linked $src to $dst"
    else
        echo "Warning: $src not found, skipping link."
    fi
done


# -----------------------------------------------------------------------------
# Emacs Setup
# -----------------------------------------------------------------------------
echo "Setting up Emacs..."
if [ -L "${HOME}/.emacs.d" ]; then
    unlink "${HOME}/.emacs.d"
elif [ -d "${HOME}/.emacs.d" ]; then
    echo "Backing up existing .emacs.d"
    mv "${HOME}/.emacs.d" "${HOME}/.emacs.d.bak.$(date +%s)"
fi

if [ -d "${SCRIPT_DIR}/emacs.d" ]; then
    ln -sfb "${SCRIPT_DIR}/emacs.d" "${HOME}/.emacs.d"
    echo "Linked emacs.d"
else
     echo "Warning: emacs.d not found in ${SCRIPT_DIR}"
fi

mkdir -p "${HOME}/.emacs.d/backup"

echo "Setup complete!"
