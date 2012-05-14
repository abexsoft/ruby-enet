
BUILD_DIR=${1:-$PWD/build}

(cd enet-1.3.3 && ./configure --prefix=$BUILD_DIR --enable-shared=no && make && make install)
