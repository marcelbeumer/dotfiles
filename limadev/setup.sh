#!/bin/bash

dirname=$(pwd)/$(dirname "$0")

rm -f ~/.bashrc && ln -s $dirname/bashrc ~/.bashrc
rm -f ~/.bash_k8s && ln -s $dirname/bash_k8s ~/.bash_k8s
rm -f ~/.bash_aws && ln -s $dirname/bash_aws ~/.bash_aws
rm -f ~/.bash_profile && ln -s $dirname/bash_profile ~/.bash_profile
rm -f ~/.tmux.conf && ln -s $dirname/tmux.conf ~/.tmux.conf
rm -f ~/.stylua && ln -s $dirname/stylua ~/.stylua
rm -f ~/.editorconfig && ln -s $dirname/editorconfig ~/.editorconfig
rm -f ~/.gitconfig && ln -s $dirname/gitconfig ~/.gitconfig
rm -f ~/.gitignore && ln -s $dirname/gitignore ~/.gitignore

mkdir -p ~/.gnupg
rm -f ~/.gnupg/gpg.conf && ln -s $dirname/gpg.conf ~/.gnupg/gpg.conf

rm -rf ~/.pi && ln -s $dirname/pi ~/.pi

for f in $dirname/bin/*; do
  fname=$(basename $f)
  ln -sf $f ~/bin/$fname
done
