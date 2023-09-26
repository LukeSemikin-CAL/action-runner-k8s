#base image
from ubuntu:22.04

#Set Github Runner Version
ARG RUNNER_VERSION="2.309.0"

#Add Non Root user
RUN useradd -m docker

#Install Required Packages
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

#Download Required Runner Files
RUN cd /home/docker && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

#Install some additional dependencies
RUN chown -R docker ~docker && /home/docker/actions-runner/bin/installdependencies.sh

#Configure Necessary Files
COPY start_action.sh start_action.sh
RUN chmod +x start_action.sh 

#Use Docker user 
USER docker

#Set Entrypoint
ENTRYPOINT ["./start_action.sh"]

