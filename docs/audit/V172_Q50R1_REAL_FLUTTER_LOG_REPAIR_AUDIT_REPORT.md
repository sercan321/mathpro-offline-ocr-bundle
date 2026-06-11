# V172-Q50R2 Stale Package Guard Repair Audit Report

## Verdict

CONDITIONAL PASS — Q50R2 repairs the concrete Flutter analyze/test blockers reported from the user's real Windows log while preserving the P6 locked UI boundary. It does not claim real-device +95 PASS.

## Active identity

```yaml
description: MathPro Flutter phase 17 - V172-Q50R2 stale package guard repair.
version: 0.172.80+172
```

## Repaired failures from the user log

- Added `SlotRegistry.fromRoots(List<MathNode>)` compatibility API so Q38 script precision tests can compile.
- Restored the exact V172-K source-contract marker `onTapUp: selectOnTapUp` without changing runtime tap behavior.
- Restored the exact V121 source-contract condition `if (paintVisibleSlotOverlay && canInteractWithSlots)` while keeping visible legacy overlay defaulted off.
- Updated `RenderMappedSlotHitTest.version` to include the required `v172l` lineage marker.
- Repaired digit-run midpoint tie handling so a tap exactly between two digit stops chooses the lower/left caret index expected by Q40.
- Kept the legacy public `MathProCaretController.caretRectForSlot` helper clamped inside the visual slot for Phase-E regression compatibility while production role-aware/native LayoutBox caret paths remain separate.
- Cleared Q50 metadata pinning to Q50R2 in tests/verifier without claiming Flutter/device PASS from the assistant environment.

## Protected P6 files

The following protected UI files were not intentionally modified in Q50R2:

```text
lib/features/keyboard/key_config.dart
lib/features/keyboard/math_keyboard.dart
lib/features/keyboard/bottom_dock.dart
lib/features/keyboard/long_press_popup.dart
lib/features/keyboard/premium_key.dart
lib/features/workspace/math_label.dart
lib/features/workspace/template_tray.dart
lib/app/app_shell.dart
lib/features/solution/solution_steps_panel.dart
lib/features/graph/graph_card.dart
lib/features/history/history_controller.dart
lib/features/history/history_panel.dart
```

## Evidence available in assistant environment

- Static verifier: PASS.
- Zip hygiene scan: PASS after final packaging.
- Protected file comparison against Q50 input: same for all 12 protected UI files.

## Evidence not available in assistant environment

The assistant environment still has no Flutter/Dart executable. Therefore Q50R2 must not be called final PASS until the user runs:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

