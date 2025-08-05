#!/usr/bin/env bash
set -e

script_dir=$(cd "$(dirname "${BASH_SOURCE:-$0}")"; pwd)

ask() {
  printf "%s [y/n]:" "$*"
  local answer
  read -r answer

  case $answer in
    "yes" ) return 0 ;;
    "y" )   return 0 ;;
    "Y" )   return 0 ;;
    * )     return 1 ;;
  esac
}

inst() {
    sudo apt-get install -y "$@"
}

#env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

sudo sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get upgrade -y

# for repositories
mkdir -p ~/repos
mkdir -p ~/local

if ask 'basic environment setup?'; then
    # install basic
    inst build-essential zsh git curl wget python-is-python3 ruby tree gnome-tweaks

    # set locale
    inst locales
    sudo locale-gen ja_JP

    # install docker
    inst apt-transport-https ca-certificates curl software-properties-common
    sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt-get update
    inst docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    # docker post-installation steps
    sudo groupadd docker
    sudo usermod -aG docker "$(whoami)"
    newgrp docker
fi

ANYENV_HOME=$HOME/.anyenv
export PATH=$ANYENV_HOME/bin:$PATH
if ask 'install anyenv?'; then
    if [ ! -e ~/repos/anyenv ]; then
	    git clone https://github.com/riywo/anyenv ~/repos/anyenv
    fi
    if [ ! -e "$ANYENV_HOME" ]; then
        ln -sf ~/repos/anyenv "$ANYENV_HOME"
    fi
    eval "$(anyenv init -)"

    mkdir -p "$(anyenv root)"/plugins
    if [ ! -e "$(anyenv root)"/plugins/anyenv-update ]; then
	    git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"
    fi

    anyenv install --force-init || :
    anyenv install pyenv
    if [ ! -e "$ANYENV_HOME/envs/pyenv/plugins/pyenv-virtualenv" ]; then
      git clone https://github.com/yyuu/pyenv-virtualenv "$ANYENV_HOME/envs/pyenv/plugins/pyenv-virtualenv"
    fi

    anyenv install nodenv
    anyenv install goenv
    anyenv install rbenv
fi
if type "anyenv" > /dev/null 2>&1; then
  eval "$(anyenv init -)"
fi

if ask 'install tools?'; then
    # install tools
    inst jq xsel upx python3-pip python3-venv pipx pipenv

    pipx install poetry

    # install go latest
    goenv install latest
    goenv global latest

    # install peco
    inst peco
fi

if ask 'install emacs?'; then
    inst emacs cmigemo silversearcher-ag fonts-roboto fonts-noto fonts-ricty-diminished

    # install third party software
    sudo pip3 install jedi virtualenv

    # setup directory
    if [ -L  ~/.emacs.d ]; then
      unlink ~/.emacs.d
    fi
    ln -sfb "${script_dir}/emacs.d" ~/.emacs.d
    mkdir -p ~/.emacs.d/backup
fi

if ask 'install zsh?'; then
  inst zsh

  # install zprezto
  if [ ! -e "${ZDOTDIR:-$HOME}/.zprezto" ]; then
    git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

    ln -sf "${script_dir}/zlogin" ~/.zlogin
    ln -sf "${script_dir}/zlogout" ~/.zlogout
    ln -sf "${script_dir}/zpreztorc" ~/.zpreztorc
    ln -sf "${script_dir}/zprofile" ~/.zprofile
    ln -sf "${script_dir}/zshenv" ~/.zshenv
    ln -sf "${script_dir}/zshrc" ~/.zshrc
    ln -sf "${script_dir}/.p10k.zsh" ~/.p10k.zsh
  fi

  chsh -s "$(which zsh)" "$(whoami)"
fi

if ask 'install rust?'; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

if ask 'install aws-cli'; then
  pipx install --force awscliv2 aws-sam-cli
fi
