#!/bin/bash

FILTER=.
if [[ -n $ROURKA_BOOSTERS_FILTER ]] ; then
  FILTER=$ROURKA_BOOSTERS_FILTER
fi

for B in $(oc get bc -o name | grep 'ci-\|losiot-' | grep "$FILTER" | sed -r -e 's|buildconfigs?/||') ; do
  echo "---------- $B ----------"
  GIT_URL=$(oc get bc $B -o jsonpath='{.spec.source.git.uri}')
  GIT_REF=$(oc get bc $B -o jsonpath='{.spec.source.git.ref}')
  GIT_SHA=$(git ls-remote $GIT_URL $GIT_REF | awk '{print $1}')
  echo "${GIT_URL}@${GIT_REF}: ${GIT_SHA}"

  for I in $(seq 1 5) ; do
    echo "Attempt #$I..."
    oc start-build $B --wait && break
    sleep 5
  done
done
