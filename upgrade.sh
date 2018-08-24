#!/bin/bash

set -o errexit
set -o nounset

#installation path
PROGRAM_DIR=/usr/local/testApp

if [ ! -d ${PROGRAM_DIR} ]
then
	/bin/mkdir -p ${PROGRAM_DIR}
else
	echo "+++ If there is PROGRAM_DIR, it will do something."
fi

#close program
bash /opt/installPkg/testApp/kill.sh

/bin/cp -rp /opt/installPkg/testApp/* ${PROGRAM_DIR}
/bin/rm -rf ${PROGRAM_DIR}/bin/log/*

#the application runs on start-up.
sed -i '/testApp/d' /etc/rc.local
sed -i '$i /etc/init.d/rabbitmq-server restart \nbash /usr/local/testApp/start.sh' /etc/rc.local

#restart app
bash /usr/local/testApp/start.sh

#      tree installPkg
#
#       installPkg
#      /          \
#  upgrade.sh   testApp
#              /\   \   \
#             /  \   \   \
#            /    \   \   \ 
#     kill.sh start.sh lib bin
#                         /\    \ 
#                      log a.out ...
#
