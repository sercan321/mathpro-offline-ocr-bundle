# V172-Q234R1 Graph Surface Color Hierarchy Final Hygiene Audit Report

## Scope
Q234R1 closes final-hygiene items for Q234 without rewriting the 3D renderer.

## Closed items
- Q225 verifier-chain hygiene updated to accept Q234/Q234R1 surface-first 3D renderer as the intentional visual successor.
- Fullscreen `GraphSettingsSheet` now receives active `renderMode` and `onRenderModeChanged` so fullscreen 2D/3D mode state is not stale.
- Duplicate Apply-button `key:` argument in `graph_settings_sheet.dart` was removed for analyzer hygiene.
- Graph color persistence is explicitly expression-level through `GraphExpression.graphColor` and stable `graphColorKey` JSON persistence.

## Persistence decision
Global graph color default preference was not added in Q234R1. The low-risk contract remains expression-level persistence because a correct app-wide default bootstrap would require protected startup/AppShell initialization.

## Not changed
Keyboard, MORE, long-press, MathLive production editor/bridge, Workspace layout, Solution, History, AppShell, main.dart, Android startup files, graph evaluator semantics, and Q234 3D painter/surface algorithm were not modified.

## Honest boundary
Flutter analyze/test/run and Android screenshot PASS are not claimed from the assistant environment.
