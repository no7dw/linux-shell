#!/bin/bash
function getSomeSleep(){
        SLEEP_SEC=$1
        SLEEP_MAX_SEC=30
        #minus=`echo $SLEEP_SEC/1 | bc`
        if [ $SLEEP_SEC -gt 0 ] && [ $SLEEP_SEC -lt 30 ]; then
            echo '###################'
            echo 'now try to restart node after ' $SLEEP_SEC ' sec'
            echo '###################'
            sleep $SLEEP_SEC
        else
            echo 'sec must between 0 and ' $SLEEP_MAX_SEC ' sec'
        fi  
}
usage(){
	echo "usage: sleep seconds"
}

if [ $# == 1 ]; then
	getSomeSleep $1
else
	usage
	exit 1
fi
