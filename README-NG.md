`oc project xxx` or `oc new-project xxx`

`for S in $(ls secrets/actual*) ; do oc create -f $S ; done`

```bash
oc create -f jenkins-master/image-stream.yml
oc create -f jenkins-master/jenkins-sa-admin.yml
oc new-app --template=jenkins-ephemeral --param NAMESPACE=$(oc project -q)
oc patch dc/jenkins --patch "$(cat jenkins-master/patch.yml)"
```

Run the `zygote` job.
