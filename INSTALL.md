# Instructions for installing the software

## Install LibTorch

You can download the pre-built LibTorch library from their website. The following script downloads the recommended 1.8.2 LTS version (Linux, CPU, with C++11 ABI compatibility).

```
wget https://download.pytorch.org/libtorch/lts/1.8/cpu/libtorch-cxx11-abi-shared-with-deps-1.8.2%2Bcpu.zip 
unzip libtorch-cxx11-abi-shared-with-deps-1.8.2+cpu.zip 
rm libtorch-cxx11-abi-shared-with-deps-1.8.2+cpu.zip
LIBTORCH=${PWD}/libtorch
```

The location of the include and library files need to be exported in the environment. Execute the following commands to save them in a file sourceme.sh inside the libtorch folder:

```
echo "export CPATH=${LIBTORCH}/include/torch/csrc/api/include/:${LIBTORCH}/include/:${LIBTORCH}/include/torch:$CPATH" >> ${LIBTORCH}/sourceme.sh
echo "export INCLUDE=${LIBTORCH}/include/torch/csrc/api/include/:${LIBTORCH}/include/:${LIBTORCH}/include/torch:$INCLUDE" >> ${LIBTORCH}/sourceme.sh
echo "export LIBRARY_PATH=${LIBTORCH}/lib:$LIBRARY_PATH" >> ${LIBTORCH}/sourceme.sh
echo "export LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH" >> ${LIBTORCH}/sourceme.sh
. ${LIBTORCH}/sourceme.sh

echo ". ${LIBTORCH}/sourceme.sh" >> ~/.bashrc
```

## Install PLUMED

Download the development version of PLUMED2

```
git clone https://github.com/luigibonati/masterclass-plumed.git

cd plumed2
./configure --enable-libtorch --enable-modules=all
make -j4
. sourceme.sh
cd .. 

echo ". $PWD/sourceme.sh" >> ~/.bashrc
```

## Install GROMACS

Download the 2020.6 version of GROMACS and patch it with the PLUMED version installed.

```
progname=gromacs-2020.6
wget http://ftp.gromacs.org/pub/gromacs/$progname.tar.gz
tar xvf $progname.tar.gz
mv $progname $progname-source
GROMACS_ROOT=${PWD}/gromacs
cd $progname-source
plumed --no-mpi patch -p -f --runtime -e $progname

mkdir build_mpi_omp_sp
cd build_mpi_omp_sp
cmake .. \
  -DGMX_BUILD_OWN_FFTW=ON \
  -DCMAKE_INSTALL_PREFIX=${GROMACS_ROOT}\
  -DGMX_DEFAULT_SUFFIX=ON \
  -DGMX_DOUBLE=OFF \
  -DGMX_MPI=ON \
  -DGMX_OPENMP=ON \
make -j 4 
make install
cd ..

cd ..
rm -rf $progname.tar.gz # $progname-source
source gromacs/bin/GMXRC.bash
echo ". $GROMACS_ROOT/bin/GMXRC.bash" >> ~/.bashrc
```

## Install mlcvs

Create a virtual environment named `masterclass22.05` and activate it:

```
python3 -m venv masterclass22-05
source masterclass22-05/bin/activate
```

First install the dependencies (including the same version of Pytorch 1.8.2!)

```
pip install torch==1.8.2+cpu torchvision==0.9.2+cpu torchaudio==0.8.2 -f https://download.pytorch.org/whl/lts/1.8/torch_lts.html
pip install numpy pandas matplotlib sklearn
```
and then clone the repository and install the package:

```
git clone https://github.com/luigibonati/mlcvs.git

cd mlcvs/
pip install . 
```
