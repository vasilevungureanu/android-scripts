#!/usr/bin/env bash
#
# Runs the entire release process:
# * Ensure that the script is running on the master branch.
# * Create Tag.
# * Share Tag.
# * Publish APK on Google Play for all apps.
# * For publishing is used: https://github.com/Triple-T/gradle-play-publisher.

# If a command fails then do not proceed and fail this script too
set -o errexit
set -o pipefail

echo 'Starting release process'

readonly CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
readonly LAST_TAG=$(git describe --tags --abbrev=0 --always)
readonly COMMITS_SINCE_LAST_TAG=$(git log "${LAST_TAG}..HEAD" --pretty=format:%s)
readonly DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo 'Ensuring that this script is running on master branch'
if [[ "${CURRENT_BRANCH}" == "master" ]]; then
  echo "Running Quality Checks"
  ./tools/quality.sh

  echo ""
  echo "Commits since last release tag:"
  echo "${COMMITS_SINCE_LAST_TAG}"
  echo ""

  echo "Last release tag: ${LAST_TAG}"
  read -rp "Please enter next release tag: " NEXT_TAG
  echo
  export NEXT_TAG

  if [[ -z "${NEXT_TAG}" ]]; then
    echo 'Next release tag was not entered'
    echo 'Aborting release process'
    exit 1
  fi

  echo 'Creating Tag'
  git tag -a "${NEXT_TAG}" --message "Version ${NEXT_TAG}."

  echo 'Sharing Tag'
  git push --tags

  ./gradlew publishApk
else
  echo 'Releasing is allowed only on master branch'
  echo "Current branch is '${CURRENT_BRANCH}'"
  exit 1
fi

echo 'Release process completed'
