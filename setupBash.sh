#!/bin/sh

cat << EOS >> ~/.bashrc
alias v="/usr/local/Cellar/vim/8.1.0600/bin/vim"
alias g=git
alias l="ls -G"
alias ll="ls -la"
source ~/dotfiles/cawaii_prompt.sh
EOS

cat << EOS >> ~/.bash_profile
export LSCOLORS=gxfxcxdxbxegedabagacad >> ~/.bash_profile
export PS1='\[\e[0;32m\]\h@\u\[\e[m\]:\w\[\e[0;34m\]\n\t\[\e[m\] \$ ' >> ~/.bash_profile

if [ -f ~/.bashrc ] ; then
. ~/.bashrc
fi
EOS
