#!/bin/bash
#
# ------------- FOSS Analog Design Script --------------
#
# This script is a little hack-homemade thing to install
# all the needed tools for analog IC design with open
# source tools on a Debian type distro.
#
# Tools to be installed:
#	- ngspice  : analog simulator
#	- magic    : layout tool
#	- open_pdk : sky130 PDK
#	- xschem   : schematic editor
# 
# All of the tools will be installed in the directory
# 'tools' and the git repos will be cloned to the 
# directory 'repos'.
#
# The '~/.bashrc' file will be updated to include the
# 'tools' directory in the path.
#
# ------------------------------------------------------

ICDIR=$(pwd)
TOOLSDIR=$(pwd)/tools
mkdir -p tools
mkdir -p repos
grep -qxF "PATH=\$PATH:$TOOLSDIR/bin" ~/.bashrc || echo "PATH=\$PATH:$TOOLSDIR/bin" >> ~/.bashrc
export PATH=$PATH:$TOOLSDIR/bin

# -- STEP 0 : INSTALL DEPENDENCIES --

# for magic
echo "--- INSTALLING DEPENDECIES FOR MAGIC ---\n\n"
sudo apt-get -y install m4 tcsh csh libx11-dev tcl-dev tk-dev \
	libcairo2-dev mesa-common-dev libglu1-mesa-dev \
	libncurses-dev
echo "Installed Dependencies for magic!\n\n"

# for xschem
echo "--- INSTALLING DEPENDECIES FOR XSCHEM ---\n\n"
sudo apt-get -y install libx11-6 libx11-dev libxrender1 \
	libxrender-dev libxcb1 libx11-xcb-dev libcairo2 \
	libcairo2-dev tcl8.6 tcl8.6-dev tk8.6 tk8.6-dev \
       	flex bison libxpm4 libxpm-dev gawk tcl-tclreadline
echo "Installed Dependencies for xschem!\n\n"

# -- INSTALL NGSPICE --

echo "--- INSTALLING NGSPICE ---\n\n"
sudo apt-get install -y ngspice

# -- INSTALL MAGIC --

cd repos

echo "--- INSTALLING MAGIC ---\n\n"
git clone https://github.com/RTimothyEdwards/magic.git
cd magic
./configure --prefix=$TOOLSDIR
make
sudo make install
cd ..

# -- INSTALL OPEN_PDK --

echo "--- INSTALLING OPEN_PDK ---\n\n"
git clone https://github.com/RTimothyEdwards/open_pdks.git
cd open_pdks
./configure --prefix=$TOOLSDIR --enable-sky130-pdk
make
sudo make install
cd ..

# -- INSTALL XSCHEM --

echo "--- INSTALLING XSCHEM ---\n\n"
git clone https://github.com/StefanSchippers/xschem.git
cd xschem
./configure --prefix=$TOOLSDIR
make
sudo make install
cd ../..

echo "--- TOOL SETUP DONE ---"
