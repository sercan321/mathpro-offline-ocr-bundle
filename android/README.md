# Android project note

This package contains the Android project files needed by Flutter tooling, including `MainActivity.kt`, manifest, Gradle build files, and resources.

Run from the project root with Flutter commands:

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

A machine-local `android/local.properties` file is generated/managed by Flutter and Android Studio. It is not committed because it contains your local Flutter/Android SDK paths.

If Android Studio/Flutter asks to regenerate platform scaffolding, run this from the project root and then re-check changed files before accepting overwrites:

```bash
flutter create --platforms=android .
```


## Phase 12 Gradle bootstrap note

This package includes `gradlew`, `gradlew.bat`, and `gradle/wrapper/gradle-wrapper.properties`.
The scripts are lightweight bootstrap delegates: they use a system Gradle when present, otherwise they download Gradle 8.7 into `android/.gradle/` on first Android build.
`android/.gradle/` is intentionally not shipped in the ZIP.
