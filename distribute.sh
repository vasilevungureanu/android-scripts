#!/usr/bin/env bash
#
# Distributes the Debug or Release builds on a predefined list of emails.

# If a command fails then do not proceed and fail this script too
set -o errexit
set -o pipefail

# Options
readonly DEBUG='-d'
readonly RELEASE='-r'

# Build Types
readonly BUILD_TYPE_DEBUG='Debug'
readonly BUILD_TYPE_RELEASE='Release'

if [[ $# -ne 2 ]] && [[ $# -ne 3 ]]; then
  echo 'This script distribute Debug or Release builds on predefined list of emails'
  echo
  echo "Usage: ${0} <product flavor> <build type> [${DEBUG} | ${RELEASE}]"
  echo
  echo 'Options:'
  echo "${DEBUG} - Debug build type"
  echo "${RELEASE} - Release build type"
  echo
  echo "Example: ${0} Foursuites -d"
  exit 64
fi

readonly PRODUCT_FLAVOR="${1}"
readonly BUILD_TYPE_OPTION="${2}"

if [[ "${BUILD_TYPE_OPTION}" == "${DEBUG}" ]]; then
  BUILD_TYPE="${BUILD_TYPE_DEBUG}"
elif [[ "${BUILD_TYPE_OPTION}" == "${RELEASE}" ]]; then
  BUILD_TYPE="${BUILD_TYPE_RELEASE}"
else
  echo "Error: ${2} does not match [${DEBUG} | ${RELEASE}]"
  exit 64
fi

./gradlew "assemble${PRODUCT_FLAVOR}${BUILD_TYPE}" "crashlyticsUploadDistribution${PRODUCT_FLAVOR}${BUILD_TYPE}"
