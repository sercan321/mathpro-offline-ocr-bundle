# Phase A Changed Files Manifest

Baseline: `MathProFlutterPhase17_BottomDockFix_FULL.zip`

## Modified product files

- `lib/app/app_shell.dart`
  - Selection toolbar label no longer receives technical slot role text.

- `lib/features/workspace/workspace_panel.dart`
  - Removed the user-facing `Aktif slot: <technical-role>` workspace line.

- `lib/features/workspace/selection_toolbar.dart`
  - Keeps a user-friendly `Aktif alan` label instead of exposing internal slot identifiers.

- `lib/features/editor/render/editor_interaction_layer.dart`
  - Stops painting all slot rectangles.
  - Paints only the active slot as a subtle user-facing highlight.
  - Keeps invisible hit-testing active.

- `lib/features/editor/render/math_render_surface.dart`
  - Uses structural TeX when a slot registry exists.

- `lib/features/editor/tex_serializer.dart`
  - Strengthened structural node-to-TeX serialization for core template nodes.

- `lib/features/formula_engine/slot_hit_testing.dart`
  - Added invisible hit target foundation, minimum finger target, nearest fallback, and priority/depth/distance scoring.

## Modified test file

- `test/widget_test.dart`
  - Updated debug-ban expectations.
  - Added structural TeX regression checks for sqrt/fraction/integral templates.

## Added audit files

- `docs/audit/PHASE_A_CORE_EDITOR_ENGINE_AUDIT.md`
- `docs/audit/PHASE_A_CHANGED_FILES_MANIFEST.md`

## Not modified

- Keyboard layout source.
- Key order.
- Tab names.
- Long-press map.
- `MORE`, `Ans`, `↵`, `=` behavior.
