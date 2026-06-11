# ELITE PREMIUM PLUS V57 — DEVICE FIT + PERFORMANCE REGRESSION REPAIR AUDIT

## Status

V57 is a UI-only stabilization/performance phase based on V56. No solver/CAS/solution engine expansion was added.

## Runtime changes

- `lib/app/app_shell.dart`
  - Replaced explicit workspace height allocation with an `Expanded` workspace region so the keyboard dock and workspace cannot exceed the available viewport through fractional rounding.
  - Shortened workspace/dock/fullscreen transition durations to reduce jank risk.

- `lib/features/workspace/workspace_panel.dart`
  - Added a guarded layout budget (`maxHeight - 1.5`) for nested panel allocation.
  - Graph, Template Tray and Solution Steps height calculations now allocate from the guarded budget while preserving the full outer slot.

- `lib/features/keyboard/bottom_dock.dart`
  - Dock target height is snapped down with `floorToDouble()` to prevent sub-pixel overflow at locked device sizes.
  - Tab chip animation duration reduced from 150ms to 120ms.

- `lib/features/solution/solution_steps_panel.dart`
  - Reduced panel/control motion durations.
  - Added `cacheExtent` to the steps list.
  - Added RepaintBoundary around step cards.
  - Disabled per-card entrance animation when there are more than six steps to avoid long-list jank.

- `lib/features/graph/graph_painter.dart`
  - Reduced non-compact preview sampling from 420 to 320 points. This is a preview performance pass, not a graph-feature change.

## Protected areas

The following were not intentionally changed:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- keyboard topology
- tab order
- MORE / Ans / = / ↵ behavior
- long-press option lists
- solver/CAS logic
- `lib/logic/evaluator_bridge.dart`
- `lib/features/solution/solution_step_models.dart`

## Local verification required

Flutter/Dart is not available in the packaging environment, so no local Flutter PASS is claimed. Run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Expected result

- No layout overflow on short device profiles.
- MORE / Steps / History / Graph panel switching remains visually clean.
- Keyboard remains visually premium and contract-stable.
- UI transitions are lighter and better aligned with 60 FPS target.
