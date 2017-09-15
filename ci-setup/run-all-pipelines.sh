#!/bin/bash

for B in $(oc get bc -o name | grep 'ci-\|losiot-' | sed -e 's|buildconfig/||') ; do
  echo "---------- $B ----------"
  for I in $(seq 1 5) ; do
    echo "Attempt #$I..."
    oc start-build $B --wait && break
    sleep 5
  done
done
