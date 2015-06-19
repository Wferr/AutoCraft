#!/bin/bash
set -e

#Backup Controller Script

function full-backup {
	echo "Preforming Full Backup!"
	tar cvzf $HOME/AutoCraft/backups/full/$NOW.tar.gz $HOME/AutoCraft
	echo "Done!"
	exit 1
}