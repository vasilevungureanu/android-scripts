#!/usr/bin/env bash
#
# Distributes the 4Suites Debug build on a predefined list of emails.

(./gradlew assembleFourSuitesDebug crashlyticsUploadDistributionFourSuitesDebug) >/dev/null 2>&1 &
