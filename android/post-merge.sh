#!/usr/bin/env bash
#
# Distribute 4Suites Debug build on predefined list of emails.

( ./gradlew assembleFourSuitesDebug crashlyticsUploadDistributionFourSuitesDebug; ) > /dev/null 2>&1 &