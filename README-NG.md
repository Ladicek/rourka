# RHOAR Boosters Tests aka _Rourka_

## Deploy

`oc project xxx` or `oc new-project xxx`

`for S in $(ls secrets/*.yml) ; do oc create -f $S ; done`

```bash
oc create -f jenkins-master/image-stream.yml
oc create -f jenkins-master/jenkins-sa-admin.yml
oc new-app --template=jenkins-ephemeral --param NAMESPACE=$(oc project -q)
oc patch dc/jenkins --patch "$(cat jenkins-master/patch.yml)"
```

Run the `zygote` job.

## Develop

Assumes Minishift with a `routing-suffix` of `minishift`.

### `jenkins-master`

Login to Minishift Docker:
- `eval $(minishift docker-env)`
- `docker login -u $(oc whoami) -p $(oc whoami -t) $(minishift openshift registry)`

Initial OpenShift config:
- `for S in $(ls ../secrets/*.yml) ; do oc create -f $S ; done`
- `oc create -f jenkins-sa-admin.yml`

Build a Jenkins master image:
- `docker build -t docker-registry-default.minishift:443/myproject/jenkins:latest .`
- `docker push docker-registry-default.minishift:443/myproject/jenkins:latest`

Deploy Jenkins master:
- `oc new-app --template=jenkins-ephemeral --param NAMESPACE=$(oc project -q)`
- `oc patch dc/jenkins --patch "$(cat patch.yml)"`

Changes:
- just `docker build` and `docker push` as above

### `dashboard`

- edit `src/main/resources/project-local.yml`
- `mvn clean package`
- `java -jar target/rourka-swarm.jar -S local`
