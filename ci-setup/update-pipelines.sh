#!/bin/bash

ADDITIONAL_OPTIONS=""

if [[ ! -z $CI_GITHUB_SECRET ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS CI_GITHUB_SECRET=$CI_GITHUB_SECRET"
fi

if [[ ! -z $MAVEN_MIRROR ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS MAVEN_MIRROR=$MAVEN_MIRROR"
fi

# CI boosters

oc process ci-basic-template CI_NAME=ci-wfswarm-rest-http         CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"        CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-wfswarm-rest-http-crud    CI_DESCRIPTION="WildFly Swarm | 101: CRUD"            CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-wfswarm-configmap         CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"       CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-configmap $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-sso-template   CI_NAME=ci-wfswarm-rest-http-secured CI_DESCRIPTION="WildFly Swarm | 103: SSO"             CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-wfswarm-health-check      CI_DESCRIPTION="WildFly Swarm | 104: Health Check"    CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-health-check $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-wfswarm-circuit-breaker   CI_DESCRIPTION="WildFly Swarm | 106: Circuit Breaker" CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-circuit-breaker $ADDITIONAL_OPTIONS | oc apply -f -

oc process ci-basic-template CI_NAME=ci-vertx-http-booster            CI_DESCRIPTION="Vert.x | 100: HTTP API"        CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-http-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-vertx-crud-booster            CI_DESCRIPTION="Vert.x | 101: CRUD"            CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-crud-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-vertx-configmap-booster       CI_DESCRIPTION="Vert.x | 102: ConfigMap"       CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-configmap-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-sso-template   CI_NAME=ci-vertx-secured-http-booster    CI_DESCRIPTION="Vert.x | 103: SSO"             CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-secured-http-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-vertx-health-checks-booster   CI_DESCRIPTION="Vert.x | 104: Health Check"    CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-health-checks-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-vertx-circuit-breaker-booster CI_DESCRIPTION="Vert.x | 106: Circuit Breaker" CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-circuit-breaker-booster $ADDITIONAL_OPTIONS | oc apply -f -

oc process ci-basic-template CI_NAME=ci-spring-boot-http-booster           CI_DESCRIPTION="Spring Boot | 100: HTTP API"        CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-spring-boot-crud-booster           CI_DESCRIPTION="Spring Boot | 101: CRUD"            CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-crud-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-spring-boot-configmap-booster      CI_DESCRIPTION="Spring Boot | 102: ConfigMap"       CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-configmap-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-sso-template   CI_NAME=ci-spring-boot-http-secured-booster   CI_DESCRIPTION="Spring Boot | 103: SSO"             CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-secured-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-spring-boot-health-check-booster   CI_DESCRIPTION="Spring Boot | 104: Health Check"    CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-health-check-booster $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-basic-template CI_NAME=ci-springboot-circuit-breaker-booster CI_DESCRIPTION="Spring Boot | 106: Circuit Breaker" CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-circuit-breaker-booster $ADDITIONAL_OPTIONS | oc apply -f -

exit
# TODO Losiot needs a lot of changes

# Losiot: STAGE

oc process losiot-template CI_NAME=losiot-stage-zip-wfswarm-rest-http    CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"     CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M100_HTTP_API     LOSIOT_RUNTIME=WILDFLY_SWARM | oc apply -f -
oc process losiot-template CI_NAME=losiot-stage-zip-wfswarm-configmap    CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"    CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M102_CONFIGMAP    LOSIOT_RUNTIME=WILDFLY_SWARM | oc apply -f -
oc process losiot-template CI_NAME=losiot-stage-zip-wfswarm-health-check CI_DESCRIPTION="WildFly Swarm | 104: Health Check" CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M104_HEALTH_CHECK LOSIOT_RUNTIME=WILDFLY_SWARM | oc apply -f -

oc process losiot-template CI_NAME=losiot-stage-zip-vertx-http-booster          CI_DESCRIPTION="Vert.x | 100: HTTP API"     CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M100_HTTP_API     LOSIOT_RUNTIME=VERTX | oc apply -f -
oc process losiot-template CI_NAME=losiot-stage-zip-vertx-configmap-booster     CI_DESCRIPTION="Vert.x | 102: ConfigMap"    CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M102_CONFIGMAP    LOSIOT_RUNTIME=VERTX | oc apply -f -
oc process losiot-template CI_NAME=losiot-stage-zip-vertx-health-checks-booster CI_DESCRIPTION="Vert.x | 104: Health Check" CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M104_HEALTH_CHECK LOSIOT_RUNTIME=VERTX | oc apply -f -

oc process losiot-template CI_NAME=losiot-stage-zip-spring-boot-http-booster         CI_DESCRIPTION="Spring Boot | 100: HTTP API"     CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M100_HTTP_API     LOSIOT_RUNTIME=SPRING_BOOT | oc apply -f -
oc process losiot-template CI_NAME=losiot-stage-zip-spring-boot-configmap-booster    CI_DESCRIPTION="Spring Boot | 102: ConfigMap"    CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M102_CONFIGMAP    LOSIOT_RUNTIME=SPRING_BOOT | oc apply -f -
oc process losiot-template CI_NAME=losiot-stage-zip-spring-boot-health-check-booster CI_DESCRIPTION="Spring Boot | 104: Health Check" CI_TYPE="launch-stage.openshift.io .zip" LOSIOT_TARGET=STAGE LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M104_HEALTH_CHECK LOSIOT_RUNTIME=SPRING_BOOT | oc apply -f -

# Losiot: PROD

oc process losiot-template CI_NAME=losiot-prod-zip-wfswarm-rest-http    CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"     CI_TYPE="launch.openshift.io .zip" LOSIOT_TARGET=PROD LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M100_HTTP_API     LOSIOT_RUNTIME=WILDFLY_SWARM | oc apply -f -
oc process losiot-template CI_NAME=losiot-prod-zip-wfswarm-configmap    CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"    CI_TYPE="launch.openshift.io .zip" LOSIOT_TARGET=PROD LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M102_CONFIGMAP    LOSIOT_RUNTIME=WILDFLY_SWARM | oc apply -f -
oc process losiot-template CI_NAME=losiot-prod-zip-wfswarm-health-check CI_DESCRIPTION="WildFly Swarm | 104: Health Check" CI_TYPE="launch.openshift.io .zip" LOSIOT_TARGET=PROD LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M104_HEALTH_CHECK LOSIOT_RUNTIME=WILDFLY_SWARM | oc apply -f -

oc process losiot-template CI_NAME=losiot-prod-zip-vertx-http-booster          CI_DESCRIPTION="Vert.x | 100: HTTP API"     CI_TYPE="launch.openshift.io .zip" LOSIOT_TARGET=PROD LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M100_HTTP_API     LOSIOT_RUNTIME=VERTX | oc apply -f -
oc process losiot-template CI_NAME=losiot-prod-zip-vertx-configmap-booster     CI_DESCRIPTION="Vert.x | 102: ConfigMap"    CI_TYPE="launch.openshift.io .zip" LOSIOT_TARGET=PROD LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M102_CONFIGMAP    LOSIOT_RUNTIME=VERTX | oc apply -f -
oc process losiot-template CI_NAME=losiot-prod-zip-vertx-health-checks-booster CI_DESCRIPTION="Vert.x | 104: Health Check" CI_TYPE="launch.openshift.io .zip" LOSIOT_TARGET=PROD LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M104_HEALTH_CHECK LOSIOT_RUNTIME=VERTX | oc apply -f -

oc process losiot-template CI_NAME=losiot-prod-zip-spring-boot-http-booster         CI_DESCRIPTION="Spring Boot | 100: HTTP API"     CI_TYPE="launch.openshift.io .zip" LOSIOT_TARGET=PROD LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M100_HTTP_API     LOSIOT_RUNTIME=SPRING_BOOT | oc apply -f -
oc process losiot-template CI_NAME=losiot-prod-zip-spring-boot-configmap-booster    CI_DESCRIPTION="Spring Boot | 102: ConfigMap"    CI_TYPE="launch.openshift.io .zip" LOSIOT_TARGET=PROD LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M102_CONFIGMAP    LOSIOT_RUNTIME=SPRING_BOOT | oc apply -f -
oc process losiot-template CI_NAME=losiot-prod-zip-spring-boot-health-check-booster CI_DESCRIPTION="Spring Boot | 104: Health Check" CI_TYPE="launch.openshift.io .zip" LOSIOT_TARGET=PROD LOSIOT_DEPLOYMENT_TYPE=ZIP LOSIOT_MISSION=M104_HEALTH_CHECK LOSIOT_RUNTIME=SPRING_BOOT | oc apply -f -

