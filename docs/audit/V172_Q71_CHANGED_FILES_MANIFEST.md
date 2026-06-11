# V172-Q71 Changed Files Manifest

## Runtime cursor/editor files

- `lib/features/formula_engine/native_slotbox_input_surface_policy.dart` — new Q71 cursor law policy.
- `lib/features/formula_engine/slot_hit_testing.dart` — disables nearest fallback selection outside authoritative slot hit rects.
- `lib/features/formula_engine/structural_intent_resolver_policy.dart` — disables structural nearest-bundle guessing and broad template inflation.
- `lib/features/editor/render/editor_interaction_layer.dart` — blocks legacy linear placeholder fallback while SlotGeometryBundle geometry exists.

## Metadata / audit / tests

- `pubspec.yaml`
- `README.md`
- `lib/logic/mathpro_package_contract.dart`
- `tool/verify_mathpro_contract.py`
- `test/v172_q71_native_slotbox_input_surface_foundation_test.dart`
- Existing cursor metadata tests updated from active `0.172.101+172` / Q65R3 to active `0.172.102+172` / Q71 where they pin package identity or next phase.

## Protected files intentionally unchanged

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
