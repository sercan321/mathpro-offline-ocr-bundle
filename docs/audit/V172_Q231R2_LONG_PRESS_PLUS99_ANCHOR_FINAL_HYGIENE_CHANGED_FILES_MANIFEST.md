# V172-Q231R2 Changed Files Manifest

## Runtime/source files
- `lib/features/keyboard/bottom_dock.dart`
  - Adds `Rect.zero` measured-anchor guard before converting key center coordinates.

## Verifier / metadata files
- `tool/verify_solution_steps_single_surface_cleanup_v172_q227.mjs`
  - Updates successor hashes/status for intentional Q231R1/Q231R2 long-press presentation changes.
- `tool/verify_long_press_plus99_floating_segment_menu_v172_q231.mjs`
  - Accepts Q231R2 latest metadata as a valid successor of Q231.
- `tool/verify_long_press_plus99_anchor_final_hygiene_v172_q231r2.mjs`
  - Adds Q231R2 static guard.
- `assets/mathlive/manifest.json`
  - Adds Q231R1/Q231R2 long-press phase metadata and marks Q231R2 latest.
- `README.md`
  - Adds Q231R1/Q231R2 notes.

## Audit docs
- `docs/audit/V172_Q231R2_LONG_PRESS_PLUS99_ANCHOR_FINAL_HYGIENE_AUDIT_REPORT.md`
- `docs/audit/V172_Q231R2_LONG_PRESS_PLUS99_ANCHOR_FINAL_HYGIENE_CHANGED_FILES_MANIFEST.md`

## Not changed
- Keyboard key configuration/inventory.
- Long-press option lists/order.
- MORE/template tray content.
- MathLive production editor/bridge.
- Workspace/Graph/Solution/History runtime behavior.
- Android startup/splash.
