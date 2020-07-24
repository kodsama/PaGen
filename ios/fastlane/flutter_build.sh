#!/bin/bash

# Based on:
# https://medium.com/appditto/automate-your-flutter-workflow-using-gitlab-ci-cd-and-fastlane-5872e758165a

cd ../../
if [ "$1" == "--clean" ]
then
   echo "Running clean..."
   flutter clean
else
   echo "Skipping clean..."
fi
flutter build ios --release --no-codesign