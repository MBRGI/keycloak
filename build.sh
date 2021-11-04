#!/bin/bash
set -e
set -x
[ -z "$APP_HOME" ] && export APP_HOME=$(pwd)
[ -z "$KEYCLOAK_VERSION" ] && export KEYCLOAK_VERSION="15.0.2"

#https://github.com/keycloak/keycloak/releases/download/15.0.2/keycloak-15.0.2.zip
#https://github.com/KalvadTech/keycloak/releases/download/15.0.2-arabic/keycloak-15.0.2.zip
if [ ! -f keycloak-$KEYCLOAK_VERSION.zip ]; then
    echo "Keycloak not found, Downloading Keycloak version $KEYCLOAK_VERSION"
    wget -q "https://github.com/KalvadTech/keycloak/releases/download/$KEYCLOAK_VERSION-arabic/keycloak-$KEYCLOAK_VERSION.zip"
fi

rm -rf $APP_HOME/keycloak-$KEYCLOAK_VERSION
rm -rf $APP_HOME/keycloak
unzip keycloak-$KEYCLOAK_VERSION.zip
cd config/postgres/main
rm -f postgresql-42.2.23.jar
wget -q https://jdbc.postgresql.org/download/postgresql-42.2.23.jar
cd -

mkdir -p $APP_HOME/keycloak-$KEYCLOAK_VERSION/conf/keycloak.d
mv keycloak-$KEYCLOAK_VERSION keycloak
export KEYCLOAK_DIR=keycloak
rsync -r config/* $KEYCLOAK_DIR/modules/system/layers/keycloak/com
rm -rf ./keycloak/themes/thedigitalschool
cp -rf ./theme ./keycloak/themes/thedigitalschool
