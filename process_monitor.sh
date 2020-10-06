#!/bin/bash

# Mega process
if pgrep -x mega-cmd-server > /dev/null
then
	echo "Process running"
else
	echo " Process stopped"
	mega-help
	echo "Started process"
        /usr/bin/curl -X POST -s -F "title=Mega" -F "message=Mega Server Process restart" -F "priority=5" "https://notify.hibare.in/message?token=AT1GLiV2uy6Jx8n"
fi
