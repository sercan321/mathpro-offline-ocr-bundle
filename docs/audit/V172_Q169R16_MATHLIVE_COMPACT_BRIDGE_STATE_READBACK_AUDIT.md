# V172-Q169R16 MathLive Compact Bridge State Readback Audit

## Purpose
Q169R16 responds to real-device evidence showing `SEND:Bridge JS:fire MF:true INSERT:false VALUE:empty PAINT:pending FAIL:state-refresh-timeout-after-js-fire`. The keyboard command reaches the bridge fire path, but the full bridge state/diagnostic payload is not reliably delivered back to Flutter. Q169R16 adds a compact readback endpoint so Flutter can poll only the minimum post-fire INSERT/VALUE/PAINT fields.

## Scope
- Adds `getQ169CompactState()` to `assets/mathlive/mathlive_bridge.js`.
- Adds `MathLiveCompactBridgeStateReadbackPolicy`.
- Uses compact readback before full `getState()`/diagnostic payloads in post-fire refresh paths.
- Keeps existing Q169 terminal failure behavior when compact readback is also unavailable.

## Non-goals
- No native MathLive paint PASS claim.
- No keyboard layout/MORE/long-press/AppShell/Graph/History/Solution mutation.
- No visual premium polish.

## Expected real-device evidence
A failing device should no longer depend solely on oversized full-state refresh. If compact state is readable, the overlay should expose actual INSERT/VALUE/PAINT/failure fields. If compact state is also unavailable, the terminal failure remains `state-refresh-timeout-after-js-fire`.
