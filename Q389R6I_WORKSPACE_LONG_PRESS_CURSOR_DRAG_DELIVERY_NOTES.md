# Q389R6I — Workspace Long-Press Cursor Drag + Edge Autoscroll

## Goal

Add Fotomath-style long-press cursor dragging for long MathLive expressions:

- normal tap-to-place remains native MathLive behavior;
- long press activates cursor drag after a delay;
- dragging maps the finger to the nearest MathLive offset using `getOffsetFromPoint`;
- edge autoscroll nudges horizontal overflow near the left/right edges;
- existing Q389R6H minimum-readable-scale and caret visibility helpers remain active.

## Runtime files changed

- `assets/mathlive/main_editor_prod.html`
- `assets/mathlive/mathlive_prod_bridge.js`

## Red-line protections

Not changed:

- keyboard layout / key ordering;
- Dart keyboard dispatch;
- graph 2D/3D code;
- OCR / camera / Android native code;
- solver / CAS code;
- legacy Flutter cursor overlay is not reintroduced.

## Important implementation details

The long-press listener does not block MathLive on pointer down. It starts only after
`260ms`. If the pointer moves more than `18px` before activation, the pending long
press is cancelled so normal tap/scroll behavior stays intact.

After activation, drag movement is handled inside the MathLive surface. Only then
`preventDefault()` is used, and only for active drag movement.

## Verification performed in this environment

Static only:

```bash
node --check assets/mathlive/mathlive_prod_bridge.js
node tool/verify_workspace_expression_scale_preflight_q389r6f.mjs
node tool/verify_workspace_compact_expression_scale_q389r6g.mjs
node tool/verify_workspace_long_expression_scroll_q389r6h.mjs
node tool/verify_workspace_long_press_cursor_drag_q389r6i.mjs
```

Flutter/Dart/Android build/run were not available in this environment, so no real
`flutter analyze`, `flutter test`, release build, or device PASS is claimed.

## Device acceptance tests

1. `sin(x)` normal tap-to-place still works.
2. Long expression: `cos(x)+tan(x+π)+∫4x dx+dy/dx+sin(x)+x^2`.
3. Long press and drag left/right: caret follows the finger.
4. Drag near left/right edges: horizontal scroll/autoscroll reaches beginning/end.
5. `a/b`, `√x`, `x^2`, `sin(300)` slot/caret behavior remains correct.
6. `C → 88888 → 7777` still equals `888887777`.
7. Graph 2D/3D and Enter refresh still work.
