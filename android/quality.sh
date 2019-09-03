#!/usr/bin/env bash
#
# Run static code analysis tools to validate Kotlin and Shell code.
# This script also serve as "pre-push" git hook.

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

# Validate Shell code with shellcheck
checkAllShellScripts

# Validate Kotlin code with detekt and ktlint
./gradlew -q detekt ktlint ktlintFormat lintFoursuitesDebug
