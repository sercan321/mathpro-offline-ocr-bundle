# V172-Q76 Changed Files Manifest

Active package: `0.172.107+172`

## Runtime cursor/editor files

- `lib/features/formula_engine/native_slotbox_input_surface_integration_policy.dart`
  - Adds the Q76 native input surface frame. It centralizes editor SlotBox runtime geometry so hit-test, fallback suppression, overlay geometry, and structural edit routing read the same `SlotGeometryBundle` map.
- `lib/features/editor/render/editor_interaction_layer.dart`
  - Replaces ad-hoc per-method geometry construction with `NativeSlotBoxInputSurfaceIntegrationPolicy.buildFrame(...)`.
  - Keeps structural hit-test, legacy placeholder fallback blocking, detached linear fallback blocking, and active overlay rects tied to that single frame.

## Metadata, tests, and static verifier

- `pubspec.yaml`
- `README.md`
- `lib/logic/mathpro_package_contract.dart`
- `test/v172_q76_native_input_surface_integration_test.dart`
- Existing cursor lineage tests updated only to the active Q76 package identity / Q77 next-phase metadata so stale metadata gates remain honest.
- `tool/verify_mathpro_contract.py`
  - Adds Q76 gate.
  - Updates legacy Q55/Q73 checks so the new single input surface frame remains accepted as the location where SlotGeometryBundle hit-test construction now lives.

## Protected UI surfaces

The following protected files were intentionally not edited in Q76:

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

## Honest limit

Q76 does not claim Flutter analyze/test/run PASS, full native math renderer completion, true AST-slot-to-SVG identity, real-device +95 cursor PASS, or Photomath/Wolfram parity. Those remain evidence-gated.
