#!/bin/bash
#used to do a quick reinstall of AutoCraft
set -e

rm -r -rf $HOME/AutoCraft/

cd $HOME
git clone http://github.com/Wferr/AutoCraft/
sh $HOME/AutoCraft/scripts/inital-setup-light.sh