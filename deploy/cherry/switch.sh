#!/bin/bash

CHERRY_PATH=/root/cherry
CRONFILE="/var/spool/cron/root"

if [ $# != 1 ]; then
    echo "please indicates the operation, 'start' or 'stop'"
    exit 1
fi
echo $1
if [ "$1" != "start" -a "$1" != "stop" ]; then
    echo "operation must be 'start' or 'stop'"
    exit 1
fi

add_crontab()
{
        CRONTAB_EXIST=`grep "$cd ${CHERRY_PATH};./monitor.sh&" ${CRONFILE}`
        if [ -z "${CRONTAB_EXIST}" ]; then
                echo "* * * * * cd ${CHERRY_PATH};./monitor.sh&" >> ${CRONFILE}
        else
                echo "no need add crontab"
        fi
}

action=$1
if [ "$action" == "start" ]; then
    echo "start cherry ..."

    add_crontab
elif [ "$action" == "stop" ]; then
    echo "stop cherry ..."
    echo "" > ${CRONFILE}
    sh ${CHERRY_PATH}/kill.sh
fi

exit 0