#!/bin/bash

for B in $(oc get bc -o name | grep 'ci-\|losiot-' | sed -e 's|buildconfig/||') ; do
  oc start-build $B --wait
done

wget $(oc get route rourka -o jsonpath='http://{.spec.host}')

