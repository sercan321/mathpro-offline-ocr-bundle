# V172-Q169R23 Single Source Bridge Rewrite Audit

Scope: Replace the ambiguous Q169 diagnostic/court channel-push consumption path with a single deterministic JS-to-Flutter envelope. This package does not claim real-device `PAINT:ok`, premium visual PASS, or Flutter analyze/test PASS in the assistant environment.

Real code findings from the Q169R19/Q169R20 path:
- Compact channel payloads and final COURT payloads shared channel markers, which allowed incomplete compact payloads to be surfaced as COURT with unknown fields.
- Flutter key/queue diagnostic paths could still overwrite visible diagnostics unless the court overlay lock was respected.

Q169R23 package changes:
- Added `buildQ169SingleSourceEnvelope(...)` in `assets/mathlive/mathlive_bridge.js`.
- Every `postQ169ChannelPushState(...)` payload is normalized into an envelope with `singleSourceBridgePhase: V172-Q169R23` and `q169SingleSourceEnvelope: true`.
- The envelope always contains `mount`, `insert`, `value`, `channel`, `paint`, and `rootCause` fields, even when the source was compact state rather than a final court payload.
- Added `MathLiveSingleSourceBridgePolicy` and a first-priority Dart consumer in `mathlive_main_editor_surface.dart`.
- Added `COURT_SINGLE_SOURCE ... ROOT:...` visible summary, so compact payloads no longer render as `COURT ... unknown`.
- Guarded key and queue diagnostic summaries so they do not overwrite a locked court/single-source overlay.

Protected surfaces unchanged:
- `lib/app/app_shell.dart`
- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`

Checks executed in assistant environment:
- ZIP integrity after packaging
- Standard/unique SHA equality after packaging
- `node --check assets/mathlive/mathlive_bridge.js`
- Q157 → Q169R23 verifier chain
- `python3 tool/verify_mathpro_contract.py`
- Protected file comparison
- Package hygiene scan

Flutter/Dart note: Flutter/Dart are unavailable in the assistant container, so user-side `flutter analyze`, `flutter test`, and real-device evidence remain required.
