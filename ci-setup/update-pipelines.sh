#!/bin/bash

# CI boosters

ADDITIONAL_OPTIONS=""

if [[ ! -z $CI_GITHUB_SECRET ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS CI_GITHUB_SECRET=$CI_GITHUB_SECRET"
fi

if [[ ! -z $MAVEN_REPO_ADD ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS MAVEN_REPO_ADD=$MAVEN_REPO_ADD"
fi

oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-rest-http         CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"        CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http         $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-rest-http-crud    CI_DESCRIPTION="WildFly Swarm | 101: CRUD"            CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud    $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-configmap         CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"       CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-configmap         $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-sso-template   CI_NAME=ci-fmp-wfswarm-rest-http-secured CI_DESCRIPTION="WildFly Swarm | 103: SSO"             CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-health-check      CI_DESCRIPTION="WildFly Swarm | 104: Health Check"    CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-health-check      $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-circuit-breaker   CI_DESCRIPTION="WildFly Swarm | 106: Circuit Breaker" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-circuit-breaker   $ADDITIONAL_OPTIONS | oc apply -f -

oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-rest-http         CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"        CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http         $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-rest-http-crud    CI_DESCRIPTION="WildFly Swarm | 101: CRUD"            CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud    $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-configmap         CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"       CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-configmap         $ADDITIONAL_OPTIONS | oc apply -f -
#oc process ci-s2i-sso-template   CI_NAME=ci-s2i-wfswarm-rest-http-secured CI_DESCRIPTION="WildFly Swarm | 103: SSO"             CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-health-check      CI_DESCRIPTION="WildFly Swarm | 104: Health Check"    CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-health-check      $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-circuit-breaker   CI_DESCRIPTION="WildFly Swarm | 106: Circuit Breaker" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-circuit-breaker   $ADDITIONAL_OPTIONS | oc apply -f -

oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-http-booster            CI_DESCRIPTION="Vert.x | 100: HTTP API"        CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-http-booster            $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-crud-booster            CI_DESCRIPTION="Vert.x | 101: CRUD"            CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-crud-booster            $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-configmap-booster       CI_DESCRIPTION="Vert.x | 102: ConfigMap"       CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-configmap-booster       $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-sso-template   CI_NAME=ci-fmp-vertx-secured-http-booster    CI_DESCRIPTION="Vert.x | 103: SSO"             CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-secured-http-booster    $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-health-checks-booster   CI_DESCRIPTION="Vert.x | 104: Health Check"    CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-health-checks-booster   $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-circuit-breaker-booster CI_DESCRIPTION="Vert.x | 106: Circuit Breaker" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-circuit-breaker-booster $ADDITIONAL_OPTIONS | oc apply -f -

oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-http-booster            CI_DESCRIPTION="Vert.x | 100: HTTP API"        CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-http-booster            $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-crud-booster            CI_DESCRIPTION="Vert.x | 101: CRUD"            CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-crud-booster            $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-configmap-booster       CI_DESCRIPTION="Vert.x | 102: ConfigMap"       CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-configmap-booster       $ADDITIONAL_OPTIONS | oc apply -f -
#oc process ci-s2i-sso-template   CI_NAME=ci-s2i-vertx-secured-http-booster    CI_DESCRIPTION="Vert.x | 103: SSO"             CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-secured-http-booster    $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-health-checks-booster   CI_DESCRIPTION="Vert.x | 104: Health Check"    CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-health-checks-booster   $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-circuit-breaker-booster CI_DESCRIPTION="Vert.x | 106: Circuit Breaker" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-circuit-breaker-booster $ADDITIONAL_OPTIONS | oc apply -f -

oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-http-booster            CI_DESCRIPTION="Spring Boot | 100: HTTP API"        CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-booster            CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-crud-booster            CI_DESCRIPTION="Spring Boot | 101: CRUD"            CI_GIT_URL=https://github.com/snowdrop/spring-boot-crud-booster            CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-configmap-booster       CI_DESCRIPTION="Spring Boot | 102: ConfigMap"       CI_GIT_URL=https://github.com/snowdrop/spring-boot-configmap-booster       CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-sso-template   CI_NAME=ci-fmp-spring-boot-http-secured-booster    CI_DESCRIPTION="Spring Boot | 103: SSO"             CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-secured-booster    CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-health-check-booster    CI_DESCRIPTION="Spring Boot | 104: Health Check"    CI_GIT_URL=https://github.com/snowdrop/spring-boot-health-check-booster    CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-circuit-breaker-booster CI_DESCRIPTION="Spring Boot | 106: Circuit Breaker" CI_GIT_URL=https://github.com/snowdrop/spring-boot-circuit-breaker-booster CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -

oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-http-booster            CI_DESCRIPTION="Spring Boot | 100: HTTP API"        CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-booster            CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-crud-booster            CI_DESCRIPTION="Spring Boot | 101: CRUD"            CI_GIT_URL=https://github.com/snowdrop/spring-boot-crud-booster            CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-configmap-booster       CI_DESCRIPTION="Spring Boot | 102: ConfigMap"       CI_GIT_URL=https://github.com/snowdrop/spring-boot-configmap-booster       CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
#oc process ci-s2i-sso-template   CI_NAME=ci-s2i-spring-boot-http-secured-booster    CI_DESCRIPTION="Spring Boot | 103: SSO"             CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-secured-booster    CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-health-check-booster    CI_DESCRIPTION="Spring Boot | 104: Health Check"    CI_GIT_URL=https://github.com/snowdrop/spring-boot-health-check-booster    CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-circuit-breaker-booster CI_DESCRIPTION="Spring Boot | 106: Circuit Breaker" CI_GIT_URL=https://github.com/snowdrop/spring-boot-circuit-breaker-booster CI_GIT_REF=sb-1.5.x $ADDITIONAL_OPTIONS | oc apply -f -
