#!/bin/bash
mkdir -p ~/tmp
mkdir -p ~/.fonts
pushd ~/tmp

sudo apt-get install -y fontforge

wget http://iij.dl.sourceforge.jp/mix-mplus-ipa/59022/migu-1m-20130617.zip
unzip migu-1m-20130617.zip

git clone https://github.com/google/honts.git

wget http://www.rs.tus.ac.jp/yyusa/ricty/ricty_generator.sh
chmod u+x ricty_generator.sh


./ricty_generator.sh auto


git clone https://github.com/Lokaltog/vim-powerline.git
fontforge -lang=py -script ./vim-powerline/fontpatcher/fontpatcher $HOME/.fonts/Ricty-Regular.ttf
fontforge -lang=py -script ./vim-powerline/fontpatcher/fontpatcher $HOME/.fonts/Ricty-Bold.ttf
mv Ricty*.ttf ~/.fonts

popd

fc-cache -vf
