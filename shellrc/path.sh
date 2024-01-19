##  add directories to PATH.

set_path(){
    # Check if user id is 0 (root) or 1000 or higher
    [[ "$(id -u)" -eq 0 ]] || [[ "$(id -u)" -ge 1000 ]] || return

    for i in "$@";
    do
        # Check if the directory exists and is not empty
        [[ -d "$i" && -n "$i" ]] || continue

        # Convert to absolute path
        i=$(realpath "$i")

        # Check if it is not already in your $PATH.
        [[ ":$PATH:" == *":$i:"* ]] && continue

        # Then append it to $PATH and export it
        export PATH="$i:${PATH}"
    done
}


## CUDA
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64:$LD_LIBRARY_PATH
# export NVCC_PREPEND_FLAGS='-ccbin /usr/local/cuda/bin'
set_path /usr/local/cuda/bin


## My own programs
# export OPTROOT='/opt'
export OPTROOT='~/opt'

export RSFROOT="${RSFROOT:-${OPTROOT}/ahay}"
export CWPROOT="${CWPROOT:-${OPTROOT}/cwp}"
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

set_path ~/dotfile/script


# Automatically add /opt/**/bin to PATH
# for dir in $(find /opt -type d -name bin -maxdepth 2); do
#     if [[ -d $dir ]]; then
#         set_path "$dir"
#     fi
# done


## Enable conda in command line
conda_optpaths=(
    "/opt/miniconda"
    "/opt/conda"
    "~/opt/miniconda3"
)
for conda_path in "${conda_optpaths[@]}"; do
    if [ -d "$conda_path" ]; then
        source "$conda_path/etc/profile.d/conda.sh" 2>/dev/null
        break
    fi
done

source $RSFROOT/share/madagascar/etc/env.sh 2>/dev/null
# source /opt/intel/oneapi/setvars.sh >/dev/null 2>&1
