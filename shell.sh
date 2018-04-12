#!/bin/bash

ReleaseTime="YYYY/MM/DD-hh:mm:ss UTC"

getReleaseTime_func()
{
	ReleaseTime=`date '+%Y-%m-%d %H:%M:%S %Z'`
	echo ${ReleaseTime}
	sed -i "s/ReleaseTime =.*/ReleaseTime = \"${ReleaseTime}\"/" ./version/version.go
}

getReleaseTime_func



case $1 in
	*) echo "unknow command."
	;;
esac
