#!/bin/sh
# Install nvim with .vimrc on debian-like systems (tested on Debian 9, Ubunutu 18.04)

sudo apt install nvim

curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim
rm -f ~/.config/nvim/init.vim
ln -s ./.vimrc ~/.config/nvim/init.vim

echo "Go into 'nvim', type ':PlugInstal'"
