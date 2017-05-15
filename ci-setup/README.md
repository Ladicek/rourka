# How to setup CI

```bash
oc new-project <project>
oc new-app --template=jenkins-ephemeral

for F in *.yml ; do oc apply -f $F ; done

# restart Jenkins master so that it picks up the new slave imagestream
oc rollout latest jenkins

./update-ci-boosters.sh
```
