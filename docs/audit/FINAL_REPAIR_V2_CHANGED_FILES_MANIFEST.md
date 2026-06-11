# MathPro Final Repair V2 — Changed Files Manifest

Changed files:

- `lib/features/keyboard/bottom_dock.dart`
  - Added robust bottom safe inset using `viewPadding`, `padding`, `systemGestureInsets`, and strict fallback guard.
  - Dock background changed to app background to make safe area visually clean.

- `lib/features/keyboard/long_press_popup.dart`
  - Increased popup vertical envelope and chip minimum height.
  - Prevents bounded integral glyph clipping in long-press popup.

- `lib/features/workspace/math_label.dart`
  - Rebuilt `∫ₐᵇ` custom glyph with larger non-clipped stack and limit boxes.

- `lib/features/editor/slot_registry.dart`
  - Enlarged `functionArgument` target profile for `tan(□)`, `sin(□)`, `cos(□)`, etc.

- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
  - Promoted function argument slots to 66 px minimum touch target and larger slop.

- `lib/features/formula_engine/slot_priority_policy.dart`
  - Added function argument priority bonus and improved tie-break ordering.

- `lib/features/workspace/editor_viewport.dart`
  - Increased viewport/canvas/render envelope for less cramped editor surface.

- `lib/features/workspace/workspace_panel.dart`
  - Increased workspace share allocated to editor.

- `lib/features/formula_engine/real_device_slot_test_protocol.dart`
  - Removed stale user-facing reference to old history area from manual audit text.

- `test/core_editor_regression_test.dart`
  - Added regression contract for `tan(□)` function argument target size.

- `test/widget_test.dart`
  - Kept no-drawer assertion with neutral wording.

- `README.md`
  - Removed wording that made the old removed surface sound like a current runtime feature.
