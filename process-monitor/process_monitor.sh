#!/bin/bash

# Mega process
if pgrep -x mega-cmd-server > /dev/null
then
	echo "Process running"
else
	echo " Process stopped"
	mega-help
	echo "Started process"
fi
