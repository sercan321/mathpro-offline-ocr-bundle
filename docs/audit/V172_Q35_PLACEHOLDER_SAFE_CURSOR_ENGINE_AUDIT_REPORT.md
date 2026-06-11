# V172-Q35 Placeholder-Safe Cursor Engine Audit Report

## Scope
Q35 is a P6-locked cursor-only phase. It does not change keyboard layout, key faces, MORE, long-press popup, app shell layout, Graph, History, or Solution protected internals.

## Goal
Prevent production caret geometry from being drawn inside/over a visible placeholder box such as `√□`, `x^□`, `x_□`, `log_□(□)`, numerator/denominator placeholders, and limit/index placeholders.

## Implemented
- `DeterministicSlotGeometryRegistry.placeholderSafeCaretEngineAvailable = true`
- `DeterministicSlotGeometryRegistry.placeholderCaretOverlapAllowed = false`
- Added `placeholderSafeCaretRectFor(...)` as the role-aware caret authority for empty structural slots.
- Added `caretOverlapsPlaceholder(...)` for static contract verification and future unit tests.
- `EditorCaretOverlay` now resolves deterministic slot geometry, then uses placeholder-safe caret rects.
- `RenderMappedSlotHitTest.version` now carries the Q35 placeholder-safe geometry lineage marker.

## Red Lines Preserved
The following P6-locked files remained byte-identical to the provided P6 baseline:
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

## Honest Boundary
Q35 is not a final Photomath/Wolfram +95 PASS. It specifically closes the placeholder-overlap class of cursor defects. Real +95 still requires role-size refinement, fraction/script/log/root precision, digit caret stops, drag stability, and physical-device pixel QA.

## Required Device Check
Test on device:
- `√□`
- `x^□`
- `x_□`
- `log_□(□)`
- `a/b`

Expected: caret must sit on a safe optical rail and must not be centered inside the visible placeholder box.
