#!/bin/bash

dirname=`pwd`/`dirname "$0"`

rm -f ~/.bashrc && ln -s $dirname/bashrc ~/.bashrc
rm -f ~/.bash_profile && ln -s $dirname/bash_profile ~/.bash_profile
rm -f ~/.stylua && ln -s $dirname/stylua ~/.stylua
rm -f ~/.editorconfig && ln -s $dirname/editorconfig ~/.editorconfig
rm -f ~/.gitconfig && ln -s $dirname/gitconfig ~/.gitconfig
rm -f ~/.gitignore && ln -s $dirname/gitignore ~/.gitignore
