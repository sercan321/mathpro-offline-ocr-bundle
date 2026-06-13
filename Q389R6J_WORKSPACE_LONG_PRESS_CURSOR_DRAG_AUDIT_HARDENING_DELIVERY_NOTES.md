# Q389R6J — Workspace Long-Press Cursor Drag Audit Hardening

This package is a narrow audit hardening pass over Q389R6I.

## Real issue found during post-audit

Q389R6I edge autoscroll was driven by pointermove events. That meant dragging to the expression edge worked while the finger kept moving, but holding the finger still at the left/right edge could stop after a single autoscroll step. Fotomath-like behavior should keep moving while the finger remains inside the edge zone.

## Fix

- Added a continuous edge-autoscroll loop while long-press cursor drag is active.
- The loop ticks every 72 ms only when the pointer is inside the left/right edge zone.
- The loop stops on pointerup, pointercancel, and lostpointercapture.
- Explicit pointer-capture release is performed during finish.
- `-webkit-touch-callout: none` is applied to the MathLive field so the native callout/menu is less likely to fight the drag gesture.

## Preserved red lines

- Keyboard layout/dispatch not changed.
- Graph 2D/3D not changed.
- OCR/camera not changed.
- Android native not changed.
- Solver/CAS not changed.
- Workspace Dart layout not changed.
- Legacy Flutter cursor not restored.
- Q389R6I MathLive native caret authority markers preserved.

## Evidence available in this environment

Static only:

```bash
node --check assets/mathlive/mathlive_prod_bridge.js
node tool/verify_workspace_long_press_cursor_drag_q389r6i.mjs
node tool/verify_workspace_long_press_cursor_drag_hardening_q389r6j.mjs
```

Flutter/Dart analyze/test/build/run is not claimed by this package because Flutter/Dart was unavailable in the generation environment.
