#!/bin/bash

dirname=`pwd`/`dirname "$0"`

rm -f ~/.editorconfig && ln -s $dirname/editorconfig ~/.editorconfig
rm -f ~/.gitconfig && ln -s $dirname/gitconfig ~/.gitconfig
rm -f ~/.zshrc && ln -s $dirname/zshrc ~/.zshrc

mkdir -p ~/.config

rm -rf ~/.config/kitty && ln -s $dirname/kitty ~/.config/kitty
rm -rf ~/.config/alacritty && ln -s $dirname/alacritty ~/.config/alacritty
rm -rf ~/.config/karabiner && ln -s $dirname/karabiner ~/.config/karabiner
