# V172-Q244R3 Camera AndroidX AAR Metadata / AGP 8.3.2 Compatibility Repair

Trigger: user-side `flutter run` failed at `:app:checkDebugAarMetadata` because resolved `androidx.camera:*:1.5.3` artifacts require Android Gradle Plugin 8.6.0 while the project uses AGP 8.3.2.

Repair: pin the Flutter camera dependency to `camera: 0.11.0` and add `dependency_overrides: camera_android_camerax: 0.6.5+2`, which keeps the Q239B camera shell path but prevents the latest CameraX 1.5.3 artifacts from being selected.

No AGP upgrade was performed in this phase. No OCR runtime, Text OCR fallback, PaddleOCR, Pix2Text, ONNX runtime, model binary, model URL, background download worker, MathLive production import, direct solve, Graph, Solution, History, keyboard, MORE, long-press, splash, or launcher icon behavior was added or changed.

Flutter/Android build PASS is not claimed by this package. User-side `flutter clean`, `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run` evidence is still required.
