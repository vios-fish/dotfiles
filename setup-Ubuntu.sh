BREWFILE_DIR=./

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

if ask 'Homebrew install?'; then
	sudo apt-get install build-essential curl git m4 ruby \
		 texinfo libbz2-dev libcurl4-openssl-dev libexpat-dev \
		 libncurses-dev zlib1g-dev
	ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
fi

if ask 'zshrc install?'; then
	zsh
	ln -s .zshrc ~/.zshrc
	ln -s .zsh.d ~/.zsh.d
	touch ~/.xmodmap
	source ~/.zshrc
fi

if ask 'execute brew bundle(Brewfile)?'; then
	brew tap Homebrew/bundle
	pushd $BREWFILE_DIR
	brew bundle
	popd
fi

if ask "Do you want to install ruby by rbenv-rubybuild?"; then
  INSTALL_RUBY_VERSION="$( rbenv install -l | peco)"
  brew link readline --force
  MAKE_OPTS="-j 4" RUBY_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)" rbenv install $INSTALL_RUBY_VERSION
fi

if ask "Do you want to install python by pyenv-pythonbuild?"; then
  INSTALL_PYTHON_VERSION="$( pyenv install -l | peco)"
  brew link readline --force
  MAKE_OPTS="-j 4" PYTHON_CONFIGURE_OPTS="--with-readline-dir=$(brew --prefix readline)" pyenv install $INSTALL_PYTHON_VERSION
fi
