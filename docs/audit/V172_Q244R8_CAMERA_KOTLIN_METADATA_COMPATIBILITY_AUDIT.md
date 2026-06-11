# V172-Q244R8 Camera Kotlin Metadata Compatibility Audit

## Trigger

User-side `flutter run -d 23106RN0DA` failed at `:app:compileDebugKotlin` because Kotlin 2.1 metadata artifacts were resolved while the project still used Kotlin Gradle plugin 1.9.22.

## Surgical repair

- `android/settings.gradle` Kotlin Gradle plugin was changed from `1.9.22` to `2.1.0`.
- Android Gradle Plugin remains `8.3.2`; no AGP 8.6 upgrade was performed.
- Q244R6 camera dependency line remains `camera: 0.10.6` plus `camera_android: 0.10.9+3`.
- CameraX remains excluded from pubspec.

## Non-goals / unchanged areas

No keyboard, MORE, long-press, MathLive production route, Graph, Result, Solution, History, splash, launcher icon, AppShell, MainActivity runtime, camera UI, OCR runtime, model binary, production model URL, background worker, direct solve, direct Graph, direct Solution, or direct History write was introduced or modified by this phase.

## Honest boundary

Assistant-side Flutter/Dart/Android build was not available, so `flutter analyze`, `flutter test`, and `flutter run` PASS are not claimed. User-side retest is required.
