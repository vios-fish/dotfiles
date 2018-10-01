ask() {
  printf "$* [y/n] "
  local answer
  read answer

  case $answer in
    "yes" ) return 0 ;;
    "y" )   return 0 ;;
    "Y" )   return 0 ;;
    * )     return 1 ;;
  esac
}

inst() {
    sudo apt-get install -y $@
}

set -e

env LANGUAGE=C LC_MESSAGES=C xdg-user-dirs-gtk-update

sudo sed -i.bak -e "s%http://[^ ]\+%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get upgrade -y

# for repositories
mkdir -p $HOME/repos
mkdir -p $HOME/local

# karnel
sudo apt-get install -y \
     linux-image-extra-$(uname -r) \
     linux-image-extra-virtual

if ask 'basic environment setup?'; then
    # add ppa
    sudo apt-get update

    # install basic
    inst build-essential
    inst zsh git curl wget
    inst python ruby
    inst tree

    # install docker
    inst apt-transport-https ca-certificates curl software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    sudo add-apt-repository \
	 "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
	  $(lsb_release -cs) \
	  stable"
    sudo apt-get update
    inst docker-ce
    sudo usermod -aG docker $(whoami)
fi

ANYENV_HOME=$HOME/.anyenv
export PATH=$ANYENV_HOME/bin:$PATH
if ask 'install anyenv?'; then
    if [ ! -e $ANYENV_HOME ]; then
	git clone https://github.com/riywo/anyenv ~/repos/anyenv	
    fi
    ln -sf ~/repos/anyenv $ANYENV_HOME
    eval "$(anyenv init -)"

    mkdir -p $(anyenv root)/plugins
    if [ ! -e $(anyenv root)/plugins/anyenv-update ]; then
	git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
    fi

    anyenv install pyenv
    git clone https://github.com/yyuu/pyenv-virtualenv $ANYENV_HOME/envs/pyenv/plugins/pyenv-virtualenv
    anyenv install ndenv
    anyenv install goenv
    anyenv install rbenv
fi
eval "$(anyenv init -)"


if ask 'install tools?'; then
    # install tools
    inst jq
    inst xsel

    # install go latest
    goenv install 1.10.0
    goenv global 1.10.0
    
    # isntall peco
    PECO_HOME=$HOME/repos/peco
    if [ ! -e $PECO_HOME ]; then
	git clone --depth 1 https://github.com/peco/peco.git $PECO_HOME
    fi
    export GOPATH=$HOME/local/go
    export PAHT=$PATH:$GOPATH/bin
    go get github.com/Masterminds/glide
    go install github.com/Masterminds/glide
    pushd $PECO_HOME
    glide install
    go build cmd/peco/peco.go
fi

if ask 'install emacs?'; then
    inst emacs cmigemo silversearcher-ag
    git clone https://github.com/vios-fish/dotfiles.git ~/repos/dotfiles

    # install thirdparty software
    sudo pip install jedi virtualenv
    
    # setup direcotry
    ln -s ~/dotfiles/.emacs.d ~/.emacs.d
    mkdir ~/.emacs.d/backup
fi

if ask 'install google chrome?'; then
    sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
    sudo apt-get update
    inst google-chrome-stable
fi

if ask 'install slack?'; then
    echo "not"
fi
