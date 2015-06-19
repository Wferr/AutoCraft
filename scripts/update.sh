#!/bin/bash
set -e

//Used to call Update Loop

function update-jars {
sh $HOME/AutoCraft/scripts/bungee-update.sh
sh $HOME/AutoCraft/scripts/spigot-update.sh
}