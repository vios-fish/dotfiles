# boost mpi を使う
user_configFile=`find $PWD -name user-config.jam`
if [ "$user_configFile" = "" ] ; then
	user_configFile="./user-config.jam"
fi
echo "using gcc : 5.0 : /usr/bin/gcc-5.0 ;" >> $user_configFile
echo "using mpi ;" >> $user_configFile
cp $user_configFile ~

# boost のインストール
./bootstrap.sh --with-toolset=gcc --with-libraries=all --prefix=~/lib
./b2 toolset=gcc-5.0 cxxflags="-std=c++11" --with=all -link=static,shared runtime-link=shared threading=multi variant=release --stagedir="stage/gcc" instruction-set=haswell -j9

# パスを通す
#echo export CPLUS_INCLUDE_PATH=$HOME/local/include:\$CPLUS_INCLUDE_PATH >> ~/.bashrc
#sudo sh -c 'echo $HOME/lib/boost_1_57_0/stage/gcc/lib >> /etc/ld.so.conf.d/local.conf'
#sudo ldconfig
