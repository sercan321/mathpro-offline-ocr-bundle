# MathPro V65 — Real Device Regression + Interaction Lock Audit

## Scope

V65 is an editor interaction lock phase after V62, V63, and V64. It does not add solver/CAS, camera, handwriting, keyboard layout changes, or solution panel changes.

## Locked interaction targets

- `9□ = □; □ = □` raw placeholder equation must expose four addressable touch targets.
- `d/dx(88□)` must preserve the derivative/function argument slot as a structural target.
- `8955` plain text caret navigation must support midpoint-based insertion positions.
- Template slot auto-advance after filling open placeholders remains part of the manual acceptance gate.
- Photomath-level/editor PASS cannot be claimed without real-device evidence.

## Runtime files changed

- `lib/features/formula_engine/real_device_slot_test_protocol.dart`
- `lib/features/formula_engine/slot_engine_self_check.dart`

## Test files changed

- `test/core_editor_regression_test.dart`

## Runtime files intentionally not changed

- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/logic/evaluator_bridge.dart`
- `lib/features/solution/solution_step_models.dart`

## Verification status

Local Flutter/Dart commands were not available in the assistant container, so no `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.

Required user-side verification:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Manual acceptance remains 9/10 correct selections per scenario on the physical device.
