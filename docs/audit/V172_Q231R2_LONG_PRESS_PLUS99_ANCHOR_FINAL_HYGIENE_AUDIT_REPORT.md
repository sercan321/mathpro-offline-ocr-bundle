# V172-Q231R2 Long-Press +99 Anchor Final Hygiene Audit

## Scope
Q231R2 is a micro final-hygiene repair after Q231R1. It does not change keyboard layout, key order, key size, long-press option inventory/order, MORE, MathLive, Workspace, Graph behavior, Solution, History, AppShell, Android startup/splash, or solver/evaluator logic.

## Changes
1. `BottomDock._localAnchorCenterXFor` now returns `null` when `KeyboardLongPressAnchor.globalRect == Rect.zero`.
   - This makes failed physical key measurement fall back to LongPressPopup's estimated anchor path.
   - It prevents a failed measurement from pinning the popup toward the left edge.
2. `tool/verify_solution_steps_single_surface_cleanup_v172_q227.mjs` successor hashes were updated for the intentional Q231R1/Q231R2 long-press presentation/anchor files.
   - Direct Q227 verifier execution now remains compatible with Q231R2.
3. `README.md` and `assets/mathlive/manifest.json` now identify Q231R2 as the latest long-press +99 anchor hygiene phase.
4. `graph_card.dart` was checked; it does not directly import `graph_painter.dart`.

## Protected behavior
- Long-press contents/order: unchanged.
- Keyboard inventory/layout: unchanged.
- MORE/template tray: unchanged.
- MathLive production editor/bridge: unchanged.
- Workspace/Graph/Solution/History behavior: unchanged.
- Real-device +99 PASS: not claimed.

## Required user-side evidence
- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run -d 23106RN0DA`
- Android screenshots: left/center/right long-press, Σ multi-option popup, sin/log popup, long-label popup.
