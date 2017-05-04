# How to setup CI

```bash
oc new-project <project>
oc new-app --template=jenkins-ephemeral
# as cluster admin
oc adm policy add-cluster-role-to-user self-provisioner system:serviceaccount:<project>:jenkins

for F in *.yml ; do oc apply -f $F ; done
```
