#!/bin/bash
#set -eo pipefail

STATUS=0
SBI_PORT_STATUS=$(netstat -tnpl | grep -o "$UDR_INTERFACE_PORT_FOR_NUDR")
#Check if entrypoint properly configured the conf file and no parameter is unset(optional)
NB_UNREPLACED_AT=`cat /openair-udr/etc/*.conf | grep -v contact@openairinterface.org | grep -c @ || true`

if [ $NB_UNREPLACED_AT -ne 0 ]; then
	STATUS=1
	echo "Healthcheck error: UNHEALTHY configuration file is not configured properly"
fi

if [[ -z $SBI_PORT_STATUS ]]; then
	STATUS=1
	echo "Healthcheck error: UNHEALTHY SBI TCP/HTTP port $UDR_INTERFACE_PORT_FOR_NUDR is not listening."
fi

exit $STATUS