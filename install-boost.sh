#! /usr/bin/zsh

INSTALL_DIR=~/local

sudo apt-get build-dep libboost-dev
sudo apt-get install libbz2-dev

mkdir ~/tmp
pushd ~/tmp

git clone --recursive https://github.com/boostorg/boost.git

pushd boost
# boost mpi を使う
user_configFile=`find $PWD -name user-config.jam`
if [ "$user_configFile" = "" ] ; then
	user_configFile="./user-config.jam"
	touch $user_configFile
fi
cp $user_configFile ~/
echo "using gcc : 5 : /usr/bin/g++-5 ;" >> ~/user_config.jam
echo "using mpi ;" >> ~/user_config.jam

# boost のインストール
./bootstrap.sh --with-toolset=gcc --with-libraries=all --prefix=${INSTALL_DIR}
./b2 toolset=gcc-5 cxxflags="-std=c++11" --with=all -link=static,shared runtime-link=shared threading=multi variant=release --stagedir="stage/gcc" instruction-set=haswell -j9 install

rm -f ~/$user_config.jam

# パスを通す
#echo export CPLUS_INCLUDE_PATH=$HOME/local/include:\$CPLUS_INCLUDE_PATH >> ~/.bashrc
#sudo sh -c 'echo $HOME/lib/boost_1_57_0/stage/gcc/lib >> /etc/ld.so.conf.d/local.conf'
#sudo ldconfig
