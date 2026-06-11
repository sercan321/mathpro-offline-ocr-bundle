# MathPro Flutter Phase 3 — Changed Files Manifest

## Added

- `lib/state/calculator_state.dart`
- `lib/state/calculator_actions.dart`
- `lib/state/calculator_controller.dart`
- `lib/logic/key_handlers.dart`
- `lib/logic/action_utils.dart`
- `lib/logic/math_serializer.dart`
- `lib/logic/evaluator_bridge.dart`
- `docs/audit/PHASE3_CHANGED_FILES_MANIFEST.md`
- `docs/audit/PHASE3_TEST_REPORT.md`
- `docs/audit/PHASE3_KEYBOARD_REGRESSION_AUDIT.md`
- `docs/audit/PHASE3_STATE_BEHAVIOR_AUDIT.md`
- `docs/audit/PHASE3_STATIC_VERIFICATION.md`

## Modified

- `README.md`
- `pubspec.yaml`
- `test/widget_test.dart`
- `lib/app/app_shell.dart`
- `lib/features/workspace/workspace_panel.dart`
- `lib/features/workspace/editor_viewport.dart`
- `lib/theme/mathpro_typography.dart`

## Preserved from Phase 2

- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/key_model.dart`
- `lib/features/keyboard/long_press_indicator.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/services/haptics_service.dart`
- Android shell files
- Phase 1 and Phase 2 audit files

## Product decisions intentionally not changed

- Tabs were not merged.
- Keyboard key order was not changed.
- MORE was not renamed.
- Ans was not moved or hidden.
- `↵` was not replaced by `=`.
- `=` was not turned into the evaluation key.
- Empty `null` cells in the reference Kalkülüs layout were not filled cosmetically.
