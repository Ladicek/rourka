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
Hence, it's possible to pass a parameter `./update-pipelines.sh XXX`
which will then be used as a GitHub secret for all pipelines.

To get all the webhook URLs that have to be set in GitHub, run:

```bash
oc describe bc | grep webhooks
```

The webhook is of type `application/json`.
