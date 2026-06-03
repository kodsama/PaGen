<p align="center">
  <img src="assets/images/trollface.png" alt="PAGen logo" width="160"/>
</p>

<h1 align="center">PAGen</h1>

<p align="center">
  <strong>Passive Aggressive Generator</strong><br/>
  A playful Flutter app that serves up passive‑aggressive quotes on demand.
</p>

<p align="center">
  <img alt="Flutter" src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white"/>
  <img alt="Dart" src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white"/>
  <img alt="License" src="https://img.shields.io/badge/License-GPLv3-blue.svg"/>
</p>

---

## About

PAGen is a small cross‑platform Flutter application that generates passive‑aggressive
quotes ("notes") you can throw at the world. You pick how *aggressive* you feel with a
slider, optionally choose a frustration theme (Kitchen, Laundry, Public…), and tap the
troll face to get a fresh note. You can also rate notes (👍 / 👎) and add your own.

Quotes are stored locally in an on‑device SQLite database that is seeded from a bundled
asset on first launch. The UI is localized (English, French, Swedish).

### Features

- 🎚️ **Passive ↔ Aggressive slider** to tune the tone of generated notes.
- 🗂️ **Themes** to target a specific frustration source.
- ✍️ **Add your own quotes**, persisted locally.
- 👍 **Rate quotes** up or down.
- 🌍 **Localized** in English, French and Swedish.
- 📱 **Runs everywhere Flutter does** — Android, iOS, web, macOS, Linux and Windows.

## Tech stack

| Concern        | Choice                                                       |
| -------------- | ------------------------------------------------------------ |
| Framework      | [Flutter](https://flutter.dev) (stable, Dart 3, null‑safe)   |
| Local storage  | [`sqflite`](https://pub.dev/packages/sqflite)                |
| Localization   | [`flutter_i18n`](https://pub.dev/packages/flutter_i18n)      |
| Preferences    | [`shared_preferences`](https://pub.dev/packages/shared_preferences) |
| Logging        | [`logger`](https://pub.dev/packages/logger)                  |
| Onboarding     | [`introduction_screen`](https://pub.dev/packages/introduction_screen) |

## Project structure

```
lib/
├── main.dart            # App entry point, theme and localization setup
├── states.dart          # Shared app state (InheritedWidget) + quote selection
├── db_helper.dart       # SQLite access layer
├── models/
│   └── quote.dart       # QuoteModel data class
├── screens/             # Full‑page screens (splash, onboarding, home, add quote)
├── widgets/             # Reusable UI pieces (app bar, drawer, slider, settings…)
└── utils/
    └── app_logger.dart  # Central app logger
assets/
├── init_quotes.db       # Seed database bundled with the app
├── images/              # Logo and onboarding images
└── locales/             # i18n translation files (en, fr, sv)
```

## Getting started

### Prerequisites

1. Install the Flutter SDK (stable channel, Dart 3) — see the
   [official guide](https://flutter.dev/docs/get-started/install).
2. Verify your toolchain:

```bash
flutter doctor -v
```

### Run the app

```bash
# Fetch dependencies
flutter pub get

# (Optional) list available devices / emulators
flutter devices

# Run in debug mode on the connected device
flutter run
```

### Run tests and static analysis

Run the full CI pipeline locally (format check, analyze, tests, dependency audit):

```bash
./tool/ci.sh
```

Individual steps:

```bash
flutter pub get
dart format --output=none --set-exit-if-changed lib test
dart analyze --fatal-infos
flutter test
```

## Building for release

Bump the version (`version: x.y.z+build`) in `pubspec.yaml` before each release.

```bash
# Android
flutter build appbundle --release   # Play Store bundle
flutter build apk --release         # standalone APK

# iOS (signing handled by Xcode / CI)
flutter build ios --release --no-codesign

# Web
flutter build web --release
```

## Updating the app icon

The launcher icon is generated from `assets/images/trollface.png` via
[`flutter_launcher_icons`](https://pub.dev/packages/flutter_launcher_icons).
After changing `image_path` under `flutter_launcher_icons` in `pubspec.yaml`, run:

```bash
dart run flutter_launcher_icons
```

## Continuous integration

CI runs on [GitHub Actions](https://github.com/features/actions).

### Checks (every push and PR to `main`)

Workflow: [`.github/workflows/ci.yml`](.github/workflows/ci.yml)

- Dependency install, format check, static analysis, and tests
- Same steps as [`tool/ci.sh`](tool/ci.sh) — run that script locally before pushing

### Android release builds and Play Store deploy

Workflow: [`.github/workflows/release-android.yml`](.github/workflows/release-android.yml)

Triggered manually from the GitHub **Actions** tab (**Run workflow**). Choose **none** to build
only and download APK/AAB artifacts from the run; pick a Play Store track to deploy after the
build.

Configure these [repository secrets](https://docs.github.com/en/actions/security-guides/using-secrets-in-github-actions):

| Secret | Purpose |
| ------ | ------- |
| `ANDROID_KEYSTORE_BASE64` | Release keystore file, base64-encoded |
| `ANDROID_KEY_STORE_PASSWORD` | Keystore password |
| `ANDROID_KEY_PASSWORD` | Key password |
| `ANDROID_KEY_ALIAS` | Key alias |
| `PLAY_STORE_JSON_KEY` | Google Play service account JSON (for deploy only) |

Build and upload use Fastlane lanes in [`android/fastlane`](android/fastlane) (`build_android`,
`deploy_android`).

## License

This project is licensed under the **GNU General Public License v3.0**.
See the [LICENSE](LICENSE) file for the full text.
