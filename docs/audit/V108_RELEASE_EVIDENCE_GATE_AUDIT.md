# V108 — Release Evidence Gate + Real-Device QA Hardening Audit

## Scope

V108 does not add solver/CAS features and does not redesign the keyboard, graph, history, or solution panel.  Its purpose is to lock the release evidence contract in code so a future MathPro report cannot claim real-device PASS without the exact logs, screenshots, videos, and manual scenarios that expose the recurring P0 failures.

## Why this phase exists

Earlier phases repeatedly reached clean-looking static/code states while real Android screenshots still showed cursor, slot, log, limit, sum/product, popup clipping, and MORE-chip defects.  V108 hardens the process around those failures.  A release can only call itself real-device-ready when the following evidence exists:

- `flutter pub get` log
- `flutter analyze` log
- `flutter test` log
- `flutter run -d 23106RN0DA` launch evidence
- Screen recording for filled fraction edit/delete
- Screen recording for log-base editing
- Screen recording for limit variable/target/body slots
- Screen recording for sum/product/series overlay behavior
- Screen recording for long nested cursor/pan behavior
- Screen recording for long-press popup clipping scan
- Screen recording for full MORE-panel scan
- Keyboard contract screenshot

## Added code

- `lib/logic/mathpro_release_evidence_gate.dart`
- `test/v108_release_evidence_gate_test.dart`

## Critical scenarios locked

1. `fraction-filled-edit-delete`
2. `log-base-filled-edit`
3. `limit-variable-target-body`
4. `sum-product-series-slot-overlay`
5. `long-nested-cursor-pan`
6. `longpress-popup-no-clipping`
7. `more-panel-full-scan`
8. `keyboard-contract-visual-lock`

## Contract preservation

V108 does not edit the sacred keyboard layout files, graph card, history panel, solution panel, or long-press map/content.  The added gate references these contracts indirectly through existing V107 regression gate and V93 real-device readiness gate.

## Truth statement

No real device was run by this package generation step.  This audit is a release-evidence hardening record, not a PASS certificate.  PASS remains forbidden until the user runs the Flutter commands and supplies the physical-device evidence.
