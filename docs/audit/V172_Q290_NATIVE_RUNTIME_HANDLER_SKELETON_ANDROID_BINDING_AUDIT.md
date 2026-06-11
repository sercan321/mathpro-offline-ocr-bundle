# V172-Q290 — Native Runtime Handler Skeleton / Android Binding

## Scope

Q290 defines the future PP-FormulaNet-S native runtime handler and Android binding protocol as a static, default-off contract only. It follows Q289, where the runtime dependency trial remained blocked because the real model artifact SHA256, ABI/runtime package, latency, memory, and user-side smoke evidence are not yet complete.

## Decision

The phase reserves a MethodChannel name, a future native handler name, request/response envelopes, error taxonomy, timeout/cancellation policy, memory-pressure policy, and rollback boundary. It does **not** implement Android binding, does **not** modify `MainActivity.kt`, does **not** modify `AndroidManifest.xml`, does **not** add JNI, and does **not** add any Paddle/PaddleOCR runtime dependency.

## Runtime Boundary

- No runtime behavior changed.
- No `pubspec.yaml` runtime dependency was added.
- No Gradle/native dependency was added.
- No model binary was bundled.
- No production URL/download worker was enabled.
- No real image-to-LaTeX inference was executed.
- No OCR PASS, Camera/OCR runtime PASS, store-ready PASS, or release PASS is claimed.

## Review Boundary

Camera/OCR output remains blocked from direct workspace import, direct solve, direct Graph, direct Solution, and direct History. Any future OCR candidate must open editable MathLive review first and must require explicit user approval before workspace import.

## Protected Surfaces

Keyboard, MORE/template tray, long-press lists, MathLive production route, Graph, Solution, History, AppShell, Workspace, Camera shell, AndroidManifest, MainActivity, splash/icon, solver/evaluator, `pubspec.yaml`, camera dependency, and Android toolchain remain unchanged.

## User-side Retest Required

Because this package is produced in a non-Flutter assistant environment, the user must still run:

- `flutter clean`
- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run -d 23106RN0DA`
