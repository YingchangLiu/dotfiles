
## CUDA
export PATH=$PATH:/opt/cuda/bin 2>/dev/null
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/cuda/lib64:/opt/cuda/extras/CUPTI/lib64

## Enable conda in command line
source /opt/miniconda/etc/profile.d/conda.sh 2>/dev/null
source /opt/conda/etc/profile.d/conda.sh 2>/dev/null
source ~/opt/miniconda3/etc/profile.d/conda.sh 2>/dev/null

## Seisunix   madagascar   sac  and other geosoftwares
export OPTROOT='/opt'
# export OPTROOT='~/opt'
export RSFROOT="${OPTROOT}/ahay"
export CWPROOT="${OPTROOT}/cwp"
export SACROOT="${OPTROOT}/sac"
export SOFI2DROOT="${OPTROOT}/SOFI2D"
export SOFI3DROOT="${OPTROOT}/SOFI3D"
export IFOS2DROOT="${OPTROOT}/IFOS2D"
export IFOS3DROOT="${OPTROOT}/IFOS3D"

source $RSFROOT/share/madagascar/etc/env.sh 2>/dev/null

export PATH="${PATH}:${CWPROOT}/bin:${SACROOT}/bin:${RSFROOT}/bin" 2>/dev/null
export PATH="$PATH:${SOFI2DROOT}/bin:${SOFI3DROOT}/bin:${IFOS2DROOT}/bin:${IFOS3DROOT}/bin" 2>/dev/null
