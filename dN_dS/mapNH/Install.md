```bash
PROJECTDIR=$HOME/bpp/
mkdir -p $PROJECTDIR/

cd $PROJECTDIR
git clone https://github.com/BioPP/bpp-core
git clone https://github.com/BioPP/bpp-seq
git clone https://github.com/BioPP/bpp-popgen
git clone https://github.com/BioPP/bpp-phyl
git clone https://github.com/BioPP/bppsuite
#
git clone https://github.com/BioPP/testnh.git

cd bpp-core
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local .. # prepare compilation
make # compile
make install 

# bpp-seq
cd $PROJECTDIR/bpp-seq
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local .. # prepare compilation
make # compile
make install 

# bpp-popgen
cd $PROJECTDIR/bpp-popgen
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local .. # prepare compilation
make # compile
make install 

# bpp-phyl
cd $PROJECTDIR/bpp-phyl
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local .. # prepare compilation
make # compile
make install 

# bpp-suite
cd $PROJECTDIR/bppsuite
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local .. # prepare compilation
make # compile
make install 

# mapNH
cd $PROJECTDIR/testnh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$HOME/.local .. # prepare compilation
make # compile
make install 
```
