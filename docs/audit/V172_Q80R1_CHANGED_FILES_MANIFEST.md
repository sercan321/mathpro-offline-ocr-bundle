# V172-Q80R1 Changed Files Manifest

Cursor/editor/test/audit-only repair. Protected visual/product surfaces remain unchanged.

## Runtime cursor policy

- `lib/features/formula_engine/existing_cursor_engine_reconciliation_policy.dart`
  - Hard-blocks direct legacy nearest structural hit selection while retaining the compatibility symbol.
- `lib/features/formula_engine/synthetic_tap_intent_matrix_policy.dart`
  - Replaces stale nearest-hit wording with authoritative SlotBox hit wording.

## Metadata / contract / verifier

- `pubspec.yaml`
- `README.md`
- `lib/logic/mathpro_package_contract.dart`
- `tool/verify_mathpro_contract.py`
  - Adds Q78 static verifier gate and updates active version metadata to `0.172.112+172`.

## Audit docs

- `docs/audit/V172_Q80R1_STATIC_CONTRACT_AUDIT_REPAIR_REPORT.md`
- `docs/audit/V172_Q80R1_CHANGED_FILES_MANIFEST.md`

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
