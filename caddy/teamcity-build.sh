#!/usr/bin/env bash
set -e

GIT_ID=$(git rev-parse --short=7 HEAD)
GIT_BRANCH=$(git symbolic-ref --short HEAD)
ORG=vimc
NAME=montagu-static

APP_DOCKER_TAG=$ORG/$NAME
APP_DOCKER_COMMIT_TAG=$ORG/$NAME:$GIT_ID
APP_DOCKER_BRANCH_TAG=$ORG/$NAME:$GIT_BRANCH

docker build --pull \
       --tag $APP_DOCKER_COMMIT_TAG \
       --tag $APP_DOCKER_BRANCH_TAG \
       .

docker push $APP_DOCKER_BRANCH_TAG
docker push $APP_DOCKER_COMMIT_TAG
