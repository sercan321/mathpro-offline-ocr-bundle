# V172-Q382R19 — MathLive Keyboard Insertion Mode + State Push Budget Audit

Q382R19 reduces redundant JS -> Flutter state pushes during normal MathPro keyboard insertion without changing the serial WebView command queue, `androidBridgeCommandTimeout`, native MathLive caret authority, slot/template behavior, keyboard layout, MORE, Graph, Solution, OCR/Camera, Android/Kotlin, Gradle, solver, splash/icon, or app startup.

## What changed

`assets/mathlive/mathlive_prod_bridge.js` now has a narrow `V172-Q382R19` keyboard insertion mode. Normal keyboard commands (`insertLatex`, `deleteBackward`, `clear`) enter a short state-push budget window:

- one canonical `notifyFlutterState(...)` from `completeCommand(...)`
- one short 16 ms settle caret push
- no 80 ms command caret push on the keyboard insertion branch
- native `input` / `selection-change` / `keydown` caret push floods are coalesced while the insertion budget is active

Pointer/tap/selection caret paths outside keyboard insertion keep the previous caret-state push behavior.

## What did not change

- Serial Dart production command tail remains intact.
- `androidBridgeCommandTimeout` remains intact.
- No `runJavaScriptReturningResult` or awaited Flutter state echo was reintroduced.
- No legacy Flutter cursor path was reintroduced.
- No Q382R13/Q382R14/Q382R16 pan/scroll experiment code was reintroduced.

## Honest limits

This package was verified by static verifier scripts and JavaScript syntax checks in this environment. Flutter SDK and a real Android device were not available here, so `flutter analyze`, `flutter test`, `flutter run`, and real-device latency PASS are not claimed by this audit.
