#!/usr/bin/env bash
#
# Running this script will:
# * Run the static code analysis tools and assemble 4Suites Debug build.
# * Distribute the 4Suites Debug build on a predefined list of emails.
#
# https://github.com/koalaman/shellcheck
# https://github.com/appmattus/markdown-lint
# https://arturbosch.github.io/detekt
# https://ktlint.github.io
# https://developer.android.com/studio/write/lint

# If a command fails then do not proceed and fail this script too
set -o errexit
set -o pipefail

#######################################
# Find all shell scripts and check them
# Globals:
#  None
# Arguments:
#  None
# Returns:
#  None
#######################################
checkAllShellScripts() {
  # shellcheck disable=SC2044
  for file in $(find . -type f \( -name "*.sh" \)); do
    shellcheck "${file}"
  done
}

checkAllShellScripts

./gradlew markdownlint detekt ktlintFormat ktlint lintFoursuitesDebug assembleFoursuitesDebug

readonly STATUS=$?

if [[ "${STATUS}" -ne 0 ]]; then
  (./gradlew assembleFourSuitesDebug appDistributionUploadFourSuitesDebug) >/dev/null 2>&1 &
fi
