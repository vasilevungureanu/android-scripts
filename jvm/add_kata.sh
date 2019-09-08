#!/usr/bin/env bash
#
# Adds a new kata.
# Thanks to: https://github.com/Egga/katas/blob/master/add_module.sh

# If a command fails then do not proceed and fail this script too
set -o errexit
set -o pipedfail

read -rp "Please enter the name: " NAME
echo
export NAME

if [[ -z "${NAME}" ]]; then
  echo 'Name was not entered'
  exit 1
fi

if [[ -d "src/main/kotlin/${NAME}" ]]; then
  echo 'Kata with this name already exist'
  exit 1
fi

cp -r src/main/kotlin/template/ src/main/kotlin/"${NAME}"/
mkdir src/test/kotlin/"${NAME}"/

echo "${NAME} kata was added"
