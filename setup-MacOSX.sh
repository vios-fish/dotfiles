#!/bin/bash
BREWFILE_DIR=./MacOSX
ANYENV_HOME=$HOME/.anyenv

ask() {
  printf "$* [y/n] "
  local answer
  read answer

  case $answer in
    "yes" ) return 0 ;;
    "y" )   return 0 ;;
    * )     return 1 ;;
  esac
}

set -e

if ask 'xcode install?'; then
  xcode-select --install
fi

if ask 'Homebrew install?'; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

  brew doctor
fi

if ask 'execute brew bundle(Brewfile)?'; then
  brew tap Homebrew/bundle
  pushd $BREWFILE_DIR
  brew bundle
  popd
fi

# if ask 'restore setting from mackup? (need Dropbox directory)?'; then
#   mackup restore
# fi

if ask 'setting zsh config?'; then
    if [ ! -e "${HOME}/.zprezto" ]; then
	git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
    fi
    
    ln -sfn $(pwd)/.zshrc ~/.zshrc
    ln -fs $(pwd)/.zsh.d ~/.zsh.d
    ln -sfn $(pwd)/.tmux.conf ~/.tmux.conf
fi

if ask "Do you want to setup anyenv?"; then
    if [ ! -e $ANYENV_HOME ]; then
		git clone https://github.com/riywo/anyenv $ANYENV_HOME
    else
		git -C $ANYENV_HOME pull
    fi
    export PATH=$ANYENV_HOME/bin:$PATH
    eval "$(anyenv init -)"

    # plugins
    mkdir -p $(anyenv root)/plugins
    git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update

    # install env
    anyenv install pyenv
    git clone https://github.com/yyuu/pyenv-virtualenv $ANYENV_HOME/envs/pyenv/plugins/pyenv-virtualenv
    anyenv install ndenv
    anyenv install goenv
    anyenv install rbenv
    eval "$(anyenv init -)"
fi

if ask "Create symbolic link for bash_profile?"; then
    ln -sfn $(pwd)/.bash_profile ~/.bash_profile
fi

if ask "Create symbolic link for emacs.d?"; then
    ln -sf $(pwd)/.emacs.d ~/.emacs.d
fi

