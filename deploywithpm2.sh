#!/bin/bash

force=$1
function runNodeActivity(){
    echo 'runNode with pm2'
    cd /var/git/finance/fin_koala_activity
    pm2 start bin/processes_beta.json
}
function runNode(){
    echo 'runNode with pm2'
    cd /var/git/finance/fin_sails_koala
    pm2 start bin/processes_beta.json
}
function tips(){
    echo 'perhaps you can now run:'
    echo 'cd /var/git/finance/fin_sails_koala'
    echo 'pm2 start bin/processes_beta.json'
    if [ $force == "-f" ];
    then 
        runNode
        runNodeActivity
    fi
}
function help(){
    echo ""
    echo "Examples: to run pm2 in fin_sails_koala"
    echo "$0 -f "
    echo "Examples: to kill pm2 in gentoo"
    echo "$0"
    exit
}

if [[ $1 == "-h" ]]
then
    help
fi

pm2count=`ps -ef| grep PM2 |wc -l`
if [ $pm2count -lt 2 ];
then
    echo 'there are less than 2 pm2 daemon, you can use it'
    tips
    exit 0
fi
runingpm2pid=`ps -ef| grep sails | grep -v 'grep' |awk {'print $3'}`
if [ runingpm2pid ];
then
    kill $runingpm2pid
fi
echo 'kill runing pm2 pid done' $runingpid

bgpm2pid=`ps -ef| grep PM2 | grep -v 'grep' |awk {'print $2'}`
if [ bgpm2pid ] ;
then
    kill $bgpm2pid
fi
echo 'kill backgound runing pm2 pid done' $runingpid
tips
