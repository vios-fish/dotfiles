#! /usr/bin/zsh

OPENCV_VERSION=3.1.0
INSTALL_DIR=~/local

sudo sed -i 's/# deb-src http:\/\/jp.archive.ubuntu.com\/ubuntu\/ xenial universe/deb-src http:\/\/jp.archive.ubuntu.com\/ubuntu\/ xenial universe/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade
sudo apt-get build-dep opencv
sudo apt-get install qt5-default

mkdir ~/tmp
pushd ~/tmp

# get opencv
git clone https://github.com/opencv/opencv.git
pushd opencv
git pull
git checkout ${OPENCV_VERSION}
popd

# get opencv_contrib
git clone https://github.com/opencv/opencv_contrib.git
pushd opencv
git pull
git checkout ${OPENCV_VERSION}
popd

pushd opencv
mkdir build
pushd build
cmake -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
	  -D WITH_TBB=ON \
	  -D WITH_FFMPEG=ON \
	  -D WITH_IPP=ON \
	  -D WITH_QT=ON \
	  -D CMAKE_CXX_FLAGS=-std=c++11 \
	  -D CMAKE_CXX_COMPILER=/usr/bin/g++ \
	  -D CMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
	  ../


# cmake -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
# 	  -D WITH_TBB=ON \
# 	  -D WITH_FFMPEG=ON \
# 	  -D WITH_IPP=ON \
# 	  -D WITH_QT=ON \
# 	  -D CMAKE_CXX_FLAGS=-std=c++11 \
# 	  -D CMAKE_CXX_COMPILER=/usr/bin/g++ \
# 	  -D CMAKE_CC_COMPILER=/usr/bin/gcc \
# 	  -DCMAKE_INSTALL_PREFIX=~/local \
# 	  ../


make -j9
sudo make install

cp 3rdparty/ippicv/unpack/ippicv_lnx/lib/intel64/libippicv.a ${INSTALL_DIR}/lib/libippciv.a

