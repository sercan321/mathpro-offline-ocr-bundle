# V172-Q234 — 3D Graph Surface Color Hierarchy Audit Report

## Root cause

The previous 3D renderer was line-first: every sampled row and every sampled column were drawn as prominent paths, followed by point glow. On phone-sized graph panels, that makes simple surfaces such as `z = sin(x)` read as many overlapping wire curtains. Because grid, axis, mesh, and data surface shared similar visual strength, the main mathematical shape was not the dominant layer.

## Repair

- `GraphSurface3DPainter` now renders the 3D data layer as depth-sorted filled projected quads.
- `GraphSurfaceColorRamp` maps normalized z height to a premium dark-theme surface ramp.
- Visible mesh density is decoupled from sample resolution with `_meshStride`.
- Single-variable 3D expressions use a compressed ribbon/sheet domain instead of a full-width wire curtain.
- `GraphLayerPalette` separates curve/surface, axis, and grid color strength.
- `GraphSettingsSheet` adds a compact `Fonksiyon Rengi` preset picker.
- `GraphExpression` persists stable color keys through `graphColorKey`.

## Color keys

- `aquaTeal` — `#78F2E6` default
- `iceBlue` — `#6EA8FF`
- `violet` — `#B88CFF`
- `rose` — `#FF7AC8`
- `softAmber` — `#FFC857`
- `mint` — `#8DFFB3`
- `coralRed` — `#FF6B6B`
- `pearl` — `#E8EEF2`

## Unchanged

Keyboard, MORE, long-press, MathLive production editor/bridge, workspace/result layout, Solution, History, AppShell, Android startup/splash, solver/evaluator semantics, graph mode behavior, zoom/pan/reset and fullscreen graph route were not intentionally modified.

## Evidence boundary

Assistant-side static verification can confirm source contracts and package hygiene only. Flutter analyze/test/run and Android real-device 2D/3D visual PASS require user-side logs and screenshots.
