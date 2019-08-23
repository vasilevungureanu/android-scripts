#!/usr/bin/env bash
#
# Running this script will:
# * Install Jekyll and bundle gems.
# * Install missing gems.

# If a command fails then do not proceed and fail this script too
set -o errexit
set -o pipefail

echo 'Starting bootstrap process'

echo 'Installing Jekyll and bundle gems'
gem install jekyll bundler

echo 'Installing missing gems'
bundle install

echo 'Bootstrap process completed'
