# V172-Q382R33R1 — Analyze and stale test repair

Scope: surgical repair only after user-side `flutter analyze` / `flutter test` evidence.

## Fixed

- Replaced invalid Dart `String(...)` constructor in `mathlive_full_keyboard_warmup_q382r33_policy.dart` with safe `.toString()` conversion.
- Removed unnecessary `package:flutter/foundation.dart` import from `app_shell.dart`.
- Made the debug latency overlay disabled flag `const` to satisfy `prefer_const_declarations`.
- Updated Q239A camera-entry regression to allow the later Q382 expression-context safe-zone `Icons.more_horiz_rounded` successor.
- Reconciled Q382R29/Q382R32 category expectations so function template roots such as `sin` receive the Q382R32 template debounce path while still staying out of tap-down/optimistic echo.

## Not changed

- Keyboard layout/order/labels.
- MORE inventory/order.
- Long-press inventory/order.
- MathLive JS runtime warmup semantics.
- Q382R27 optimistic echo scope.
- OCR/camera runtime, Graph, History, Solution semantics, AndroidManifest, Gradle, MainActivity, splash/icon.
- Pan/drag-scroll.

## Evidence limits

This repair was verified by static verifier chain and JS syntax in the packaging environment. Flutter/Dart were not available in that environment, so user-side `flutter analyze`, `flutter test`, and `flutter run` remain the authoritative evidence.
