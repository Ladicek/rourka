#!/bin/bash

SHARED_SECRET=""

if [[ $1 ]] ; then
  SHARED_SECRET="CI_GITHUB_SECRET=$1"
fi

# CI boosters

oc process ci-basic-template CI_NAME=ci-wfswarm-rest-http         CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"     CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http $SHARED_SECRET | oc apply -f -
oc process ci-basic-template CI_NAME=ci-wfswarm-rest-http-crud    CI_DESCRIPTION="WildFly Swarm | 101: CRUD"         CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud $SHARED_SECRET | oc apply -f -
oc process ci-basic-template CI_NAME=ci-wfswarm-configmap         CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"    CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-configmap $SHARED_SECRET | oc apply -f -
oc process ci-sso-template   CI_NAME=ci-wfswarm-rest-http-secured CI_DESCRIPTION="WildFly Swarm | 103: SSO"          CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured $SHARED_SECRET | oc apply -f -
oc process ci-basic-template CI_NAME=ci-wfswarm-health-check      CI_DESCRIPTION="WildFly Swarm | 104: Health Check" CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-health-check $SHARED_SECRET | oc apply -f -

oc process ci-basic-template CI_NAME=ci-vertx-http-booster          CI_DESCRIPTION="Vert.x | 100: HTTP API"     CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-http-booster $SHARED_SECRET | oc apply -f -
oc process ci-basic-template CI_NAME=ci-vertx-crud-booster          CI_DESCRIPTION="Vert.x | 101: CRUD"         CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-crud-booster $SHARED_SECRET | oc apply -f -
oc process ci-basic-template CI_NAME=ci-vertx-configmap-booster     CI_DESCRIPTION="Vert.x | 102: ConfigMap"    CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-configmap-booster $SHARED_SECRET | oc apply -f -
oc process ci-sso-template   CI_NAME=ci-vertx-secured-http-booster  CI_DESCRIPTION="Vert.x | 103: SSO"          CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-secured-http-booster $SHARED_SECRET | oc apply -f -
oc process ci-basic-template CI_NAME=ci-vertx-health-checks-booster CI_DESCRIPTION="Vert.x | 104: Health Check" CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-health-checks-booster $SHARED_SECRET | oc apply -f -

oc process ci-basic-template CI_NAME=ci-spring-boot-http-booster         CI_DESCRIPTION="Spring Boot | 100: HTTP API"     CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-booster $SHARED_SECRET | oc apply -f -
oc process ci-basic-template CI_NAME=ci-spring-boot-crud-booster         CI_DESCRIPTION="Spring Boot | 101: CRUD"         CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-crud-booster $SHARED_SECRET | oc apply -f -
oc process ci-basic-template CI_NAME=ci-spring-boot-configmap-booster    CI_DESCRIPTION="Spring Boot | 102: ConfigMap"    CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-configmap-booster $SHARED_SECRET | oc apply -f -
oc process ci-sso-template   CI_NAME=ci-spring-boot-http-secured-booster CI_DESCRIPTION="Spring Boot | 103: SSO"          CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-secured-booster $SHARED_SECRET | oc apply -f -
oc process ci-basic-template CI_NAME=ci-spring-boot-health-check-booster CI_DESCRIPTION="Spring Boot | 104: Health Check" CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-health-check-booster $SHARED_SECRET | oc apply -f -

# Losiot

oc process losiot-template CI_NAME=losiot-stage-zip-wfswarm-rest-http    CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"     CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M100_HTTP_API     LOSIOT_RUNTIME=WILDFLY_SWARM | oc apply -f -
oc process losiot-template CI_NAME=losiot-stage-zip-wfswarm-health-check CI_DESCRIPTION="WildFly Swarm | 104: Health Check" CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M104_HEALTH_CHECK LOSIOT_RUNTIME=WILDFLY_SWARM | oc apply -f -

oc process losiot-template CI_NAME=losiot-stage-zip-vertx-http-booster          CI_DESCRIPTION="Vert.x | 100: HTTP API"     CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M100_HTTP_API     LOSIOT_RUNTIME=VERTX | oc apply -f -
oc process losiot-template CI_NAME=losiot-stage-zip-vertx-health-checks-booster CI_DESCRIPTION="Vert.x | 104: Health Check" CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M104_HEALTH_CHECK LOSIOT_RUNTIME=VERTX | oc apply -f -

oc process losiot-template CI_NAME=losiot-stage-zip-spring-boot-http-booster         CI_DESCRIPTION="Spring Boot | 100: HTTP API"     CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M100_HTTP_API     LOSIOT_RUNTIME=SPRING_BOOT | oc apply -f -
oc process losiot-template CI_NAME=losiot-stage-zip-spring-boot-health-check-booster CI_DESCRIPTION="Spring Boot | 104: Health Check" CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M104_HEALTH_CHECK LOSIOT_RUNTIME=SPRING_BOOT | oc apply -f -
