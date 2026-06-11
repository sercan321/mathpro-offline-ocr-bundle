# V172-Q73 Changed Files Manifest

Phase: V172-Q73 Native SlotBox Hit-Test Engine  
Version: 0.172.104+172

## Runtime cursor/editor files changed

- `lib/features/formula_engine/native_slotbox_hit_test_policy.dart`
  - Adds the Q73 native SlotBox hit-test authority.
  - Structural slot selection is allowed only through authoritative `SlotGeometryBundle.hitRect` hits.
  - Nearest-distance structural fallback remains disabled.
  - Overlapping measured hitRects use deterministic role/depth/geometry tie-breaks.

- `lib/features/editor/render/editor_interaction_layer.dart`
  - Routes structural taps through `NativeSlotBoxHitTestPolicy.hitTest(...)` when SlotGeometryBundle data exists.
  - Allows legacy visual hit-test only when no geometry bundles exist.
  - Blocks linear fallback inside measured structural hitRects.

- `lib/features/formula_engine/existing_cursor_engine_reconciliation_policy.dart`
  - Prevents the old `nearestStructuralHit(...)` reconciliation path from running in the active Q73 geometry pipeline.
  - Keeps the method for historical tests but no longer uses it when structural geometry is present.

- `lib/features/formula_engine/structural_intent_resolver_policy.dart`
  - Delegates exact bundle resolution to the Q73 native SlotBox hit-test policy.

- `lib/features/formula_engine/slot_hit_testing.dart`
  - Adds Q73 metadata that authoritative bundle hit-test is preferred over legacy visual-rect reconstruction.

## Metadata / tests / audit files changed

- `pubspec.yaml`
- `README.md`
- `lib/logic/mathpro_package_contract.dart`
- `tool/verify_mathpro_contract.py`
- `test/v172_q73_native_slotbox_hit_test_engine_test.dart`
- Active metadata assertions in older cursor tests updated to Q73 / `0.172.104+172`.
- `docs/audit/V172_Q73_NATIVE_SLOTBOX_HIT_TEST_ENGINE_AUDIT_REPORT.md`
- `docs/audit/V172_Q73_CHANGED_FILES_MANIFEST.md`

## Protected UI files intentionally unchanged

The following files must remain byte-for-byte identical to the Q72 baseline:

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

Q73 is a static/runtime-code hardening phase. It does not claim Flutter analyze/test/run PASS or real-device +95 cursor PASS from the assistant environment.
