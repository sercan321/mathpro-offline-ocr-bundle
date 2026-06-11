# GRAPH/HISTORY V3 — Changed Files Manifest

## Modified files

1. `lib/features/graph/graph_painter.dart`
   - Rebuilt the graph drawing layer around viewport-aware curve sampling.
   - Added axis tick generation, tick labels, crosshair trace lines, plot clipping, and segmented curve paths.
   - Hardened the lightweight explicit evaluator for `√x/sqrtx`, `ln`, `log`, `log10`, `log2`, `abs`, `exp`, constants, implicit multiplication, and invalid-domain handling.
   - Added `GraphCurvePoint` and `GraphCurveSampler` for testable curve segmentation.

2. `test/graph_history_regression_test.dart`
   - Added regression coverage for domain-invalid `sqrt/log` samples.
   - Added compact function input checks such as `√x` and `sqrtx`.
   - Added discontinuity segmentation coverage for `tan(x)`.
   - Added constant-function horizontal-segment coverage.

3. `README.md`
   - Updated package description from V2 to V3.
   - Documented Graph Painter hardening and honest test status.

## Files intentionally not changed

The frozen keyboard contract files were not edited:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`

## Generated audit inventory

- `docs/audit/GRAPH_HISTORY_V3_CONTENTS.txt`
