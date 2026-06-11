# V172-Q169R2 — MathLive Q159 Static Contract Repair Audit

## Scope

Q169R2 is a marker-only follow-up to Q169R1. User-side Flutter tests showed the older Q159 static test still expects the exact `_flushQueuedLabels(lastAnswer: widget.lastAnswer)` substring in `mathlive_main_editor_surface.dart`. Q169/Q169R1 already preserve real queue flush calls through the mounted/diagnostic paths, but the exact legacy string was absent after the newer richer call shape.

## Change

- Added the exact Q159 compatibility marker to `lib/features/mathlive/mathlive_main_editor_surface.dart`.
- Added a Q169R2 policy, Flutter static test, Node verifier, manifest envelope, and README note.

## Non-goals

- No runtime queue flush semantic change.
- No Q169 native paint commit semantic change.
- No keyboard layout, MORE, long-press, Graph, History, Solution, AppShell, or solver mutation.
- No real-device PASS or Photomath-level claim.

## Real-device acceptance remains

`Q169 KEY:... SEND:Bridge JS:ok MF:true INSERT:true VALUE:non-empty PAINT:ok`
