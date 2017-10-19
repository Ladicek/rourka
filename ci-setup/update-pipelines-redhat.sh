#!/bin/bash

# CI boosters

# TODO the `sort -nr` part is pretty weak, it probably won't work
# correctly once we have release versions greater than 9
github_ref () {
  local booster=$1
  local target=$2

  if [[ $target == "branch" ]] ; then
    case $booster in
      wfswarm*)     echo "master" ;;
      vertx*)       echo "master" ;;
      spring-boot*) echo "redhat" ;;
    esac
  elif [[ $target == "tag" ]] ; then
    local github
    local filter
    case $booster in
      wfswarm*)     github=https://github.com/wildfly-swarm-openshiftio-boosters/$booster/  ; filter='redhat' ;;
      vertx*)       github=https://github.com/openshiftio-vertx-boosters/${booster}-redhat/ ; filter='.' ;;
      spring-boot*) github=https://github.com/snowdrop/$booster/                            ; filter='redhat' ;;
    esac
    echo $(git ls-remote --refs --tags $github | awk '{print $2}' | grep $filter | sort -nr | head -n 1 | sed -e 's|refs/||')
  else
    echo $target
  fi
}

ADDITIONAL_OPTIONS="IS_REDHAT=true"

if [[ ! -z $CI_GITHUB_SECRET ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS CI_GITHUB_SECRET=$CI_GITHUB_SECRET"
fi

if [[ ! -z $MAVEN_REPO_ADD ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS MAVEN_REPO_ADD=$MAVEN_REPO_ADD"
fi

if [[ -z $WFSWARM_CI_GIT_REF ]] ; then
  echo 'Skipping WildFly Swarm boosters, $WFSWARM_CI_GIT_REF missing'
else
  oc process ci-basic-template CI_NAME=ci-wfswarm-rest-http         CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"        CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http         CI_GIT_REF=$(github_ref wfswarm-rest-http $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-wfswarm-rest-http-crud    CI_DESCRIPTION="WildFly Swarm | 101: CRUD"            CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud    CI_GIT_REF=$(github_ref wfswarm-rest-http-crud $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-wfswarm-configmap         CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"       CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-configmap         CI_GIT_REF=$(github_ref wfswarm-configmap $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  #oc process ci-sso-template   CI_NAME=ci-wfswarm-rest-http-secured CI_DESCRIPTION="WildFly Swarm | 103: SSO"             CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured CI_GIT_REF=$(github_ref wfswarm-rest-http-secured $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-wfswarm-health-check      CI_DESCRIPTION="WildFly Swarm | 104: Health Check"    CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-health-check      CI_GIT_REF=$(github_ref wfswarm-health-check $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-wfswarm-circuit-breaker   CI_DESCRIPTION="WildFly Swarm | 106: Circuit Breaker" CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-circuit-breaker   CI_GIT_REF=$(github_ref wfswarm-circuit-breaker $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
fi

if [[ -z $VERTX_CI_GIT_REF ]] ; then
  echo 'Skipping Vert.x boosters, $VERTX_CI_GIT_REF missing'
else
  oc process ci-basic-template CI_NAME=ci-vertx-http-booster            CI_DESCRIPTION="Vert.x | 100: HTTP API"        CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-http-booster-redhat            CI_GIT_REF=$(github_ref vertx-http-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-vertx-crud-booster            CI_DESCRIPTION="Vert.x | 101: CRUD"            CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-crud-booster-redhat            CI_GIT_REF=$(github_ref vertx-crud-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-vertx-configmap-booster       CI_DESCRIPTION="Vert.x | 102: ConfigMap"       CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-configmap-booster-redhat       CI_GIT_REF=$(github_ref vertx-configmap-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  #oc process ci-sso-template   CI_NAME=ci-vertx-secured-http-booster    CI_DESCRIPTION="Vert.x | 103: SSO"             CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-secured-http-booster-redhat    CI_GIT_REF=$(github_ref vertx-secured-http-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-vertx-health-checks-booster   CI_DESCRIPTION="Vert.x | 104: Health Check"    CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-health-checks-booster-redhat   CI_GIT_REF=$(github_ref vertx-health-checks-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-vertx-circuit-breaker-booster CI_DESCRIPTION="Vert.x | 106: Circuit Breaker" CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-circuit-breaker-booster-redhat CI_GIT_REF=$(github_ref vertx-circuit-breaker-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
fi

if [[ -z $SPRING_BOOT_CI_GIT_REF ]] ; then
  echo 'Skipping Spring Boot boosters, $SPRING_BOOT_CI_GIT_REF missing'
else
  oc process ci-basic-template CI_NAME=ci-spring-boot-http-booster            CI_DESCRIPTION="Spring Boot | 100: HTTP API"        CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-booster            CI_GIT_REF=$(github_ref spring-boot-http-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-spring-boot-crud-booster            CI_DESCRIPTION="Spring Boot | 101: CRUD"            CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/snowdrop/spring-boot-crud-booster            CI_GIT_REF=$(github_ref spring-boot-crud-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-spring-boot-configmap-booster       CI_DESCRIPTION="Spring Boot | 102: ConfigMap"       CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/snowdrop/spring-boot-configmap-booster       CI_GIT_REF=$(github_ref spring-boot-configmap-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  #oc process ci-sso-template   CI_NAME=ci-spring-boot-http-secured-booster    CI_DESCRIPTION="Spring Boot | 103: SSO"             CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-secured-booster    CI_GIT_REF=$(github_ref spring-boot-http-secured-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-spring-boot-health-check-booster    CI_DESCRIPTION="Spring Boot | 104: Health Check"    CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/snowdrop/spring-boot-health-check-booster    CI_GIT_REF=$(github_ref spring-boot-health-check-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-basic-template CI_NAME=ci-spring-boot-circuit-breaker-booster CI_DESCRIPTION="Spring Boot | 106: Circuit Breaker" CI_TYPE="Fabric8 Maven plugin" CI_GIT_URL=https://github.com/snowdrop/spring-boot-circuit-breaker-booster CI_GIT_REF=$(github_ref spring-boot-circuit-breaker-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
fi
