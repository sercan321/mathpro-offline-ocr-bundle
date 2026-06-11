# V172-Q382R1 — Workspace Context Menu Risk Repair Audit

## Scope
Q382R1 is a surgical risk repair on top of Q382. It does not add a new solver, does not change keyboard/MORE/long-press/OCR/Graph/History behavior, and does not modify MathLive production HTML/JS bridge assets.

## Repairs
- Guarded Q382 floating context menu `OverlayEntry.remove()` with `removeEntryOnce()` so outside tap/action selection/dismiss paths cannot double-remove the same entry.
- Rebalanced Q382 menu height calculation so `maxHeight` is never larger than the computed safe-area height.
- Preserved Q382 internal scroll, safe hit-zone, selected action chip, edit actions, semantic action intent shell, and no-fake-solver contract.
- Preserved Q381R1 OCR runtime safety and review-first import boundaries.

## Non-goals
- No fake factor/simplify/roots/türev/integral result.
- No keyboard/MORE/long-press layout changes.
- No OCR runtime/camera/native bridge changes.
- No Graph/Solution/History panel redesign.
- No Gradle/pubspec/AndroidManifest changes.
- No ONNX model bundling.

## Evidence expected before runtime PASS
Flutter/Android SDK is required for `flutter analyze`, `flutter test`, and real-device UI verification. Static verifier PASS is not a real-device PASS.
