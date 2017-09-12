# How to setup CI

```bash
oc new-project <project>
oc new-app --template=jenkins-ephemeral

for F in *.yml ; do oc apply -f $F ; done

# restart Jenkins master so that it picks up the new slave imagestreams
oc rollout latest jenkins

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

## Using a Maven mirror

Sometimes, it is necessary to run tests with artifacts that aren't
available in any public Maven repository. If an environment variable
`MAVEN_MIRROR` is set when running `./update-pipelines.sh`, the
`BuildConfig` templates are supposed to use its value as a URL
of a Maven proxy that is configured in `~/.m2/settings.xml` as
a mirror of `external:*`

```bash
MAVEN_MIRROR=http://... ./update-pipelines.sh
```
