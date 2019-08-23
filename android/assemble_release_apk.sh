#!/usr/bin/env bash
#
# This tool is useful when is need to publish a new branded app on Google Play for the first time.
# It Runs entire assembling release apk process:
# * Ensure that the script is running on master branch.
# * Create Tag.
# * Share Tag.
# * Assemble release apk.

# If a command fails then do not proceed and fail this script too
set -o errexit
set -o pipefail

if [[ $# -ne 1 ]];
  then
    echo 'This script assemble release apk'
    echo
    echo "Usage: ${0} <product flavor>"
    echo
    echo "Example: ${0} Foursuites"
    exit 64
fi

readonly PRODUCT_FLAVOR="${1}"

echo 'Starting assembling release apk process'

readonly CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
readonly LAST_TAG=$(git describe --tags --abbrev=0 --always)

echo 'Ensuring that this script is running on master branch'
if [[ "${CURRENT_BRANCH}" == "master" ]];
then
  echo "Last release tag: ${LAST_TAG}"
  read -rp "Please enter next release tag: " NEXT_TAG; echo
  export NEXT_TAG

  if [[ -z "${NEXT_TAG}" ]]
  then
    echo 'Next release tag was not entered'
    echo 'Aborting release process'
    exit 1
  fi

  echo 'Creating Tag'
  git tag -a "${NEXT_TAG}" --message "Version ${NEXT_TAG}."

  echo 'Sharing Tag'
  git push --tags

  ../gradlew "assemble${PRODUCT_FLAVOR}Release"

else
  echo 'Assembling release apk is allowed only on master branch'
  echo "Current branch is '${CURRENT_BRANCH}'"
  exit 1;
fi

echo 'Assemble apk process completed'