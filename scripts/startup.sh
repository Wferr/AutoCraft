#!/bin/bash
set -e

#Startup Script

echo "Cheking if TMUX session exists"
if tmux has-session -t AutoCraft &> /dev/null
    then
    echo "Session exists! Exiting!"
    exit
fi

if [  -f $HOME/AutoCraft/bungeecord/BungeeCord.jar ]; then
    echo "BungeeCord is not setup!"
    echo "Please set up before proceeding!"
    exit 1
fi

echo "Session doesnt exist! Creating!"
tmux new-session -d -s 'AutoCraft'
echo "Spliting Windows!"
tmux split-window -v

echo "Done!"

echo "Starting BungeeCord!"
tmux send -t AutoCraft:0.0 ./$HOME/AutoCraft/bungeecord/start.sh ENTER
echo "Done!"

echo "Starting HTOP!"
tmux send -t AutoCraft:0.1 htop ENTER
echo "Done!"

echo "Creating New Window!"
tmux new-window -t AutoCraft
echo "Done!"


count=1
for d in $HOME/AutoCraft/servers/
do
	count ++
	if [ $count ]
    echo "Starting $d"
done
echo "Done!"