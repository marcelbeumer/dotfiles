#!/bin/bash

dirname=`pwd`/`dirname "$0"`

rm -f ~/.vimrc && ln -s $dirname/vimrc ~/.vimrc
rm -f ~/.editorconfig && ln -s $dirname/editorconfig ~/.editorconfig
rm -f ~/.gitconfig && ln -s $dirname/gitconfig ~/.gitconfig
rm -f ~/.zshrc && ln -s $dirname/zshrc ~/.zshrc

mkdir -p ~/.config

rm -rf ~/.config/nvim && ln -s $dirname/nvim ~/.config/nvim
rm -rf ~/.config/alacritty && ln -s $dirname/alacritty ~/.config/alacritty

mkdir -p ~/.vim
mkdir -p ~/.vim/swp-vimrc-coc
mkdir -p ~/.vim/swp-vimrc-vim-lsp
rm -f ~/.vimrc && ln -s $dirname/vim/vimrc ~/.vimrc
rm -f ~/.vim/config && ln -s $dirname/vim/config ~/.vim/config
rm -f ~/.vim/coc-settings.json && ln -s $dirname/vim/coc-settings.json ~/.vim/coc-settings.json
