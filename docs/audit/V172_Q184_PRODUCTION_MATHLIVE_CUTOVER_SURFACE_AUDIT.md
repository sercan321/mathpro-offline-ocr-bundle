# V172-Q184 Production MathLive Cutover Surface Audit

Q184 implements the first cutover phase after the Q183 inventory. It introduces a minimal production MathLive surface and production HTML/bridge pair while preserving the historical Q135-Q182 surface for compatibility and rollback.

## Intent

- Stop using the diagnostic/court-heavy surface as the active production workspace path.
- Keep MathPro keyboard, MORE, long-press, AppShell, Graph, History, and Solution contracts unchanged.
- Use a production path: MathPro keyboard → minimal command mapper → `MathLiveProductionEditorSurface` → `main_editor_prod.html` → `mathlive_prod_bridge.js` → native MathLive `<math-field>`.

## Honesty

This is a package-side production cutover phase. Flutter analyze/test/run and Android real-device premium PASS are not claimed by the assistant environment.
