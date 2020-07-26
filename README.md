# PAGen

Passive Aggressive Generator

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

## Update icon
Change path of png icon under 'flutter_icons' in pubsec.yaml
Run
```
flutter pub run flutter_launcher_icons:main
```
