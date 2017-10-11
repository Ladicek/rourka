#!/bin/bash

# CI boosters

ADDITIONAL_OPTIONS=""

if [[ ! -z $CI_GITHUB_SECRET ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS CI_GITHUB_SECRET=$CI_GITHUB_SECRET"
fi

if [[ ! -z $MAVEN_REPO_ADD ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS MAVEN_REPO_ADD=$MAVEN_REPO_ADD"
fi

if [[ -z $WFSWARM_CI_GIT_REF ]] ; then
  echo 'Skipping WildFly Swarm boosters, $WFSWARM_CI_GIT_REF missing'
else
  oc process ci-basic-template CI_NAME=ci-wfswarm-rest-http         CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"        CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http         CI_GIT_REF=$WFSWARM_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-wfswarm-rest-http-crud    CI_DESCRIPTION="WildFly Swarm | 101: CRUD"            CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud    CI_GIT_REF=$WFSWARM_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-wfswarm-configmap         CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"       CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-configmap         CI_GIT_REF=$WFSWARM_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  #oc process ci-sso-template   CI_NAME=ci-wfswarm-rest-http-secured CI_DESCRIPTION="WildFly Swarm | 103: SSO"             CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured CI_GIT_REF=$WFSWARM_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-wfswarm-health-check      CI_DESCRIPTION="WildFly Swarm | 104: Health Check"    CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-health-check      CI_GIT_REF=$WFSWARM_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-wfswarm-circuit-breaker   CI_DESCRIPTION="WildFly Swarm | 106: Circuit Breaker" CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-circuit-breaker   CI_GIT_REF=$WFSWARM_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
fi

if [[ -z $VERTX_CI_GIT_REF ]] ; then
  echo 'Skipping Vert.x boosters, $VERTX_CI_GIT_REF missing'
else
  oc process ci-basic-template CI_NAME=ci-vertx-http-booster            CI_DESCRIPTION="Vert.x | 100: HTTP API"        CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-http-booster-redhat            CI_GIT_REF=$VERTX_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-vertx-crud-booster            CI_DESCRIPTION="Vert.x | 101: CRUD"            CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-crud-booster-redhat            CI_GIT_REF=$VERTX_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-vertx-configmap-booster       CI_DESCRIPTION="Vert.x | 102: ConfigMap"       CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-configmap-booster-redhat       CI_GIT_REF=$VERTX_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  #oc process ci-sso-template   CI_NAME=ci-vertx-secured-http-booster    CI_DESCRIPTION="Vert.x | 103: SSO"             CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-secured-http-booster-redhat    CI_GIT_REF=$VERTX_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-vertx-health-checks-booster   CI_DESCRIPTION="Vert.x | 104: Health Check"    CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-health-checks-booster-redhat   CI_GIT_REF=$VERTX_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-vertx-circuit-breaker-booster CI_DESCRIPTION="Vert.x | 106: Circuit Breaker" CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-circuit-breaker-booster-redhat CI_GIT_REF=$VERTX_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
fi

if [[ -z $SPRING_BOOT_CI_GIT_REF ]] ; then
  echo 'Skipping Spring Boot boosters, $SPRING_BOOT_CI_GIT_REF missing'
else
  oc process ci-basic-template CI_NAME=ci-spring-boot-http-booster            CI_DESCRIPTION="Spring Boot | 100: HTTP API"        CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-booster            CI_GIT_REF=$SPRING_BOOT_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-spring-boot-crud-booster            CI_DESCRIPTION="Spring Boot | 101: CRUD"            CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-crud-booster            CI_GIT_REF=$SPRING_BOOT_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-spring-boot-configmap-booster       CI_DESCRIPTION="Spring Boot | 102: ConfigMap"       CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-configmap-booster       CI_GIT_REF=$SPRING_BOOT_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  #oc process ci-sso-template   CI_NAME=ci-spring-boot-http-secured-booster    CI_DESCRIPTION="Spring Boot | 103: SSO"             CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-secured-booster    CI_GIT_REF=$SPRING_BOOT_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-spring-boot-health-check-booster    CI_DESCRIPTION="Spring Boot | 104: Health Check"    CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-health-check-booster    CI_GIT_REF=$SPRING_BOOT_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-spring-boot-circuit-breaker-booster CI_DESCRIPTION="Spring Boot | 106: Circuit Breaker" CI_TYPE="Booster repo" CI_GIT_URL=https://github.com/snowdrop/spring-boot-circuit-breaker-booster CI_GIT_REF=$SPRING_BOOT_CI_GIT_REF $ADDITIONAL_OPTIONS IS_REDHAT=true | oc apply -f -
fi
