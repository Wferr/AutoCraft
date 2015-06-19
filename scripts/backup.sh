#!/bin/bash
set -e

//Backup Controller Script

function full-backup {
	tar cvzf $HOME/AutoCraft/backups/full/$NOW.tar.gz $HOME/AutoCraft
}