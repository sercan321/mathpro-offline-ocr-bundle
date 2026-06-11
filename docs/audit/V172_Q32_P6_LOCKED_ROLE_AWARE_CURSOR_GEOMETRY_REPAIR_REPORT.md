# V172-Q32 P6 Locked Role-Aware Cursor Geometry Repair

Purpose: fix real-device cursor placement reported in root/template placeholders while preserving P6 keyboard, MORE, long-press, layout, Graph, History and Solution surfaces.

Changed production files are restricted to cursor/render metadata:
- lib/features/editor/render/mathjax_render_surface.dart
- lib/features/editor/selection_controller.dart
- lib/features/workspace/editor_caret_overlay.dart
- lib/features/formula_engine/premium_cursor_visual_polish_policy.dart
- lib/logic/mathpro_package_contract.dart

Locked P6 visual files must remain byte-identical:
- lib/features/keyboard/key_config.dart
- lib/features/keyboard/math_keyboard.dart
- lib/features/keyboard/bottom_dock.dart
- lib/features/keyboard/long_press_popup.dart
- lib/features/keyboard/premium_key.dart
- lib/features/workspace/math_label.dart
- lib/features/workspace/template_tray.dart
- lib/app/app_shell.dart
- lib/features/solution/solution_steps_panel.dart
- lib/features/graph/graph_card.dart
- lib/features/history/history_controller.dart
- lib/features/history/history_panel.dart

Q32 changes:
- Empty structural slot cursor is placed at the optical edge of the placeholder instead of inside the visible box.
- Script-like roles such as powerExponent, subscript, logBase, rootIndex and limits use smaller role-aware caret heights.
- P6 UI remains locked; no keyboard visual/layout/MORE/long-press changes are included.

Limitations:
- This is a role-aware caret geometry repair, not a full Photomath/Wolfram per-glyph renderer engine.
- Final PASS still requires real-device screenshots/video and Flutter analyze/test logs.
