#!/bin/bash

set -Eeuo pipefail

if [[ "${1:-}" == "--help" ]]; then
  cat <<EOF
Usage: source ./team.sh [--help]

Automates creation and update of GitHub teams (parent and subteams), maintainers, and repo permissions for an application in a GitHub organization using gh api.

Environment variables (can be overridden):
  ORG         GitHub organization (default: LouisVuitton-CN)
  APP_NAME    Application name (default: example)
  REPOS       Space-separated repo list (default: test-repo)
  MAINTAINERS Space-separated maintainer usernames (default: git-huangkn minyang-lv)

Example:
  APP_NAME=Exotic REPOS="repo1 repo2" MAINTAINERS="alice bob" source ./team.sh

The script is idempotent and logs all actions to stderr. Errors print the line number and command.
EOF
  exit 0
fi

ORG="LouisVuitton-CN"
REPOS="${REPOS:-test-repo}"
APP_NAME="${APP_NAME:-example}"
TEAM_NAME="Team-${APP_NAME}"
MAINTAINERS="${MAINTAINERS:-git-huangkn minyang-lv}"
API_VERSION="2022-11-28"

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" >&2
}

error_handler() {
  local exit_code="$1"
  local line_no="$2"
  local command="$3"

  log "ERROR line ${line_no}: command failed with exit code ${exit_code}: ${command}"
  exit "$exit_code"
}

trap 'error_handler "$?" "$LINENO" "$BASH_COMMAND"' ERR

team_slug() {
  printf '%s' "$1" | tr '[:upper:]' '[:lower:]' | sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//'
}

team_exists() {
  local slug="$1"

  gh api -H "X-GitHub-Api-Version: ${API_VERSION}" \
    "/orgs/${ORG}/teams/${slug}" \
    --silent >/dev/null 2>&1
}

team_id() {
  local slug="$1"

  gh api -H "X-GitHub-Api-Version: ${API_VERSION}" \
    "/orgs/${ORG}/teams/${slug}" \
    --jq '.id'
}

upsert_team() {
  local name="$1"
  local description="$2"
  local permission="$3"
  local parent_id="$4"
  local slug
  local method
  local endpoint
  local action
  local args

  slug=$(team_slug "$name")

  if team_exists "$slug"; then
    method="PATCH"
    endpoint="/orgs/${ORG}/teams/${slug}"
    action="Updating"
  else
    method="POST"
    endpoint="/orgs/${ORG}/teams"
    action="Creating"
  fi

  log "${action} team ${name} (slug: ${slug})"

  args=(
    --method "$method"
    -H "X-GitHub-Api-Version: ${API_VERSION}"
    "$endpoint"
    -f "name=${name}"
    -f "description=${description}"
    -f "privacy=closed"
  )

  if [ -n "$permission" ]; then
    args+=( -f "permission=${permission}" )
  fi

  if [ -n "$parent_id" ]; then
    args+=( -F "parent_team_id=${parent_id}" )
  fi

  gh api "${args[@]}" --jq '.slug'
}

ensure_maintainer() {
  local slug="$1"
  local username="$2"

  # Defensive: skip if username is empty or contains whitespace
  if [[ -z "$username" || "$username" =~ [[:space:]] ]]; then
    log "WARNING: Skipping invalid maintainer username: '$username'"
    return
  fi

  log "Ensuring maintainer ${username} on team ${slug}"

  gh api --method PUT \
    -H "X-GitHub-Api-Version: ${API_VERSION}" \
    "/orgs/${ORG}/teams/${slug}/memberships/${username}" \
    -f role=maintainer \
    --silent
}

ensure_repo_permission() {
  local slug="$1"
  local repo="$2"
  local permission="$3"

  log "Ensuring ${permission} permission on ${ORG}/${repo} for team ${slug}"

  gh api --method PUT \
    -H "X-GitHub-Api-Version: ${API_VERSION}" \
    "/orgs/${ORG}/teams/${slug}/repos/${ORG}/${repo}" \
    -f "permission=${permission}" \
    --silent
}

log "Starting team sync for app ${APP_NAME} in org ${ORG}"
log "Inputs: REPOS=${REPOS}; MAINTAINERS=${MAINTAINERS}"

PARENT_SLUG=$(upsert_team "${TEAM_NAME}" "Team ${APP_NAME}" "" "")
PARENT_ID=$(team_id "${PARENT_SLUG}")

log "Resolved parent team ${PARENT_SLUG} with id ${PARENT_ID}"


# Only add maintainers if MAINTAINERS is non-empty
if [ -n "${MAINTAINERS// /}" ]; then
  for MAINTAINER in ${MAINTAINERS}
  do
    [ -n "$MAINTAINER" ] || continue
    ensure_maintainer "${PARENT_SLUG}" "${MAINTAINER}"
  done
else
  log "No maintainers specified, skipping maintainer assignment."
fi

READER_SLUG=$(upsert_team "${TEAM_NAME}-Reader" "Team ${APP_NAME} Reader" "pull" "${PARENT_ID}")
CONTRIBUTOR_SLUG=$(upsert_team "${TEAM_NAME}-Contributor" "Team ${APP_NAME} Contributor" "push" "${PARENT_ID}")
ADMIN_SLUG=$(upsert_team "${TEAM_NAME}-Administrator" "Team ${APP_NAME} Administrator" "" "${PARENT_ID}")


# Only set repo permissions if REPOS is non-empty
if [ -n "${REPOS// /}" ]; then
  for REPO in ${REPOS}
  do
    [ -n "$REPO" ] || continue
    ensure_repo_permission "${READER_SLUG}" "${REPO}" "pull"
    ensure_repo_permission "${CONTRIBUTOR_SLUG}" "${REPO}" "push"
    ensure_repo_permission "${ADMIN_SLUG}" "${REPO}" "admin"
  done
else
  log "No repos specified, skipping repo permission assignment."
fi

log "Team sync completed for app ${APP_NAME}"