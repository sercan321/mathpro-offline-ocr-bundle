# V172-Q79 Nested Long Expression Pan Stability Audit Report

## Scope

Q79 is cursor/editor-only. It stabilizes nested SlotBox selection, long-expression caret visibility targets, and viewport pan gestures inside the native SlotBox input surface created by Q71-Q78.

## Runtime changes

- Added `native_nested_long_expression_pan_stability_policy.dart`.
- Wired `native_slotbox_hit_test_policy.dart` to Q79 nested/deepest measured SlotBox resolution after Q77/Q78 family-specific lanes.
- Wired `native_slotbox_input_surface_integration_policy.dart` to expose Q79 pan-stable frame predicates and pan-source suppression.
- Wired `editor_interaction_layer.dart` so pan sources in long/nested SlotBox surfaces do not emit detached linear carets or random structural switches.
- Wired `editor_viewport.dart` so active long/nested visibility targets use native caret rail / inner text geometry instead of detached hitRect approximations.
- Removed a duplicated unreachable `return 230.0;` from the Q78 root-index lane policy.

## Protected surfaces

The following protected visual/product surfaces must remain byte-for-byte unchanged from the Q78 baseline:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/app/app_shell.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`

## Explicit non-claims

Q79 does not claim:

- real Flutter analyze/test/run PASS from the assistant environment,
- real-device cursor +95 PASS,
- full native math renderer completion,
- true AST-slot to SVG-node identity completion,
- Photomath/Wolfram final parity.

## Required user-side court

The next phase is Q80 Real Device Cursor Court. The package must be tested with:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Then nested, long-expression, pan-after-tap, tap-after-pan, integral differential, fraction, root, function and log-slot scenarios must be verified on real hardware.
