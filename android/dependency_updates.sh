#!/usr/bin/env bash
#
# Displays a report of the up-to-date project dependencies, exceed the latest version found, have upgrades, or failed to be resolved.
# https://github.com/ben-manes/gradle-versions-plugin

./gradlew dependencyUpdates
