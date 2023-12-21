##  路径脚本
add_path() {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$1:$PATH" 2>/dev/null
    fi
}

## CUDA
# export PATH=/usr/local/cuda/bin:$PATH 2>/dev/null
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
export NVCC_PREPEND_FLAGS='-ccbin /usr/local/cuda/bin'
add_path /usr/local/cuda/bin


## Seisunix   madagascar   sac  and other geosoftwares
# export OPTROOT='/opt'
export OPTROOT='~/opt'

#export RSFROOT="${OPTROOT}/ahay"
#export CWPROOT="${OPTROOT}/cwp"
#export SACROOT="${OPTROOT}/sac"
export LOCFLOWROOT="${OPTROOT}/locflow"
export SOFI2DROOT="${OPTROOT}/SOFI2D"
export SOFI3DROOT="${OPTROOT}/SOFI3D"
export IFOS2DROOT="${OPTROOT}/IFOS2D"
export IFOS3DROOT="${OPTROOT}/IFOS3D"


# export PATH="${PATH}:${CWPROOT}/bin:${SACROOT}/bin:${RSFROOT}/bin" 2>/dev/null
# export PATH="$PATH:${SOFI2DROOT}/bin:${SOFI3DROOT}/bin:${IFOS2DROOT}/bin:${IFOS3DROOT}/bin" 2>/dev/null
# export PATH="${PATH}:${LOCFLOWROOT}/bin" 2>/dev/null
add_path $RSFROOT/bin
add_path $CWPROOT/bin
add_path $SACROOT/bin
add_path $SOFI2DROOT/bin
add_path $SOFI3DROOT/bin
add_path $IFOS2DROOT/bin
add_path $IFOS3DROOT/bin
add_path $LOCFLOWROOT/bin

# export PATH="$PATH:~/dotfile/script" 2>/dev/null
add_path ~/dotfile/script


# Automatically add /opt/**/bin to PATH
# for dir in $(find /opt -type d -name bin -maxdepth 2); do
#     if [[ -d $dir ]]; then
#         add_path "$dir"
#     fi
# done
## Enable conda in command line

source /opt/miniconda/etc/profile.d/conda.sh 2>/dev/null
source /opt/conda/etc/profile.d/conda.sh 2>/dev/null
source ~/opt/miniconda3/etc/profile.d/conda.sh 2>/dev/null

source $RSFROOT/share/madagascar/etc/env.sh 2>/dev/null
source /opt/intel/oneapi/setvars.sh >/dev/null 2>&1
