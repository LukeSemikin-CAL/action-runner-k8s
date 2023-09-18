#!/bin/bash 

ENVIRONMENT=$ENVIRONMENT
ORGANISATION=$ORGANISATION
REPOSITORY=$REPOSITORY
$GITHUB_PAT=$GITHUB_PAT

REG_TOKEN=$(curl -sX POST -H "Authorization: Bearer ${GITHUB_PAT}" https://api.github.com/repos/${ORGANIZATION}/${REPOSITORY}/actions/runners/registration-token | jq -r .token)
# REG_TOKEN=$(curl -sX POST -H "Authorization: token ${ACCESS_TOKEN}" https://api.github.com/orgs/${ORGANIZATION}/actions/runners/registration-token | jq .token --raw-output)

cd /home/docker/actions-runner

./config.sh --unattended --url https://github.com/${ORGANIZATION}/${REPOSITORY} --token ${REG_TOKEN} --labels ${ENVIRONMENT}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

#Run github action run script and then exit once complete
./run.sh & wait $! 