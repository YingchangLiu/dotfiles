#!/bin/bash

# [submodule "extra/zshplugins/powerlevel10k"]
# 	path = extra/zshplugins/powerlevel10k
# 	url = https://github.com/romkatv/powerlevel10k
# [submodule "extra/zshplugins/zsh-history-substring-search"]
# 	path = extra/zshplugins/zsh-history-substring-search
# 	url = https://github.com/zsh-users/zsh-history-substring-search
# [submodule "extra/zshplugins/zsh-autocomplete"]
# 	path = extra/zshplugins/zsh-autocomplete
# 	url = https://github.com/marlonrichert/zsh-autocomplete
# [submodule "extra/zshplugins/zsh-syntax-highlighting"]
# 	path = extra/zshplugins/zsh-syntax-highlighting
# 	url = https://github.com/zsh-users/zsh-syntax-highlighting
# [submodule "extra/zshplugins/zsh-autosuggestions"]
# 	path = extra/zshplugins/zsh-autosuggestions
# 	url = https://github.com/zsh-users/zsh-autosuggestions

# Clone all submodules
# git submodule update --init --recursive


# Get current script directory
_dir=$(dirname "$(realpath "$0")")

# Clone all submodules
git clone https://github.com/romkatv/powerlevel10k --depth=1 $_dir/powerlevel10k 2>/dev/null
git clone https://github.com/zsh-users/zsh-history-substring-search --depth=1 $_dir/zsh-history-substring-search 2>/dev/null
git clone https://github.com/marlonrichert/zsh-autocomplete --depth=1 $_dir/zsh-autocomplete 2>/dev/null
git clone https://github.com/zsh-users/zsh-syntax-highlighting --depth=1 $_dir/zsh-syntax-highlighting 2>/dev/null
git clone https://github.com/zsh-users/zsh-autosuggestions --depth=1 $_dir/zsh-autosuggestions 2>/dev/null

