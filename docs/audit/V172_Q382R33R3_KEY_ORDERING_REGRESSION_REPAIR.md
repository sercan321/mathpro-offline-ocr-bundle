# V172-Q382R33R3 — Key Ordering Regression Repair

## User-reported defect

Rapid same-family typing could reorder commands.  A concrete report was:

- Type `88888`.
- Then type `7777`.
- The editor first shows the later `7777`, then a late older `888` chain arrives.

That is not a visual polish issue; it is a command-ordering regression.

## Root cause

Q382R24/Q382R28 made hot key dispatch non-blocking.  The Q382R28 JS-side queue preserved the order in which JavaScript enqueue calls reached the WebView, but Q382R24 fire-and-forget dispatch allowed multiple `runJavaScript` calls to race before they reached that queue.

## Repair

- Keep key acceptance synchronous.
- Keep Q382R28 JS-side queue.
- Keep Q382R27 optimistic echo scope unchanged.
- Serialize only the Dart-to-WebView enqueue call for commands that use the JS-side queue.
- Parse `lastCommandSequence` in `MathLiveEditorStateSnapshot`.
- Add an AppShell stale-snapshot guard so an older MathLive state cannot overwrite a newer rapid typing chain.

## Protected areas

Untouched:

- keyboard layout/order/labels
- MORE inventory/order
- long-press lists
- template slot/caret semantics
- Graph
- History
- Solution
- solver
- Q384 OCR download-only size contract
- AndroidManifest/Gradle plugin setup
- splash/icon

## Evidence boundary

Static/verifier evidence only in this environment.  Flutter analyze/test/run and real-device confirmation must be run on the user's machine.
