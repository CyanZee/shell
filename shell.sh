#!/bin/bash

ReleaseTime="YYYY/MM/DD-hh:mm:ss UTC"

getReleaseTime_func()
{
	ReleaseTime=`date '+%Y-%m-%d %H:%M:%S %Z'`
	echo ${ReleaseTime}
	sed -i "s/ReleaseTime =.*/ReleaseTime = \"${ReleaseTime}\"/" ./version/version.go
}

getReleaseTime_func

showProc_etime_func()
{
    ps -p $1 -o etime
}

stop_func()
{
    procs=`ps -ef | grep $1 | grep -v 'grep\run'| awk '{print $2}'`
    for pid in ${procs}
    do
        echo ${pid}
        sudo kill -9 ${pid}
    done
}

case $1 in
    "pe") echo "Showing process run time."
        showProc_etime_func $2
        ;;
    "stop") echo "Stopping process..."
        stop_func $2
        ;;
    "help") echo "Show process run time."
        echo "Try './shell.sh pe [PID]'"
        echo ""
        echo "Stop process by its part name."
        echo "Try './shell.sh stop [ProcName]' eg:./shell.sh stop goStreamerSrv"
        echo ""
        ;;
     *) echo "unknow command."
        echo "Try './shell.sh help' for more information."
        ;;
esac
