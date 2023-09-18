# POC For In-House Docker Container Github Action

#### Build 

```BASH
docker build --tag <image_name> .
```

#### Single Docker Container

```BASH
docker run \    
--detach \
--env ENVIRONMENT=<runner_tags \
--env ORGANIZATION=<organisation> \
--env REPOSITORY=<repository \
--env GITHUB_PAT=<GITHUB_PAT_TOKEN> \
--name runner \
ghub_runner
```