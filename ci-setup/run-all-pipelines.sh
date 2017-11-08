#!/bin/bash

for B in $(oc get bc -o name | grep 'ci-\|losiot-' | sed -r -e 's|buildconfigs?/||') ; do
  echo "---------- $B ----------"
  GIT_URL=$(oc get bc $B -o jsonpath='{.spec.source.git.uri}')
  GIT_REF=$(oc get bc $B -o jsonpath='{.spec.source.git.ref}')
  GIT_SHA=$(git ls-remote $GIT_URL $GIT_REF | awk '{print $1}')
  echo "${GIT_URL}@${GIT_REF}: ${GIT_SHA}"

  if [[ $B =~ spring-boot-configmap ]] || [[ $B =~ vertx-configmap-booster ]] ; then
    for I in $(seq 1 5) ; do
      echo "Attempt #$I..."
      oc start-build $B --wait && break
      sleep 5
    done
  else
    oc start-build $B --wait
  fi
done
