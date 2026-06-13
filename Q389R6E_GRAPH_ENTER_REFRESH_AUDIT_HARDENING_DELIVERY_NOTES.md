# Q389R6E — Graph Enter Refresh Audit Hardening

This package audits and hardens Q389R6D without touching keyboard, MathLive bridge, OCR, Android native, solver, or workspace layout.

## Hardening added

- Enter refresh still updates an already-visible graph when the expression changed.
- If Enter is pressed again with the same graph expression, the user's current graph viewport/zoom is preserved instead of being reset to the default window.
- Existing 2D/3D mode, graph toggles, trace, critical-point visibility, and graph color remain preserved.

## Evidence

Static verifier expected:

```bash
node tool/verify_graph_enter_refresh_q389r6e.mjs
node tool/verify_graph_enter_refresh_q389r6d.mjs
node tool/verify_graph_critical_points_interaction_q389r6b.mjs
node tool/verify_graph_3d_focus_rotation_markers_q389r6c.mjs
```

Flutter/Dart analyze/test/build/run are not claimed by this package unless executed on a real Flutter toolchain.
