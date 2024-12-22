#!/bin/bash
forge_file="Miniforge3-$(uname)-$(uname -m).sh"
wget "https://mirrors.tuna.tsinghua.edu.cn/github-release/conda-forge/miniforge/LatestRelease/$forge_file"
bash "$forge_file"
rm "$forge_file"
