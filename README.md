# linux shell script program intro #

# we base on linux cmd  #

    #!/bin/bash
    ls abc
    mkdir abc
    cd abc


# function #

    #!/bin/bash
    force=$1
    function runNodeActivity(){
        echo 'runNode with pm2' $1
        cd /var/git/finance/fin_koala_activity
        pm2 start bin/processes_beta.json
    }

# parameter  #

> $# 是传给脚本的参数个数 $0 是脚本本身的名字 $1是传递给该shell脚本的第一个参数 $2是传递给该shell脚本的第二个参数 $@
> 是传给脚本的所有参数的列表

## parameter in function ##

    function tips(){
        echo 'perhaps you can now run:'
        echo 'cd /var/git/finance/fin_sails_koala'
        echo 'pm2 start bin/processes_beta.json'
        if [ $force == "-f" ];
        then 
            runSails
            
        fi
    }


## better to have help function ##

    function help(){
    echo ""
        echo "Examples: to run pm2 in fin_sails_koala"
        echo "$0 -f "
        echo "Examples: to kill pm2 in gentoo"
        echo "$0"
        exit
    }

## if then else ##

    pm2count=`ps -ef| grep PM2 |wc -l`
    if [ $pm2count -lt 2 ];
    then
        echo 'there are less than 2 pm2 daemon, you can use it'
        tips
        exit 0
    fi

## debug ##

    [debug in shell][1]


  [1]: http://www.cnblogs.com/no7dw/p/3923657.html
