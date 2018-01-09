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

sudo sed -i.bak -e "s%http://us.archive.ubuntu.com/ubuntu/%http://ftp.jaist.ac.jp/pub/Linux/ubuntu/%g" /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get upgrade -y

# karnel
sudo apt-get install -y \
	linux-image-extra-$(uname -r) \
    linux-image-extra-virtual

if ask 'basic environment setup?'; then
	# add ppa
	sudo add-apt-repository ppa:webupd8team/java # for java
	sudo add-apt-repository ppa:jonathonf/golang-1.7 # for go-lang
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
	sudo systemctl status docker
	sudo usermod -aG docker $(whoami)

	# install tools
	inst jq
	inst xsel

	# install java
	inst oracle-java8-installer
	inst maven

	# install latest stable nodejs
	inst nodejs npm
	# sudo npm cache clean
	sudo npm cache verify
	sudo npm install -g n
	sudo n stable
	sudo ln -sf /usr/local/bin/node /usr/bin/node
	sudo apt-get purge -y nodejs npm

	# install casperjs
	npm install phantomjs
	npm install casperjs

	# install go latest
    inst golang-1.7
	
	# isntall peco
	export GOPATH=$HOME/local/go
	export PAHT=$PATH:$GOPATH/bin
	go get github.com/peco/peco/cmd/peco
fi

if ask 'install ricty-powerline?'; then
	echo "not"
	pip install --user git+git://github.com/powerline/powerline
fi

if ask 'install emacs?'; then
	inst emacs cmigemo silversearcher-ag
	git clone https://github.com/vios-fish/dotfiles.git ~/dotfiles

	# install thirdparty software
	sudo pip install jedi virtualenv
	
	# setup direcotry
	ln -s ~/dotfiles/.emacs.d ~/.emacs.d
	mkdir ~/.emacs.d/backup
fi

if ask 'install aws python env'; then
	sudo pip install boto boto3 awscli
	sudo pip install pycrypto
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
