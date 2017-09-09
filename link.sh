#!/bin/bash
ln -s "$(pwd)/.vimrc" "../.vimrc"
ln -s "$(pwd)/.zshrc" "../.zshrc"
ln -s "$(pwd)/.bashrc" "../.bashrc"
ln -s "$(pwd)/.gitconfig" "../.gitconfig"
if [[ $(uname) == Darwin ]]; then
    ln -s "$(pwd)/osx.gitconfig" "../.gitconfig.local"
else
    ln -s "$(pwd)/linux.gitconfig" "../.gitconfig.local"
fi
