#!/bin/bash

ALL=() # Will be set
COMMON=("ackrc=.ackrc" "bash=.bash" "gitconfig=.gitconfig" "hgrc=.hgrc" "jshintrc=.jshintrc" "vimrc=.vimrc" "xvimrc=.xvimrc" "tmux.conf=.tmux.conf" "tmux.theme.conf=.tmux.theme.conf" "ctags=.ctags")
MAC_ONLY=("profile-macbook=.profile" "gitignore_global_mac=.gitignore_global")
SERVER_ONLY=("profile-server=.profile")
INVM_ONLY=("profile-invm=.profile")

# Get environment (macbook/server)
echo "Please choose which environment you are in:"
PS3="Environment: "

select option in macbook server invm
do
    case $option in
        macbook)
            ALL=("${COMMON[@]}" "${MAC_ONLY[@]}")
            break;;
        server)
            ALL=("${COMMON[@]}" "${SERVER_ONLY[@]}")
            break;;
        invm)
            ALL=("${COMMON[@]}" "${INVM_ONLY[@]}")
            break;;
     esac
done

# Get GO from user
echo ""
echo "This script will remove and link dotfiles in $HOME!"
read -p "Do you want to continue? (y/N)? "
[ "$(echo $REPLY | tr [:upper:] [:lower:])" == "y" ] || exit
echo ""

# Do all linking
for item in ${ALL[*]}
do
    source=`echo "$item" | cut -d'=' -f1`
    target=`echo "$item" | cut -d'=' -f2`
    echo "$source -> $HOME/$target"
    rm -f $HOME/$target
    ln -s `pwd`/$source $HOME/$target
done

echo ""
echo "Done"
