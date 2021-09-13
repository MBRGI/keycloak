#!/bin/bash
set -e

[ -z "$APP_HOME" ] && export APP_HOME=$(pwd)
[ -z "$KEYCLOAK_VERSION" ] && export KEYCLOAK_VERSION="15.0.2"

#https://github.com/keycloak/keycloak/releases/download/15.0.2/keycloak-15.0.2.zip
if [ ! -f keycloak-$KEYCLOAK_VERSION.zip ]; then
    echo "Keycloak not found, Downloading Keycloak version $KEYCLOAK_VERSION"
    wget "https://github.com/keycloak/keycloak/releases/download/$KEYCLOAK_VERSION/keycloak-$KEYCLOAK_VERSION.zip"
fi

rm -rf $APP_HOME/keycloak-$KEYCLOAK_VERSION
unzip keycloak-$KEYCLOAK_VERSION.zip
cd config/postgres/main
rm -f postgresql-42.2.23.jar
wget https://jdbc.postgresql.org/download/postgresql-42.2.23.jar
cd -

mkdir -p $APP_HOME/keycloak-$KEYCLOAK_VERSION/conf/keycloak.d

export KEYCLOAK_DIR=keycloak-$KEYCLOAK_VERSION
rsync -r config/* $KEYCLOAK_DIR/modules/system/layers/keycloak/com
