# V172-Q205 MathLive-Only Main Editor Physical Cleanup Audit Report

Status: STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED.

## Scope

Q205 physically retires the production Flutter legacy expression editor route after import/dependency inventory. MathLiveProductionEditorSurface is the only production expression editor authority.

## Removed legacy artifacts

- lib/features/workspace/editor_viewport.dart
- lib/features/workspace/editor_caret_overlay.dart
- lib/features/editor/render/mathjax_render_surface.dart
- lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart
- assets/mathjax/tex-svg.js

## Retained intentionally

- AST/node/serializer/template core files needed by keyboard mapping, Graph, History, Solution or historical contracts.
- flutter_math_fork dependency because non-editor math labels/results/solution/graph/history render surfaces still use MathRenderSurface.

## Protected surface

Keyboard layout, MORE, long-press, BottomDock, PremiumKey, Graph UI, History UI and Solution UI files are unchanged by Q205.

## Honest boundary

No Flutter analyze/test/run PASS or Android/Premium/Caret PASS is claimed by this package.
