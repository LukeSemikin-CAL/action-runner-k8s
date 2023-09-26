#!/bin/bash 

ENVIRONMENT=$ENVIRONMENT
ORGANISATION=$ORGANISATION
REPOSITORY=$REPOSITORY
GITHUB_PAT=$GITHUB_PAT


REG_TOKEN=$(curl -sX POST -H "Authorization: Bearer ${GITHUB_PAT}" https://api.github.com/repos/${ORGANISATION}/${REPOSITORY}/actions/runners/registration-token | jq -r .token)

cd /home/docker/actions-runner

./config.sh --unattended --url https://github.com/${ORGANISATION}/${REPOSITORY} --name $(hostname) --token ${REG_TOKEN} --labels ${ENVIRONMENT}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

#Run github action run script and then exit once complete
./run.sh & wait $! 