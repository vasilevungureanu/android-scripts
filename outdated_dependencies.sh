#!/usr/bin/env bash
#
# Generates a report with outdated dependencies and send it to Slack.
# https://github.com/hellofresh/deblibs-gradle-plugin
# Tip: You can set a cron on local machine to run this script daily/weekly/whenever automatically.

cd "$(dirname "${BASH_SOURCE[0]}")" || exit

cd .. || exit

./gradlew creatSlackMessage
