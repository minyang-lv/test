#!/bin/bash

ORG="LouisVuitton-CN"
REPOS="test-repo"
APP_NAME="example"
TEAM_NAME="team-${APP_NAME}"
MAINTAINERS="git-huangkn minyang-lv"

parent_args=()
child_args=()

for REPO in ${REPOS}
do
    child_args+=( -f "repo_names[]=${ORG}/${REPO}" )
done

for MAINTAINER in ${MAINTAINERS}
do
    parent_args+=( -f "maintainers[]=${MAINTAINER}" )
done

gh api --method POST \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "/orgs/${ORG}/teams" \
  -f name="team-${TEAM_NAME}" \
  -f description="Team ${APP_NAME}" \
  -f privacy="closed" \
  "${parent_args[@]}"

PARENT_ID=$(gh api "/orgs/${ORG}/teams/${TEAM_NAME}" --jq '.id')

gh api --method POST \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "/orgs/${ORG}/teams" \
  -f name="${TEAM_NAME}-Reader" \
  -f description="Team ${APP_NAME} Reader" \
  -f privacy="closed" \
  -f permission=pull \
  -f parent_team_id="${PARENT_ID}" \
  "${child_args[@]}"

gh api --method POST \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "/orgs/${ORG}/teams" \
  -f name="${TEAM_NAME}-Contributor" \
  -f description="Team ${APP_NAME} Contributor" \
  -f privacy="closed" \
  -f permission=push \
  -f parent_team_id="${PARENT_ID}" \
  "${child_args[@]}"

gh api --method POST \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "/orgs/${ORG}/teams" \
  -f name="${TEAM_NAME}-Administrator" \
  -f description="Team ${APP_NAME} Administrator" \
  -f privacy="closed" \
  -f permission=admin \
  -f parent_team_id="${PARENT_ID}" \
  "${child_args[@]}"
