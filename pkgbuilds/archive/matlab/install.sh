#!/bin/sh
set -eux

extract_dir=matlabroot
installer_dir=matlab
unzip -X -K matlab_*_glnxa64.zip -d $extract_dir
# mv $extract_dir/bin/glnxa64/libfreetype.so.6 \
#    $extract_dir/bin/glnxa64/libfreetype.so.6.MATLAB
./matlabroot/install
date_dir=`echo $installer_dir/*`
mv $date_dir/* $installer_dir/
rmdir $date_dir
tar -I zstd -cvf matlab.tar $installer_dir
makepkg -s
