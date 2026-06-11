# V172-Q244R4 Camera Android Camera2 Compatibility Repair

User-side `flutter run` after Q244R3 failed in `:app:compileDebugKotlin` because the CameraX path still introduced Kotlin 2.1 metadata artifacts while the project compiler remained Kotlin 1.9.22.

Q244R4 keeps `camera: 0.11.0` but opts back into the legacy Camera2 Android implementation with `camera_android: 0.10.8+18`, and removes the `camera_android_camerax` override entirely. This avoids the CameraX/Kotlin 2.1 artifact path without performing a broad Android Gradle Plugin or Kotlin plugin upgrade.

No OCR runtime, model binary, model URL, MathLive production import, direct solve, keyboard, MORE, long-press, Graph, Solution, History, splash, or launcher icon behavior is changed.
