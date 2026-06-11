# V172-Q169 — MathLive Queue Flush / Native Paint Commit Repair Audit

## Scope

This phase is a surgical repair for the MathLive main-editor runtime path. It targets the observed real-device condition where MathLive can report a mounted/existing math-field (`MF:true`) while the MathPro keyboard command remains `SEND:Queued` and native MathLive paint remains `PAINT:pending`.

## Implemented

- Added `MathLiveQueueFlushNativePaintCommitPolicy` as the Q169 source-of-truth contract.
- Hardened `MathLiveMainEditorRuntimeController` queue flushing so queued commands are retried after page-finished, runtime-mounted, bridge-state mounted, command-state `MF:true`, and real-device diagnostic `MF:true` events.
- Replaced the Q167 boolean/ack-level diagnostic with a Q169 diagnostic shape:

```text
Q169 KEY:<label> SEND:<Flutter|Queued|Bridge> JS:<pending|ok|fail|no-mathfield> MF:<true|false> INSERT:<true|false> VALUE:<empty|non-empty> PAINT:<ok|pending|fail>
```

- Hardened `assets/mathlive/mathlive_bridge.js` so command execution records:
  - `lastJsCommandStatus`
  - `lastInsertCommitted`
  - `lastValueNonEmpty`
  - `nativePaintState`
  - `nativePaintLikelyVisible`
  - `nativePaintCommitReason`
- Added a Q169 real-device diagnostic report while retaining Q163 compatibility markers.
- Demoted Flutter/AppShell fallback only when native paint is `ok` and value is non-empty.
- Kept raw MathLive insert tokens `#0`, `#?`, and `#@` blocked from user-visible output.
- Repaired stale Q165 static verifier/test compatibility for the Q167 `markKeyboardTap(label, visibleLatex: visibleFallbackLatex)` signature without changing AppShell.

## Protected Surfaces

The following remained byte-for-byte unchanged:

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

`lib/app/app_shell.dart` also remained byte-for-byte unchanged.

## Verification Performed in Assistant Environment

Passed:

```bash
node --check assets/mathlive/mathlive_bridge.js
node --check tool/verify_mathlive_queue_flush_native_paint_commit_v172_q169.mjs
node --check tool/verify_mathlive_appshell_visible_fallback_v172_q165.mjs
node --check tool/verify_mathlive_appshell_command_bus_hard_binding_v172_q167.mjs
node tool/verify_mathlive_appshell_visible_fallback_v172_q165.mjs
node tool/verify_mathlive_appshell_command_bus_hard_binding_v172_q167.mjs
node tool/verify_mathlive_queue_flush_native_paint_commit_v172_q169.mjs
python3 tool/verify_mathpro_contract.py
```

Not run in assistant environment because Flutter/Dart are unavailable:

```bash
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Real-device Gate

Q169 is successful only if real-device diagnostics move toward:

```text
Q169 KEY:tan SEND:Bridge JS:ok MF:true INSERT:true VALUE:non-empty PAINT:ok
```

If the device still shows `SEND:Queued` or `PAINT:pending`, Q169 must be treated as not fully closed and Q170 visual polish must not start yet.
