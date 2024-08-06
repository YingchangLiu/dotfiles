##  add directories to PATH.


## CUDA
set_ld_library_path /usr/local/cuda/lib64 /usr/local/cuda/extras/CUPTI/lib64
# export NVCC_PREPEND_FLAGS='-ccbin /usr/local/cuda/bin'
set_path /usr/local/cuda/bin


## My own programs
# export OPTROOT='/opt'
export OPTROOT=$HOME/opt

export RSFROOT="${RSFROOT:-${OPTROOT}/ahay}"
export CWPROOT="${CWPROOT:-${OPTROOT}/seisunix}"
export SACROOT="${SACROOT:-${OPTROOT}/sac}"
export LOCFLOWROOT="${LOCFLOWROOT:-${OPTROOT}/locflow}"
export SOFI2DROOT="${SOFI2DROOT:-${OPTROOT}/SOFI2D}"
export SOFI3DROOT="${SOFI3DROOT:-${OPTROOT}/SOFI3D}"
export IFOS2DROOT="${IFOS2DROOT:-${OPTROOT}/IFOS2D}"
export IFOS3DROOT="${IFOS3DROOT:-${OPTROOT}/IFOS3D}"


set_path $RSFROOT/bin
set_path $CWPROOT/bin
set_path $SACROOT/bin
set_path $SOFI2DROOT/bin $SOFI3DROOT/bin
set_path $IFOS2DROOT/bin $IFOS3DROOT/bin
set_path $LOCFLOWROOT/bin

set_path $HOME/.local/bin


# Automatically add /opt/**/bin to PATH
# for dir in $(find /opt -type d -name bin -maxdepth 2); do
#     if [[ -d $dir ]]; then
#         set_path "$dir"
#     fi
# done


## Enable conda in command line
__conda_optpaths=(
    "/opt/miniconda"
    "/opt/conda"
    "$HOME/opt/miniconda3"
)
for conda_path in "${__conda_optpaths[@]}"; do
    if [ -d "$conda_path" ]; then
        source "$conda_path/etc/profile.d/conda.sh" 2>/dev/null
        break
    fi
done

source $RSFROOT/share/madagascar/etc/env.sh 2>/dev/null
# source /opt/intel/oneapi/setvars.sh >/dev/null 2>&1
