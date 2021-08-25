#!/usr/bin/env bash
#
# Displays a report of the project dependencies that have known, published vulnerabilities.
# https://github.com/jeremylong/dependency-check-gradle

./gradlew dependencyCheckAnalyze
