# MathPro V65 — Changed Files Manifest

## Runtime

1. `lib/features/formula_engine/real_device_slot_test_protocol.dart`
   - Updated protocol version to `mathpro-v65-real-device-interaction-lock-protocol`.
   - Added user-reported manual acceptance scenarios for raw boxes, partially filled derivative argument slots, plain caret midpoint navigation, and slot auto-advance.

2. `lib/features/formula_engine/slot_engine_self_check.dart`
   - Updated self-check version to `mathpro-v65-editor-interaction-lock-self-check`.
   - Added `9□ = □; □ = □` and `d/dx(88□)` to structural smoke expressions.

## Tests

3. `test/core_editor_regression_test.dart`
   - Updated protocol version expectation.
   - Added mandatory V65 scenario IDs to the real-device evidence lock.
   - Added render-mapped raw box and derivative/caret algorithm regression checks.

## Project metadata

4. `pubspec.yaml`
   - Version updated to `0.65.0+65`.

5. `README.md`
   - Added V65 interaction-lock summary.
