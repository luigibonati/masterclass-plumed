# Instructions for installing the software

The following software is required for running this masterclass:

- PLUMED configured with LibTorch + OPES & PyTorch modules
- mlcvs python library 

## Install LibTorch

You can follow the [instructions](https://www.plumed.org/doc-master/user-doc/html/_p_y_t_o_r_c_h.html) on the PLUMED manual to download and configure LibTorch. Here we report them for convenience. 

We can download the pre-built LibTorch library from their website. The following script downloads the 1.13.1 version (Linux, CPU, with C++11 ABI compatibility), check [here](https://pytorch.org/) for other platforms/versions.

```
wget https://download.pytorch.org/libtorch/cpu/libtorch-cxx11-abi-shared-with-deps-1.13.1%2Bcpu.zip
unzip libtorch-cxx11-abi-shared-with-deps-1.13.1+cpu.zip 
rm libtorch-cxx11-abi-shared-with-deps-1.13.1+cpu.zip
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
git clone https://github.com/plumed/plumed2.git

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

If you want to use conda you can create an environment named `masterclass22.05`, activate it, and install the required dependencies:

```
conda create -n masterclass22-05
conda activate masterclass22-05

conda install numpy pandas matplotlib scikit-learn -c conda-forge
]conda install pytorch -c pytorch
```

If you want to use pip: 

```
python3 -m venv masterclass22-05
source masterclass22-05/bin/activate

pip3 install torch --extra-index-url https://download.pytorch.org/whl/cpu
pip install numpy pandas matplotlib scikit-learn
```

Once the dependencies have been installed you can clone the repository and install the package:

```
git clone https://github.com/luigibonati/mlcvs.git -b v0.1.1

cd mlcvs/
pip install . 
```

## Download the data

Download the repository containing the jupyter notebooks and the data for running the simulations:

```
git clone https://github.com/luigibonati/masterclass-plumed.git
```
