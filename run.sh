#!/usr/bin/env bash
set -e
set -x

[ -z "$APP_HOME" ] && export APP_HOME=$(pwd)
[ -z "$KEYCLOAK_VERSION" ] && export KEYCLOAK_VERSION="15.0.2"
[ -z "$POSTGRESQL_ADDON_DB" ] && export POSTGRESQL_ADDON_DB="keycloak"
[ -z "$POSTGRESQL_ADDON_HOST" ] && export POSTGRESQL_ADDON_HOST="127.0.0.1"
[ -z "$POSTGRESQL_ADDON_PASSWORD" ] && export POSTGRESQL_ADDON_PASSWORD="keycloak"
[ -z "$POSTGRESQL_ADDON_PORT" ] && export POSTGRESQL_ADDON_PORT="5432"
[ -z "$POSTGRESQL_ADDON_USER" ] && export POSTGRESQL_ADDON_USER="loictosser"

export KEYCLOAK_DIR=keycloak
export local=\$local
envsubst  < standalone.xml > ./$KEYCLOAK_DIR/standalone/configuration/standalone.xml
cd $KEYCLOAK_DIR/bin
./standalone.sh $1
