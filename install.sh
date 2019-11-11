#!/bin/bash

cp ./enterworkspace.sh ~/bin/
cp ./workspaceconfig.sh ~/bin/
cp ./stopworkspace.sh ~/bin/
cp ./bashrc ~/.bashrc

rm -rf ~/.vimrc
cp ./vimrc ~/.vimrc
rm -rf ~/.vim
cp -r ./vim ~/.vim
