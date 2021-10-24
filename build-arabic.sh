#!/bin/bash
set -e
set -x

[ -z "$APP_HOME" ] && export APP_HOME=$(pwd)
[ -z "$KEYCLOAK_VERSION" ] && export KEYCLOAK_VERSION="15.0.2"

rm -rf $APP_HOME/keycloak-$KEYCLOAK_VERSION-git
git clone https://github.com/KalvadTech/keycloak.git --depth 1 -b 15.0.2-arabic keycloak-$KEYCLOAK_VERSION-git
cd keycloak-$KEYCLOAK_VERSION-git
mvn -Pdistribution \
          -pl distribution/server-dist \
          -am \
          -Dmaven.test.skip \
          clean install
cp -r distribution/server-dist/target/keycloak-15.0.2 $APP_HOME/keycloak-$KEYCLOAK_VERSION
cd ..

cd config/postgres/main
rm -f postgresql-42.2.23.jar
wget -q https://jdbc.postgresql.org/download/postgresql-42.2.23.jar
cd -

mkdir -p $APP_HOME/keycloak-$KEYCLOAK_VERSION/conf/keycloak.d
mv keycloak-$KEYCLOAK_VERSION keycloak
export KEYCLOAK_DIR=keycloak
rsync -r config/* $KEYCLOAK_DIR/modules/system/layers/keycloak/com
cp -f ./theme/keycloak-bg.png ./keycloak/themes/keycloak/login/resources/img/keycloak-bg.png
