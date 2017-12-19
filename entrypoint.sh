#!/bin/bash

set -e

if [ -z "${CROWD_URL}" ]; then
  echo "Please set CROWD_URL"
fi
if [ -z "${CROWD_APPLICATION}" ]; then
  echo "Please set CROWD_APPLICATION"
fi
if [ -z "${CROWD_PASSWORD}" ]; then
  echo "Please set CROWD_PASWORD"
fi

echo "creating crowd.properties"
echo "crowd.server.url=${CROWD_URL}" >> $NEXUS_HOME/etc/crowd.properties
echo "application.name=${CROWD_APPLICATION}" >> $NEXUS_HOME/etc/crowd.properties
echo "application.password=${CROWD_PASSWORD}" >> $NEXUS_HOME/etc/crowd.properties

echo "copy /nexus3-crowd-plugin/nexus3-crowd-plugin.jar to ${NEXUS_HOME}/system"
cp /nexus3-crowd-plugin/nexus3-crowd-plugin.jar ${NEXUS_HOME}/system/

echo "adding nexus3-crowd-plugin.jar to $NEXUS_HOME/etc/karaf/startup.properties"
echo "reference\:file\:nexus3-crowd-plugin.jar = 200" >> $NEXUS_HOME/etc/karaf/startup.properties


su nexus -s /bin/bash -c ${SONATYPE_DIR}/start-nexus-repository-manager.sh $@
