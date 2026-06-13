# Q389R6C — Graph 3D Focus / 360 Rotation / 3D Critical Feature Interaction

## Scope

This package continues from Q389R6B and only changes the graph feature area.

Red lines preserved:

- No keyboard layout/key ordering mutation.
- No MathLive production bridge mutation.
- No OCR / camera / Android native mutation.
- No solver/CAS mutation.
- No workspace layout mutation.
- No permanent bottom “Önemli Noktalar” card added.

## Implemented

- 3D graph now uses a smart focused viewport for periodic ribbon-style functions.
  - `sin(x)` / `cos(x)` default from a wide `[-10,10]` window to a controlled `[-π,π]` 3D focus.
  - Large y windows are compressed to a readable `[-1.35,1.35]` focus for these periodic ribbons.
- 3D graph surface accepts local touch interaction.
  - Horizontal drag rotates the 3D camera through 360 degrees.
  - Vertical drag adjusts pitch with premium clamped limits so the graph does not flip upside down.
  - Double tap resets the 3D camera.
- 3D critical feature layer added for ribbon-style functions.
  - Existing 2D critical-point detector is reused safely.
  - Roots are shown as `Kök hattı`.
  - Local maxima are shown as `Tepe hattı`.
  - Local minima are shown as `Dip hattı`.
  - Tapping a feature line opens an in-graph tooltip.
- Fullscreen 3D no longer uses the outer 2D pan/zoom gesture handler; 3D gestures remain local to the 3D graph surface.
- Fullscreen hint text updated for 3D: `Sürükle: 360° döndür`.

## Changed files

- `lib/features/graph/graph_surface_3d.dart`
- `lib/features/graph/graph_fullscreen_page.dart`
- `test/q389r6c_graph_3d_focus_rotation_markers_contract_test.dart`
- `tool/verify_graph_3d_focus_rotation_markers_q389r6c.mjs`
- `Q389R6C_GRAPH_3D_FOCUS_ROTATION_MARKERS_DELIVERY_NOTES.md`

## Static verifier evidence

Passed in this environment:

```bash
node tool/verify_graph_critical_points_interaction_q389r6b.mjs
node tool/verify_graph_canvas_premium_polish_v172_q223.mjs
node tool/verify_graph_mini_panel_final_regression_freeze_v172_q224.mjs
node tool/verify_graph_mini_panel_visual_parity_repair_v172_q225.mjs
node tool/verify_graph_settings_bottom_sheet_control_migration_v172_q222.mjs
node tool/verify_graph_3d_focus_rotation_markers_q389r6c.mjs
```

## Not claimed

Flutter/Dart are not available in this execution environment. Therefore this package does **not** claim:

- `flutter analyze` pass
- `flutter test` pass
- release APK build pass
- real Android device pass
- real FPS/performance pass

The user/developer must run the real Flutter/Android checks.

## Manual QA checklist

- `sin(x)` 3D should open in a clean focused one-period view.
- Drag left/right on 3D graph: camera should rotate smoothly through 360°.
- Drag up/down on 3D graph: pitch should change without flipping the graph upside down.
- Double tap 3D graph: camera resets.
- Tap `Tepe hattı`, `Dip hattı`, or `Kök hattı`: tooltip appears inside graph.
- 2D marker/tooltip behavior from Q389R6B must still work.
- Keyboard ordering test must still hold: `C → 88888 → 7777` produces `888887777`.
