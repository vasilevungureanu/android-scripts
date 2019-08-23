#!/usr/bin/env bash
#
# Running this script will:
# * Remove all current git hooks.
# * Install pre-push git hook.
# * Install post-merge git hook.
# * Install prepare-commit-msg git hook.
# * Install commit-msg git hook.
# * Install shellcheck.
# * Install ktlint.
# * Configure Android Kotlin Style.

# If a command fails then do not proceed and fail this script too
set -o errexit
set -o pipefail

echo 'Starting bootstrap process'

echo 'Removing all current git hooks'
rm -f .git/hooks/*
 
echo 'Installing pre-push git hook'
cp quality/quality.sh .git/hooks/pre-push
chmod +x .git/hooks/pre-push

echo 'Installing post-merge git hook'
cp git/hooks/post-merge.sh .git/hooks/post-merge
chmod +x .git/hooks/post-merge

echo 'Installing prepare-commit-msg git hook'
cp git/hooks/prepare-commit-msg.sh .git/hooks/prepare-commit-msg
chmod +x .git/hooks/prepare-commit-msg

echo 'Installing commit-msg git hook'
cp git/hooks/commit-msg .git/hooks/commit-msg
chmod +x .git/hooks/commit-msg

echo 'Installing shellcheck'
if [[ "${OSTYPE}" == "linux-gnu" ]];
  then
    sudo apt-get install shellcheck
elif [[ "${OSTYPE}" == "darwin"* ]];
  then
    brew install shellcheck
fi

printf "Installing ktlint"
curl -sSLO https://github.com/shyiko/ktlint/releases/download/0.33.0/ktlint &&
  chmod a+x ktlint &&
  sudo mv ktlint /usr/local/bin/

echo 'Configuring Android Kotlin Style'
ktlint --apply-to-idea-project --android -y

echo 'Bootstrap process completed'