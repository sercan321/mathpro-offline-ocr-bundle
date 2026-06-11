# V172-Q143 MathLive Pointer/Caret Fluidity Audit Report

## Outcome

Package-side repair is implemented, but real-device cursor PASS is not claimed.
This phase targets the reported Q139R5/Q142 symptom: after one caret placement,
the MathLive editor can stop accepting later taps or feel non-fluid.

## Surgical changes

- Added eager Flutter WebView gesture routing for the active MathLive editor.
- Added a Q143 pointer/caret policy with explicit no-fake-PASS gates.
- Added JavaScript focus priming before pointer/touch handling without calling
  `preventDefault()` or `stopPropagation()`, so MathLive keeps ownership of
  hit-testing and selection.
- Added delayed selection sync after pointerup/click/touchend to avoid reading
  stale Android WebView selection immediately on tap.
- Added scoped blur recovery for Android WebView focus loss.
- Added touch-action and caret/selection CSS hardening to reduce dead zones.

## Protected contracts

Keyboard layout, key order, MORE, Ans, ↵, =, long-press source-of-truth,
Graph UI, History UI, and Solution UI were not changed in this phase.

## Evidence boundary

Assistant-side static checks can verify that Q143 wiring exists. They cannot
prove real-device caret quality. Cursor PASS, Photomath-level PASS, Flutter
analyze/test PASS, and `flutter run` PASS remain blocked until user-side evidence.
