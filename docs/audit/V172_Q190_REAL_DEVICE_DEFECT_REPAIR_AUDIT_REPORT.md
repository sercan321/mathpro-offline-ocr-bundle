# V172-Q190 Real Device Defect Repair Audit Report

## Decision

Q189 failed on a real Android device. Q190 is therefore a Real Device Defect Repair phase, not a final release/evidence closure phase and not a new-feature phase.

## Reported real-device failure

- A MathPro key press can leave one command/template visually stuck in the workspace.
- The limit command was observed as a half/raw `lim □` style form.
- Subsequent keys do not reliably flow into the production MathLive workspace.
- Q189 cannot be called final.

## Repair scope

Only the active production MathLive route was modified:

```text
MathLiveProductionEditorSurface
assets/mathlive/mathlive_prod_bridge.js
```

Q190 also adds a package policy, test, verifier, audit report, and manifest metadata.

## Repair details

- Key/template dispatch on the production surface no longer depends on per-key `runJavaScriptReturningResult` JSON readback.
- Production commands are serialized through a bounded Dart command tail.
- Each command has timeout protection so a WebView call cannot permanently lock later keys.
- JS bridge commands push state through `MathProMathLiveState.postMessage` after command completion.
- Insert fallback now checks commit; if native `mathfield.insert()` does not visibly commit, bridge tries `executeCommand(['insert', latex])` and then sanitized `setValue()`.
- Focus is restored around insert/delete/clear/set operations.
- Deferred state refreshes are scheduled after commands to verify post-insert state on Android.
- Clear path remains explicit and must purge MathLive value/state.

## Red-line preservation

The following protected files are intentionally untouched:

```text
lib/features/keyboard/key_config.dart
lib/features/keyboard/math_keyboard.dart
lib/features/keyboard/bottom_dock.dart
lib/features/keyboard/premium_key.dart
lib/features/keyboard/long_press_popup.dart
lib/features/workspace/template_tray.dart
lib/features/graph/graph_card.dart
lib/features/graph/graph_controller.dart
lib/features/history/history_controller.dart
lib/features/history/history_panel.dart
lib/features/solution/solution_steps_panel.dart
```

## Honest limits

No Flutter analyze/test/run PASS is claimed by the assistant environment. No Android real-device PASS, final release PASS, or Photomath/Wolfram +95 claim is made. Q190 must be retested on the user's Android device.
