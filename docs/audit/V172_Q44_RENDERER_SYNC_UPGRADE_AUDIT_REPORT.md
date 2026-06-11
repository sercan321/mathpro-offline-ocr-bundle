# V172-Q44 Renderer-Sync Upgrade Audit Report

Outcome: CONDITIONAL PASS (static/source verification only).

Q44 keeps the P6 keyboard, key faces, MORE tray, long-press popup, app shell, MathLabel, Solution, Graph, and History surfaces byte-identical. The phase touches only renderer/cursor geometry infrastructure.

## Implemented

- Added `renderer_sync_upgrade_policy.dart`.
- Added a `MathProGeometry` JavaScript channel in `mathjax_render_surface.dart`.
- MathJax/SVG runtime now posts an expression-envelope geometry snapshot after confirmed SVG render.
- `RendererSyncGeometryPolicy` records and parses renderer geometry snapshots.
- `RendererSyncGeometryPolicy.calibrateVisualRect` can clamp deterministic cursor geometry against the measured renderer envelope when a fresh snapshot exists.
- `DeterministicSlotGeometryRegistry` exposes Q44 markers and still refuses per-slot SVG identity claims.

## Honest Boundary

Q44 does **not** claim Photomath/Wolfram final PASS. Q44 does **not** claim per-slot SVG identity. It uses renderer expression-envelope telemetry only. True per-slot renderer identity still requires stable AST slot ids mapped into rendered MathJax/SVG output and real-device Pixel QA.

## P6 Locked Files

The following files must remain byte-identical with P6: keyboard config, keyboard widget, bottom dock, long-press popup, premium key, math label, template tray, app shell, solution panel, graph card, history controller, and history panel. Static comparison confirmed they are unchanged.

## Required Runtime Evidence

- `flutter pub get`
- `flutter analyze`
- `flutter test`
- real-device cursor tests for `√□`, `x^□`, `x_□`, `log_□(□)`, `a/b`, `cos(99666655)`, nested expressions, and drag.
