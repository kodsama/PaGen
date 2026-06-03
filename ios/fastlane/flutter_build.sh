#!/bin/bash

# Flutter release build helper for Fastlane (see ios/fastlane/Fastfile).

cd ../../
if [ "$1" == "--clean" ]
then
   echo "Running clean..."
   flutter clean
else
   echo "Skipping clean..."
fi
flutter build ios --release --no-codesign