#!/bin/bash

# CI boosters

github_ref () {
  local booster=$1
  local target=$2

  if [[ $target == "branch" ]] ; then
    case $booster in
      wfswarm*)     echo "master" ;;
      vertx*)       echo "master" ;;
      spring-boot*) echo "master" ;;
    esac
  elif [[ $target == "tag" ]] ; then
    local repo
    local branch
    local filter
    case $booster in
      wfswarm*)     repo=https://github.com/wildfly-swarm-openshiftio-boosters/${booster}-redhat/ ; branch='master' ; filter=. ;;
      vertx*)       repo=https://github.com/openshiftio-vertx-boosters/${booster}-redhat/         ; branch='master' ; filter=. ;;
      spring-boot*) repo=https://github.com/snowdrop/$booster/                                    ; branch='master' ; filter='^[^v].*redhat' ;;
    esac

    local result
    local my_clone=$(mktemp --directory)
    git clone --quiet --branch $branch $repo $my_clone
    result=$(git --git-dir $my_clone/.git describe --tags --abbrev=0 2>&1)
    if [[ "$result" =~ "fatal" ]] || [[ ! "$result" =~ "redhat" ]] ; then
      # no -redhat tag reachable from current HEAD, try selecting the latest tag
      result=$(git --git-dir $my_clone/.git tag | grep $filter | sort --version-sort --reverse | head -n 1)
    fi
    rm -rf $my_clone
    echo $result
  else
    echo $target
  fi
}

ADDITIONAL_OPTIONS=""

if [[ ! -z $CI_GITHUB_SECRET ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS CI_GITHUB_SECRET=$CI_GITHUB_SECRET"
fi

if [[ ! -z $MAVEN_REPO_ADD ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS MAVEN_REPO_ADD=$MAVEN_REPO_ADD"
fi

if [[ ! -z $S2I_IMAGE ]] ; then
  ADDITIONAL_OPTIONS="$ADDITIONAL_OPTIONS S2I_IMAGE=$S2I_IMAGE"
fi

if [[ -z $WFSWARM_CI_GIT_REF ]] ; then
  echo 'Skipping WildFly Swarm boosters, $WFSWARM_CI_GIT_REF missing'
else
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-rest-http         CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"        CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-redhat         CI_GIT_REF=$(github_ref wfswarm-rest-http $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-rest-http-crud    CI_DESCRIPTION="WildFly Swarm | 101: CRUD"            CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud-redhat    CI_GIT_REF=$(github_ref wfswarm-rest-http-crud $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-configmap         CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"       CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-configmap-redhat         CI_GIT_REF=$(github_ref wfswarm-configmap $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-sso-template   CI_NAME=ci-fmp-wfswarm-rest-http-secured CI_DESCRIPTION="WildFly Swarm | 103: SSO"             CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured-redhat CI_GIT_REF=$(github_ref wfswarm-rest-http-secured $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-health-check      CI_DESCRIPTION="WildFly Swarm | 104: Health Check"    CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-health-check-redhat      CI_GIT_REF=$(github_ref wfswarm-health-check $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-circuit-breaker   CI_DESCRIPTION="WildFly Swarm | 106: Circuit Breaker" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-circuit-breaker-redhat   CI_GIT_REF=$(github_ref wfswarm-circuit-breaker $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-wfswarm-cache             CI_DESCRIPTION="WildFly Swarm | 107: Cache"           CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-cache-redhat             CI_GIT_REF=$(github_ref wfswarm-cache $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -

  oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-rest-http         CI_DESCRIPTION="WildFly Swarm | 100: HTTP API"        CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-redhat         CI_GIT_REF=$(github_ref wfswarm-rest-http $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-rest-http-crud    CI_DESCRIPTION="WildFly Swarm | 101: CRUD"            CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-crud-redhat    CI_GIT_REF=$(github_ref wfswarm-rest-http-crud $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-configmap         CI_DESCRIPTION="WildFly Swarm | 102: ConfigMap"       CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-configmap-redhat         CI_GIT_REF=$(github_ref wfswarm-configmap $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
#  oc process ci-s2i-sso-template   CI_NAME=ci-s2i-wfswarm-rest-http-secured CI_DESCRIPTION="WildFly Swarm | 103: SSO"             CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-rest-http-secured-redhat CI_GIT_REF=$(github_ref wfswarm-rest-http-secured $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-health-check      CI_DESCRIPTION="WildFly Swarm | 104: Health Check"    CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-health-check-redhat      CI_GIT_REF=$(github_ref wfswarm-health-check $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-circuit-breaker   CI_DESCRIPTION="WildFly Swarm | 106: Circuit Breaker" CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-circuit-breaker-redhat   CI_GIT_REF=$(github_ref wfswarm-circuit-breaker $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-wfswarm-cache             CI_DESCRIPTION="WildFly Swarm | 107: Cache"           CI_GIT_URL=https://github.com/wildfly-swarm-openshiftio-boosters/wfswarm-cache-redhat             CI_GIT_REF=$(github_ref wfswarm-cache $WFSWARM_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
fi

if [[ -z $VERTX_CI_GIT_REF ]] ; then
  echo 'Skipping Vert.x boosters, $VERTX_CI_GIT_REF missing'
else
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-http-booster            CI_DESCRIPTION="Vert.x | 100: HTTP API"        CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-http-booster-redhat            CI_GIT_REF=$(github_ref vertx-http-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-crud-booster            CI_DESCRIPTION="Vert.x | 101: CRUD"            CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-crud-booster-redhat            CI_GIT_REF=$(github_ref vertx-crud-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-configmap-booster       CI_DESCRIPTION="Vert.x | 102: ConfigMap"       CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-configmap-booster-redhat       CI_GIT_REF=$(github_ref vertx-configmap-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-sso-template   CI_NAME=ci-fmp-vertx-secured-http-booster    CI_DESCRIPTION="Vert.x | 103: SSO"             CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-secured-http-booster-redhat    CI_GIT_REF=$(github_ref vertx-secured-http-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-health-checks-booster   CI_DESCRIPTION="Vert.x | 104: Health Check"    CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-health-checks-booster-redhat   CI_GIT_REF=$(github_ref vertx-health-checks-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-circuit-breaker-booster CI_DESCRIPTION="Vert.x | 106: Circuit Breaker" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-circuit-breaker-booster-redhat CI_GIT_REF=$(github_ref vertx-circuit-breaker-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-vertx-cache-booster           CI_DESCRIPTION="Vert.x | 107: Cache"           CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-cache-booster-redhat CI_GIT_REF=$(github_ref vertx-cache-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -

  oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-http-booster            CI_DESCRIPTION="Vert.x | 100: HTTP API"        CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-http-booster-redhat            CI_GIT_REF=$(github_ref vertx-http-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-crud-booster            CI_DESCRIPTION="Vert.x | 101: CRUD"            CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-crud-booster-redhat            CI_GIT_REF=$(github_ref vertx-crud-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-configmap-booster       CI_DESCRIPTION="Vert.x | 102: ConfigMap"       CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-configmap-booster-redhat       CI_GIT_REF=$(github_ref vertx-configmap-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
#  oc process ci-s2i-sso-template   CI_NAME=ci-s2i-vertx-secured-http-booster    CI_DESCRIPTION="Vert.x | 103: SSO"             CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-secured-http-booster-redhat    CI_GIT_REF=$(github_ref vertx-secured-http-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-health-checks-booster   CI_DESCRIPTION="Vert.x | 104: Health Check"    CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-health-checks-booster-redhat   CI_GIT_REF=$(github_ref vertx-health-checks-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-circuit-breaker-booster CI_DESCRIPTION="Vert.x | 106: Circuit Breaker" CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-circuit-breaker-booster-redhat CI_GIT_REF=$(github_ref vertx-circuit-breaker-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-vertx-cache-booster           CI_DESCRIPTION="Vert.x | 107: Cache"           CI_GIT_URL=https://github.com/openshiftio-vertx-boosters/vertx-cache-booster-redhat CI_GIT_REF=$(github_ref vertx-cache-booster $VERTX_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
fi

if [[ -z $SPRING_BOOT_CI_GIT_REF ]] ; then
  echo 'Skipping Spring Boot boosters, $SPRING_BOOT_CI_GIT_REF missing'
else
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-http-booster            CI_DESCRIPTION="Spring Boot | 100: HTTP API"        CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-booster            CI_GIT_REF=$(github_ref spring-boot-http-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-crud-booster            CI_DESCRIPTION="Spring Boot | 101: CRUD"            CI_GIT_URL=https://github.com/snowdrop/spring-boot-crud-booster            CI_GIT_REF=$(github_ref spring-boot-crud-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-configmap-booster       CI_DESCRIPTION="Spring Boot | 102: ConfigMap"       CI_GIT_URL=https://github.com/snowdrop/spring-boot-configmap-booster       CI_GIT_REF=$(github_ref spring-boot-configmap-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-sso-template   CI_NAME=ci-fmp-spring-boot-http-secured-booster    CI_DESCRIPTION="Spring Boot | 103: SSO"             CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-secured-booster    CI_GIT_REF=$(github_ref spring-boot-http-secured-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-health-check-booster    CI_DESCRIPTION="Spring Boot | 104: Health Check"    CI_GIT_URL=https://github.com/snowdrop/spring-boot-health-check-booster    CI_GIT_REF=$(github_ref spring-boot-health-check-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-circuit-breaker-booster CI_DESCRIPTION="Spring Boot | 106: Circuit Breaker" CI_GIT_URL=https://github.com/snowdrop/spring-boot-circuit-breaker-booster CI_GIT_REF=$(github_ref spring-boot-circuit-breaker-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-fmp-basic-template CI_NAME=ci-fmp-spring-boot-cache-booster           CI_DESCRIPTION="Spring Boot | 107: Cache"           CI_GIT_URL=https://github.com/snowdrop/spring-boot-cache-booster           CI_GIT_REF=$(github_ref spring-boot-cache-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -

  oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-http-booster            CI_DESCRIPTION="Spring Boot | 100: HTTP API"        CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-booster            CI_GIT_REF=$(github_ref spring-boot-http-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-crud-booster            CI_DESCRIPTION="Spring Boot | 101: CRUD"            CI_GIT_URL=https://github.com/snowdrop/spring-boot-crud-booster            CI_GIT_REF=$(github_ref spring-boot-crud-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-configmap-booster       CI_DESCRIPTION="Spring Boot | 102: ConfigMap"       CI_GIT_URL=https://github.com/snowdrop/spring-boot-configmap-booster       CI_GIT_REF=$(github_ref spring-boot-configmap-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
#  oc process ci-s2i-sso-template   CI_NAME=ci-s2i-spring-boot-http-secured-booster    CI_DESCRIPTION="Spring Boot | 103: SSO"             CI_GIT_URL=https://github.com/snowdrop/spring-boot-http-secured-booster    CI_GIT_REF=$(github_ref spring-boot-http-secured-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-health-check-booster    CI_DESCRIPTION="Spring Boot | 104: Health Check"    CI_GIT_URL=https://github.com/snowdrop/spring-boot-health-check-booster    CI_GIT_REF=$(github_ref spring-boot-health-check-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-circuit-breaker-booster CI_DESCRIPTION="Spring Boot | 106: Circuit Breaker" CI_GIT_URL=https://github.com/snowdrop/spring-boot-circuit-breaker-booster CI_GIT_REF=$(github_ref spring-boot-circuit-breaker-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
  oc process ci-s2i-basic-template CI_NAME=ci-s2i-spring-boot-cache-booster           CI_DESCRIPTION="Spring Boot | 107: Cache"           CI_GIT_URL=https://github.com/snowdrop/spring-boot-cache-booster           CI_GIT_REF=$(github_ref spring-boot-cache-booster $SPRING_BOOT_CI_GIT_REF) $ADDITIONAL_OPTIONS | oc apply -f -
fi
