#!/usr/bin/env bash
#
# Automatically add branch name to every commit messages.
# Thanks to: https://gist.github.com/bartoszmajsak/1396344

readonly BRANCH_NAME=$(git symbolic-ref --short HEAD)
readonly BRANCHES_TO_SKIP=(master)
readonly BRANCH_EXCLUDED=$(printf "%s\n" "${BRANCHES_TO_SKIP[@]}" | grep -c "^$BRANCH_NAME$")

if [[ -n "${BRANCH_NAME}" ]] && ! [[ "${BRANCH_EXCLUDED}" -eq 1 ]]; then
  sed -i.bak -e "1s/^/${BRANCH_NAME}: /" "${1}"
fi
