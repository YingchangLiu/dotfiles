#!/bin/bash
_conda_file = "Miniconda3-latest-$(uname)-$(uname -m).sh"
wget "https://mirrors.tuna.tsinghua.edu.cn/anaconda/miniconda/$(_conda_file)"
bash "$_conda_file"
rm "$_conda_file"
