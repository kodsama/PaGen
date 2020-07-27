# PAGen

Passive Aggressive Generator

## Pipeline setup
The project is running Gitlab-CI to test, build and deploy updates. In order for it to run, at least one gitlab-runner must be set-up with proper software and signing keys.
Please run through these tutorials to set them up:
These steps are based on:
https://medium.com/appditto/automate-your-flutter-workflow-using-gitlab-ci-cd-and-fastlane-5872e758165a

1. Install flutter
https://flutter.dev/docs/get-started/install

2. Install gitlab-CI runner
https://docs.gitlab.com/runner/install/

3. Set-up the Gitlab runner with these parameters:
```
URL: https://gitlab.com/
Registration token: Check the CI setup page on gitlab
Description: Whatever you want
Tag: flutter
Runner type: shell
```

## Compile and test
Go to the project home directory
```
cd /path/to/awesome/project/pagen
```

Start a simulator (here named Pixel_3a_API_30_x86)
```
flutter emulators --launch Pixel_3a_API_30_x86
```

Verify that the simulator (or physical device) is correctly connected
```
flutter devices
```

Verify all is fine with flutter
```
flutter doctor
```

Fetch all dependencies
```
flutter pub get
```

Run in debug mode
```
flutter run
```

## Compile for release
Increment the version name and number in pubspec.yaml:
```
version: 0.0.1+1 => version: 0.0.2+2
```

Build a signed release bundle file
```
flutter build appbundle --release
```

Or release apk:
```
flutter build apk --release
```

For iOS:
```
flutter build ios --release --no-codesign
```


## Update icon
Change path of png icon under 'flutter_icons' in pubsec.yaml
Run
```
flutter pub run flutter_launcher_icons:main
```
