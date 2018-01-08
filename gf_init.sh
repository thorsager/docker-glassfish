#!/usr/bin/env bash
_term() {
	${GLASSFISH_HOME}/bin/asadmin stop-domain ${DOMAIN}
}

trap _term SIGTERM SIGINT

${GLASSFISH_HOME}/bin/gf_env.sh 

if [ -n ${DEBUG} ]; then
	ASADMIN_OPTS="${ASADMIN_OPTS} --debug"
fi

exec ${GLASSFISH_HOME}/bin/asadmin start-domain --verbose ${ASADMIN_OPTS} ${DOMAIN_NAME}
