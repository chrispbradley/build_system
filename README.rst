OpenCMISS Build System
======================

Basic instructions for building the OpenCMISS computational library.

The build system is 99% done so this documentation is interim, more detailed documentation will follow.

1. Install Linux OS or VM etc.

2. Check compiler version. The GCC 13 compilers have a compiler bug (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=103931)
   that means they may not compile the OpenCMISS source. Ensure that you have a compiler that works.

   For example, install GCC 14.

   On Ubuntu

.. code-block: bash
   
   sudo apt install gcc-14 g++-14 gfortran-14
   sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-14 140 
   sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-14 140 
   sudo update-alternatives --install /usr/bin/gfortran gfortran /usr/bin/gfortran-14 140
   gcc -v
   g++ -v
   gfortran -v

3. Install necessary pre-requisite packages.

   - For Ubuntu

.. code-block:: bash
		
     sudo apt install git cmake gfortran pkg-config bison flex libmpich-dev liblapack-dev libblas-dev python3-dev python3-numpy swig doxygen graphviz


   - For Fedora

.. code-block:: bash
		
     sudo git dnf install cmake gcc-gfortran pkgconf bison flex mpich-devel lapack-devel blas-devel python3-devel python3-numpy swig doxygen graphviz

4. Create a directory for OpenCMISS and change directory into it e.g.,

.. code-block:: bash
		
   mkdir ~/OpenCMISS
   cd ~/OpenCMISS

5. Create some sub-directories.

.. code-block:: bash
		
   mkdir setup
   mkdir src
   cd src
   mkdir dependencies

6. There is a small bug in the git repository handling. Until I get a chance to fix the bug the git commands are disabled
   and we will just get the repositories manually. It only has to be done once. This will eventually change.
   
.. code-block:: bash
      
   git clone https://github.com/OpenCMISS/libOpenCMISS.git
   cd dependencies
   git clone https://github.com/OpenCMISS-Dependencies2/FieldML-API.git
   cd FieldML-API
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/GKlib.git
   cd GKlib
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/hdf5.git
   cd hdf5
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/hypre.git
   cd hypre
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/lapack.git
   cd lapack
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/libcellml.git
   cd libcellml
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/libxml2.git
   cd libxml2
   git fetch --all --tags --prune
   git checkout tags/v2.9.11 -b opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/METIS.git
   cd METIS
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/mumps.git
   cd mumps
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/ParMETIS.git
   cd ParMETIS
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/petsc.git
   cd petsc
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/scalapack.git
   cd scalapack
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/scotch.git
   cd scotch
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/slepc.git
   cd slepc
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/superlu.git
   cd superlu
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/superlu_dist.git
   cd superlu_dist
   git checkout opencmiss_develop
   cd ..
   git clone https://github.com/OpenCMISS-Dependencies2/zlib.git
   cd zlib
   git checkout opencmiss_develop
   cd ../../..
  
7. Create the build system files

.. code-block:: bash
		
   cd setup
   cmake -DOpenCMISS_ROOT=~/OpenCMISS -DOpenCMISS_TOOLCHAIN=gnu -DOpenCMISS_MPI=mpich ../build_system/.
   make create_configuration

8. Check the variables are OK, for example for GNU 13.2 with mpich, 

.. code-block:: bash
		
   cd ~/OpenCMISS/build/configs/x86_64-linux/gnu-C13.2-gnu-F13.2/mpi-mpich-system/Release

   
in the Variables directory are the variables that control this configuration of OpenCMISS. Edit if required or just use the current defaults

9. Build OpenCMISS

.. code-block:: bash
		
   make

   
   
