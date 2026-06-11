# MathPro Final Repair V3 — Changed Files Manifest

Changed files:

- `lib/features/workspace/workspace_panel.dart`
  - Fixed overflow-safe editor/tray/result height allocation.

- `lib/features/keyboard/bottom_dock.dart`
  - Reduced keyboard total height.
  - Hardened Android navigation/gesture inset guard.

- `lib/features/keyboard/math_keyboard.dart`
  - Reduced vertical row gaps from 8 dp to 6 dp.

- `lib/features/keyboard/long_press_popup.dart`
  - Increased popup/chip envelope to avoid clipping bounded integral glyph.

- `lib/features/workspace/math_label.dart`
  - Enlarged bounded integral glyph chip envelope.

- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
  - Increased function argument hit target/slop.

- `lib/features/editor/slot_registry.dart`
  - Increased functionArgument minTouchSize and visible normalized target area.

- `lib/features/formula_engine/slot_priority_policy.dart`
  - Increased functionArgument priority and tie-break order.

- `android/gradlew.bat`
  - Hardened JAVA_HOME quote/malformed-value fallback.

Added audit files:

- `docs/audit/FINAL_REPAIR_V3_LAYOUT_GRADLE_AUDIT.md`
- `docs/audit/FINAL_REPAIR_V3_CHANGED_FILES_MANIFEST.md`
- `docs/audit/FINAL_REPAIR_V3_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/FINAL_REPAIR_V3_STATIC_CHECK.txt`
