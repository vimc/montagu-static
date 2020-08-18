#!/usr/bin/env bash
set -ex

git_id=$(git rev-parse --short=7 HEAD)
git_branch=$(git symbolic-ref --short HEAD)

org=vimc
name=montagu-static-reverse-proxy

commit_tag=$org/$name:$git_id
branch_tag=$org/$name:$git_branch

docker build -t $commit_tag -t $branch_tag .
