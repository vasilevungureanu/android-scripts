#!/usr/bin/env bash
#
# Running this script will:
# * Install all git hooks.
# * Install shellcheck.
# * Install ktlint.
# * Configure Kotlin Style.

# If a command fails then do not proceed and fail this script too
set -o errexit
set -o pipefail

echo 'Starting bootstrap process'

echo 'Install all current git hooks'
rm -f .git/hooks/*

cp githooks/pre-push.sh .git/hooks/pre-push
chmod +x .git/hooks/pre-push

cp githooks/post-merge.sh .git/hooks/post-merge
chmod +x .git/hooks/post-merge

cp githooks/prepare-commit-msg.sh .git/hooks/prepare-commit-msg
chmod +x .git/hooks/prepare-commit-msg

cp githooks/commit-msg .git/hooks/commit-msg
chmod +x .git/hooks/commit-msg

echo 'Installing shellcheck'
if [[ "${OSTYPE}" == "linux-gnu" ]]; then
  sudo apt-get install shellcheck
elif [[ "${OSTYPE}" == "darwin"* ]]; then
  brew install shellcheck 2>/dev/null && true
fi

echo 'Installing ktlint'
curl -sSLO https://github.com/pinterest/ktlint/releases/download/0.35.0/ktlint &&
  chmod a+x ktlint &&
  sudo mv ktlint /usr/local/bin/

echo 'Configuring Kotlin Style'
ktlint --apply-to-idea-project -y

echo 'Bootstrap process completed'
