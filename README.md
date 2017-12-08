# RHOAR Boosters Tests aka _Rourka_

## How does it work

The entire test environment is a set of OpenShift pipeline builds,
one pipeline for each cell in the testing matrix. The testing matrix
is _Runtime_ x _Mission_ x _Tested Scenario_. Jenkins pipelines are
used to drive the tests, they are not themselves considered part
of the system under test.

The dashboard reads all the pipelines and their statuses via the OpenShift API
and presents them in a nicely colored tabular format. It can be deployed
by `mvn fabric8:deploy` or `oc apply -f build.yml && oc start-build rourka`.

## How to set it up

Select the correct OpenShift project (`oc project` or `oc new-project`).

```bash
cd ci-setup

for F in *.yml ; do oc apply -f $F ; done

oc new-app --template=jenkins-ephemeral --param NAMESPACE=$(oc project -q)

./update-pipelines.sh
```

## Make changes

The text above is for initial setup. For making changes, this subset
is enough:

```bash
for F in *.yml ; do oc apply -f $F ; done

./update-pipelines.sh
```

## Webhooks

Just running `./update-pipelines.sh` will generate a random GitHub secret
for each pipeline. That's impractical for setting up webhooks for CI.
So, when an environment variable `CI_GITHUB_SECRET` is set when running
`./update-pipelines.sh`, its value will be used as a GitHub secret for all
pipelines.

```bash
CI_GITHUB_SECRET=xxx ./update-pipelines.sh`
```

To get all the webhook URLs that have to be set in GitHub, run:

```bash
oc describe bc | grep webhooks
```

The webhook is of type `application/json`.

## Using an additional Maven repository

Sometimes, it is necessary to run tests with artifacts that aren't
available in any public Maven repository. If an environment variable
`MAVEN_REPO_ADD` is set when running `./update-pipelines.sh`, the
`BuildConfig` templates are supposed to use its value as a URL
of an additional Maven repository that should be added to and
enabled in `~/.m2/settings.xml`.

```bash
MAVEN_REPO_ADD=http://... ./update-pipelines.sh
```

## Capacity requirements

This is a rough, pessimistic estimate with an eye towards expected
future requirements and growth.

- 1 Jenkins server
    - memory: 1 GiB
    - CPU: 1 core
    - persistent volumes: 1 with at least 2 GiB of space, if possible
- several Jenkins slaves (created and discarded on demand)
    - memory: 3 GiB
    - CPU: 3 cores
- 1 Rourka dashboard
    - memory: 1 GiB
    - CPU: 1 core
- 1 Fabric8 Launcher (created and discarded on demand)
    - 4 deployments (nginx, frontend, backend, missioncontrol)
    - memory: 4 GiB
    - CPU: 4 cores
- several boosters (created and discarded on demand)
    - memory: 3 GiB
    - CPU: 3 cores

Total:
- memory: 12 GiB
- CPU: 12 cores
- persistent volumes: 1 if possible, can do with 0
