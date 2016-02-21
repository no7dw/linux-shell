#!/bin/bash

function detect(){
    PORT=$1
    MAX=700
    SLEEP_SEC=20
    MEM=`pm2 list | grep $PORT |awk {' print $16'}`
    PM2ID=`pm2 list | grep $PORT |awk {' print $4'}`
    echo 'detecting process using port' $PORT ' PM2ID: ' $PM2ID

    echo  $PORT ' memory usage ': $MEM
    #use program bc to cal, expr not my style
    minus=`echo "$MAX - $MEM" | bc`
    #format to int
    minus=`echo $minus/1 | bc`
    #echo $minus
    if [ $minus -lt 0 ]; then
        echo $PORT ' use too many memory, over ' $MAX ' MB'
        echo '###################'
        echo 'now try to stop receive req from haproxy'
        curl localhost:$PORT/healthcheck/resetStatus?status=false       
        echo '\n###################'
        echo '###################'
        echo 'now try to restart node after ' $SLEEP_SEC ' sec'
        echo '###################'
        sleep $SLEEP_SEC
        pm2 restart $PM2ID          
    fi
}
function usage(){
    echo './watch-node-mem PROCESS_USING_SOME_YOUR_PORT'
    echo 'Example:'
    echo './watch-node-mem 9013'
}
if [ $# -lt 1 ];then
    usage
    exit 1
fi
detect $1

