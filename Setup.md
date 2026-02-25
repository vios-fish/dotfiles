# Development Environment Setup

This document serves as an interactive runbook for setting up the `vios-fish` local development environment. You can execute these blocks directly using [Runme](https://runme.dev/).

## 1. Directory Structure

First, ensure your base directories are created.

```bash {"id":"01HXTZ9XYZ"}
mkdir -p ~/repos
mkdir -p ~/local
```

## 2. Environment Selection

Choose your environment base below and execute its respective setup block.

### Option A: Local Ubuntu (Native)

This block sets up dependencies necessary when running on a full Ubuntu desktop or WSL environment without a container.

```bash {"id":"01HXTZAABC"}
# Install core system packages
sudo apt-get update -y
sudo apt-get install -y build-essential zsh git curl wget python-is-python3 ruby tree gnome-tweaks locales xsel

# Setup Locale
sudo locale-gen ja_JP

# Install and start Docker natively
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker || true
sudo usermod -aG docker "$(whoami)"
```

### Option B: Devcontainer

Devcontainers usually come pre-bundled with standard tools (like git, docker, and basic build tools), meaning we can skip OS-level daemon installations.

```bash {"id":"01HXTZBBCC"}
# Install lightweight dependencies
sudo apt-get update -y
sudo apt-get install -y zsh curl wget xsel
```

---

## 3. Emacs Setup (Optional)

```bash {"id":"01HXTZEEDD"}
sudo apt-get install -y emacs cmigemo silversearcher-ag fonts-roboto fonts-noto fonts-ricty-diminished

# Create XDG config directory
mkdir -p ~/.config/emacs

# Move custom emacs config into place safely
if [ -L ~/.config/emacs/init.el ]; then
  rm ~/.config/emacs/init.el
elif [ -d ~/.config/emacs ]; then
  mv ~/.config/emacs ~/.config/emacs.bak
fi

ln -sfb ~/repos/dotfiles/emacs.d ~/.config/emacs
mkdir -p ~/.config/emacs/backup
```

## 4. Install Mise & Toolchains

Instead of installing `nvm`, `pyenv`, `goenv`, etc., we use `mise` to manage all toolchains via `mise.toml`.

```bash {"id":"01HXTZFFGH"}
# Install mise
curl https://mise.run | sh

# Ensure mise is momentarily activated so we can run install
eval "$(~/.local/bin/mise activate bash)"

# Install all tools defined in ~/repos/dotfiles/mise.toml
cd ~/repos/dotfiles
~/.local/bin/mise install
```

## 5. Zsh & Terminal Configuration

We use zsh with Prezto and Powerlevel10k.

```bash {"id":"01HXTZHHIJ"}
# Define Zsh XDG Base Directory
export ZDOTDIR="$HOME/.config/zsh"
mkdir -p "$ZDOTDIR"

# Clone Prezto safely into ZDOTDIR
if [ ! -e "$ZDOTDIR/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "$ZDOTDIR/.zprezto"
fi

# Link zsh configurations gracefully
link_if_needed() {
  src=$1
  dest=$2
  
  if [ -L "$dest" ]; then
    rm "$dest"
  elif [ -f "$dest" ]; then
    mv "$dest" "${dest}.bak"
  fi
  
  ln -sf "$src" "$dest"
}

cd ~/repos/dotfiles

# The only file that stays in $HOME is .zshenv to bootstrap XDG
link_if_needed "${PWD}/zsh.d/zshenv" ~/.zshenv

# Link everything else into ~/.config/zsh/
link_if_needed "${PWD}/zsh.d/zlogin" "$ZDOTDIR/.zlogin"
link_if_needed "${PWD}/zsh.d/zlogout" "$ZDOTDIR/.zlogout"
link_if_needed "${PWD}/zsh.d/zpreztorc" "$ZDOTDIR/.zpreztorc"
link_if_needed "${PWD}/zsh.d/zprofile" "$ZDOTDIR/.zprofile"
link_if_needed "${PWD}/zsh.d/zshrc" "$ZDOTDIR/.zshrc"
link_if_needed "${PWD}/zsh.d/.p10k.zsh" "$ZDOTDIR/.p10k.zsh"

# Change default shell
sudo chsh -s "$(which zsh)" "$(whoami)"
```
