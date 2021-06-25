#!/usr/bin/env bash
set -Eeuo pipefail

HERE="$(dirname "${BASH_SOURCE[0]}")"

. "$HERE/common"

ORG=vimc
NAME=montagu-static

APP_DOCKER_COMMIT_TAG=$ORG/$NAME:$GIT_ID
APP_DOCKER_BRANCH_TAG=$ORG/$NAME:$GIT_BRANCH

docker build --pull \
  --tag "$APP_DOCKER_COMMIT_TAG" \
  --tag "$APP_DOCKER_BRANCH_TAG" \
  "$HERE/../caddy"

docker push "$APP_DOCKER_BRANCH_TAG"
docker push "$APP_DOCKER_COMMIT_TAG"
