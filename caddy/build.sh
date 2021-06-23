#!/usr/bin/env bash
set -Eeuo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

if [ "$BUILDKITE" = "true" ]; then
    GIT_ID=${BUILDKITE_COMMIT:0:7}
else
    GIT_ID=$(git rev-parse --short=7 HEAD)
fi

if [ "$BUILDKITE" = "true" ]; then
    GIT_BRANCH=$BUILDKITE_BRANCH
else
    GIT_BRANCH=$(git symbolic-ref --short HEAD)
fi

ORG=vimc
NAME=montagu-static

APP_DOCKER_COMMIT_TAG=$ORG/$NAME:$GIT_ID
APP_DOCKER_BRANCH_TAG=$ORG/$NAME:$GIT_BRANCH

docker build --pull \
  --tag "$APP_DOCKER_COMMIT_TAG" \
  --tag "$APP_DOCKER_BRANCH_TAG" \
  .

docker push "$APP_DOCKER_BRANCH_TAG"
docker push "$APP_DOCKER_COMMIT_TAG"
