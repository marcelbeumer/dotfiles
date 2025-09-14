#!/bin/bash

dirname=`pwd`/`dirname "$0"`

rm -f ~/.bashrc && ln -s $dirname/bashrc ~/.bashrc
rm -f ~/.bash_k8s && ln -s $dirname/bash_k8s ~/.bash_k8s
rm -f ~/.bash_profile && ln -s $dirname/bash_profile ~/.bash_profile
rm -f ~/.tmux.conf && ln -s $dirname/tmux.conf ~/.tmux.conf
rm -f ~/.stylua && ln -s $dirname/stylua ~/.stylua
rm -f ~/.editorconfig && ln -s $dirname/editorconfig ~/.editorconfig
rm -f ~/.gitconfig && ln -s $dirname/gitconfig ~/.gitconfig
rm -f ~/.gitignore && ln -s $dirname/gitignore ~/.gitignore

mkdir -p ~/.gnupg
rm -f ~/.gnupg/gpg.conf && ln -s $dirname/gpg.conf ~/.gnupg/gpg.conf

mkdir -p ~/.config

rm -rf ~/.config/neovide && ln -s $dirname/neovide ~/.config/neovide
rm -rf ~/.config/hypr && ln -s $dirname/hypr ~/.config/hypr
rm -rf ~/.config/waybar && ln -s $dirname/waybar ~/.config/waybar

mkdir -p ~/bin

rm -f ~/bin/vpn-status && ln -s $dirname/bin/vpn-status ~/bin/vpn-status && chmod +x ~/bin/vpn-status
