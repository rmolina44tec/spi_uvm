#!/bin/csh -f

cd /mnt/vol_NFS_Zener/WD_ESPEC/rimolina/SPI

#This ENV is used to avoid overriding current script in next vcselab run 
setenv SNPS_VCSELAB_SCRIPT_NO_OVERRIDE  1

/mnt/vol_NFS_Zener/tools/synopsys/apps/vcs-mx2/R-2020.12-1/linux64/bin/vcselab $* \
    -o \
    simv \
    -nobanner \

cd -

