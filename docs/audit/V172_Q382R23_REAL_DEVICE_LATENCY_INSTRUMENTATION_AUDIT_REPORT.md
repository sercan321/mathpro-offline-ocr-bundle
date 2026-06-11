# V172-Q382R23 — Real Device Latency Instrumentation Audit Report

## Scope
Q382R23 adds debug-only real-device latency instrumentation for the MathPro keyboard to MathLive production editor path. The phase measures the existing path; it does not optimize or change command behavior.

## Measured timestamps
- `T0`: `PremiumKey` `onTapDown`
- `T1`: `PremiumKey` `onTap`
- `T2`: Dart production MathLive command scheduled
- `T3`: JavaScript production bridge command received
- `T4`: MathLive insert/delete/clear operation started
- `T5`: MathLive insert/delete/clear operation completed
- `T6`: JavaScript state post to Flutter channel
- `T7`: Flutter WebView JavaScript channel state received
- `T8`: AppShell/overlay next frame painted

## Debug overlay
A small transparent overlay is mounted in the top-right corner through `MathProLatencyOverlayQ382R23`. It is wrapped in a `kDebugMode` guard and uses `IgnorePointer`, so it does not intercept touches. Release builds do not show the overlay.

## Terminal evidence
When a span reaches `T8`, the probe emits a debug line with the marker `[Q382R23_LATENCY]`. This lets the user send `flutter run` logs with actual device-side latency segments.

## Preserved behavior
- Keyboard layout/order/labels remain unchanged.
- Command dispatch remains `onTap`; no `onTapDown` insert path was introduced.
- Long-press lists and MORE/template tray are untouched.
- MathLive production command semantics are preserved.
- Serial production command queue and timeout are preserved.
- Q382R19 state-push budget is preserved.
- Q382R22 runtime payload slimming is preserved.
- Graph, Solution, Result, History, OCR/Camera, Android/Kotlin, Gradle, splash/icon, and solver semantics are untouched.
- Q382R13/Q382R14/Q382R16 pan experiments were not reintroduced.

## Honest boundary
This phase does not claim improved latency. It only exposes measurement. Flutter analyze/test/run and real-device measurements must be produced on the user's local Flutter SDK and Android device.

## Q382R23R1 Analyzer Repair Note

- Replaced invalid Dart `String(...)` constructor-style conversions in `mathpro_latency_probe_q382r23.dart` with `.toString()` conversions.
- Removed unnecessary `dart:ui` import from `mathpro_latency_overlay_q382r23.dart`.
- No performance behavior, keyboard layout, MathLive command semantics, Graph, Solution, OCR, History, Android/Kotlin, or runtime optimization behavior was changed.

