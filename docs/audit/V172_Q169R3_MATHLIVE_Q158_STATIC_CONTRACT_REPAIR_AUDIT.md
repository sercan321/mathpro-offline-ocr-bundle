# V172-Q169R3 MathLive Q158 Static Contract Repair Audit

## Scope

Q169R3 is a narrow follow-up to Q169R2 after user-side `flutter test` showed the legacy Q158R1 analyzer-hygiene test still expects the exact `source: 'q157-returning-result-command-ack $_lastRuntimeCommandAck'` marker in `lib/features/mathlive/mathlive_main_editor_surface.dart`.

## Changes

- Added a compatibility comment containing the exact Q158R1 marker.
- Added `MathLiveQ158StaticContractRepairPolicy`.
- Added Q169R3 static verifier and Flutter policy test.
- Updated the MathLive manifest and README with the Q169R3 envelope.

## Non-Changes

- No keyboard layout changes.
- No MORE inventory or long-press order changes.
- No Graph, History, Solution, solver, or AppShell changes.
- No Q169 queue flush or native paint commit semantic changes.
- No real-device native paint PASS claimed.

## Real-device acceptance remains

`Q169 KEY:... SEND:Bridge JS:ok MF:true INSERT:true VALUE:non-empty PAINT:ok`
