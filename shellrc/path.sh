##  add directories to PATH.


## My own programs
# export OPTROOT='/opt'
export OPTROOT=$HOME/opt


## Load madagascar environment
[ -z "$_LOADED_RSF_ENV" ] && source $RSFROOT/share/madagascar/etc/env.sh 2>/dev/null && export _LOADED_RSF_ENV=1


export MAMBA_ROOT_PREFIX="${MAMBA_ROOT_PREFIX:-${OPTROOT}/miniforge3}"

## Enable conda in command line
set_conda_env() {
    local __conda_optpaths=(
        "$HOME/opt/miniforge"
        "$HOME/opt/miniforge3"
        "$OPTROOT/miniforge"
        "$OPTROOT/miniforge3"
        "/opt/miniforge"
        "$HOME/opt/miniconda3"
        "$OPTROOT/miniconda"
        "$OPTROOT/miniconda3"
        "/opt/miniconda"
        "/opt/conda"
    )
    local conda_path
    for conda_path in "${__conda_optpaths[@]}"; do
        if [ -d "$conda_path" ]; then
            # [ -z "$_LOADED_CONDA_ENV" ] && source "$conda_path/etc/profile.d/conda.sh" 2>/dev/null && export _LOADED_CONDA_ENV=1
            #source "$conda_path/etc/profile.d/mamba.sh" 2>/dev/null
            source "$conda_path/etc/profile.d/conda.sh" 2>/dev/null ## Conda needs to be loaded in every shell
            return 0  # 成功加载后退出函数
        fi
    done
    return 1  # 如果没有找到任何 Conda 环境，则返回非零值
}
set_conda_env


# source /opt/intel/oneapi/setvars.sh >/dev/null 2>&1


## CUDA
set_ld_library_path /usr/local/cuda/lib64 /usr/local/cuda/extras/CUPTI/lib64
# export NVCC_PREPEND_FLAGS='-ccbin /usr/local/cuda/bin'
set_path /usr/local/cuda/bin



export RSFROOT="${RSFROOT:-${OPTROOT}/ahay}"
export CWPROOT="${CWPROOT:-${OPTROOT}/seisunix}"
export SACROOT="${SACROOT:-${OPTROOT}/sac}"
export LOCFLOWROOT="${LOCFLOWROOT:-${OPTROOT}/locflow}"
export SOFI2DROOT="${SOFI2DROOT:-${OPTROOT}/SOFI2D}"
export SOFI3DROOT="${SOFI3DROOT:-${OPTROOT}/SOFI3D}"
export IFOS2DROOT="${IFOS2DROOT:-${OPTROOT}/IFOS2D}"
export IFOS3DROOT="${IFOS3DROOT:-${OPTROOT}/IFOS3D}"

## set_path of rsf is not needed, because it is already set in env.sh
# set_path $RSFROOT/bin

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
