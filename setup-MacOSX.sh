#!/bin/bash
BREWFILE_DIR=./.brew.d

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
  brew install caskroom/cask/brew-cask
fi

if ask 'execute brew bundle(Brewfile)?'; then
  brew tap Homebrew/bundle
  pushd $BREWFILE_DIR
  brew brewdler
  popd
fi

if ask 'restore setting from mackup? (need Dropbox directory)'; then
  mackup restore
fi

if ask "Do you want to install ruby by rbenv-rubybuild?"; then
  INSTALL_RUBY_VERSION="$( rbenv install -l | peco)"
  brew link readline --force
  MAKE_OPTS="-j 4" RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)" rbenv install $INSTALL_RUBY_VERSION
fi

if ask "Create symbolic link bash_profile?"; then
	ln -s ~/dotfiles/.bash_profile ~/.bash_profile
fi

if ask "Create symbolic link zsh?"; then
	ln -s ~/dotfiles/.zshrc ~/.zshrc
	ln -s ~/dotfiles/.zsh.d ~/.zsh.d
fi

