#!/usr/bin/env bash

# A little helper script to be executed before starting glassfish.
# This script will _copy_ all Environment variables starting with
# the pre fix 'GF_ENV_' into glassfish system-properties.
# Note: That in System.properties the variables will NOT contain
#       the 'GF_ENV_' prefix.
# If system-property already exists its value will be chaged to
# fit the value in Environment at time of execution.
# - If script is called with the -c option it will first remove all
# system-properties with names matching the prefix, and then update
# with currnt Env vars.
#	by Michael Thorsager <thorsager@gmail.com>

XML=${GLASSFISH_HOME}/domains/${DOMAIN_NAME}/config/domain.xml
ATTR_PREFIX="GF_ENV_"
SCRIPT=`basename $0`

property() {
	local XML=$1
	local PROP=`echo $2 | sed -e s/${ATTR_PREFIX}//`
	local VAL=$3
	config_xpath='/domain/configs/config[@name="server-config"]'
	xmlstarlet sel -t -c "${config_xpath}/system-property[@name=\"${PROP}\"]" ${XML} > /dev/null
	if [ $? -eq 0 ]; then
		xmlstarlet ed -L -u "${config_xpath}/system-property[@name=\"${PROP}\"]/@value" --value "${VAL}" ${XML}
	else
		xmlstarlet ed -L -s ${config_xpath}  -t elem -n TMP-sp -v "" \
			-i //TMP-sp -t attr -n name -v "${PROP}" \
			-i //TMP-sp -t attr -n value -v "${VAL}" \
			-i //TMP-sp -t attr -n description -v "Set by ${SCRIPT} (${2})" \
			-r //TMP-sp -v system-property \
		 	$XML	
	fi
}

cleanup() {
	local XML=$1
	config_xpath='/domain/configs/config[@name="server-config"]'
	xmlstarlet ed -L -d "${config_xpath}/system-property[contains(@description,\"${ATTR_PREFIX}\")]" ${XML} 
}

if [ "$1" = "-c" ]; then
	echo "Cleaning up GlassFish System.properties"
	cleanup $XML
fi

echo "Updating GlassFish System.properties:"
for p in `env | grep ${ATTR_PREFIX}`; do
	echo " - ${p}"
	property $XML "${p%=*}" "${p#*=}"
done
