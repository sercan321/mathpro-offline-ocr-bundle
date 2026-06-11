# V172-Q75 Changed Files Manifest

Phase: V172-Q75 Native Structural Edit Transaction Binding  
Active version: 0.172.106+172

## Runtime / cursor-editor files

- `lib/features/formula_engine/native_structural_edit_transaction_binding_policy.dart`
  - Adds the Q75 structural edit binding law: active SlotBox id must remain the edit target for insert/delete/replace operations.
  - Keeps eligible single-slot function/log/root/fraction payloads structurally active after first character instead of exiting to detached linear caret.
- `lib/state/calculator_controller.dart`
  - Wires insert/replace/backspace flows to `NativeStructuralEditTransactionBindingPolicy`.
  - Preserves Q43 slot-scoped edit lineage while changing transaction source labels to Q75 for active structural binding evidence.
- `lib/features/formula_engine/native_exclusive_placeholder_caret_renderer_policy.dart`
  - Restores/includes the Q74 exclusive `|□` caret renderer because the incoming archive was still Q73-tagged.
- `lib/features/formula_engine/native_slotbox_painter_policy.dart`
  - Routes empty-slot paint models through the Q74 exclusive caret renderer.
- `lib/features/workspace/editor_caret_overlay.dart`
  - Routes active empty structural slot carets through the Q74 exclusive renderer before final paint.

## Metadata / contract / verifier

- `pubspec.yaml`
  - Advanced to `0.172.106+172` / V172-Q75.
- `README.md`
  - Advanced to V172-Q75 and documents honest limits.
- `lib/logic/mathpro_package_contract.dart`
  - Adds Q74/Q75 lineage and Q75 active contract.
- `tool/verify_mathpro_contract.py`
  - Adds Q74 and Q75 static contract gates and updates active package metadata checks.
- `tool/verify_mathpro_contract_report.json`
- `tool/verify_mathpro_contract_report.md`
  - Regenerated after final static verification.

## Tests

- `test/v172_q74_native_exclusive_caret_renderer_test.dart`
  - New Q74 regression test for exclusive empty-slot `|□` rendering.
- `test/v172_q75_native_structural_edit_transaction_binding_test.dart`
  - New Q75 regression test for structural focus retention after single-slot function insertion and filled fraction edit insertion.
- Existing V172 cursor tests were updated only where they pinned active package metadata from Q73/Q74 to Q75/Q76.

## Protected files

The following protected UI/keyboard files were compared against the incoming ZIP and remained byte-for-byte identical:

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
