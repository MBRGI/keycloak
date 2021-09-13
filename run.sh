#!/usr/bin/env bash
set -e
set -x

[ -z "$APP_HOME" ] && export APP_HOME=$(pwd)
[ -z "$KEYCLOAK_VERSION" ] && export KEYCLOAK_VERSION="15.0.2"

export KEYCLOAK_DIR=keycloak
export local=\$local
envsubst  < standalone.xml > ./$KEYCLOAK_DIR/standalone/configuration/standalone.xml
cd $KEYCLOAK_DIR/bin
./standalone.sh
