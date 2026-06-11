# V172-Q169R9 MathLive Bridge State Refresh / Diagnostic Overwrite Repair Audit

## Scope
Q169R9 targets the real-device evidence `SEND:Bridge JS:fire MF:true` with
`FAIL:tap-before-bridge PATH:not-read`. This phase forces the post-bridge state
refresh path to overwrite the pre-bridge tap marker or report an explicit
state-refresh timeout.

## Runtime contract
- `FAIL:tap-before-bridge PATH:not-read` must not remain the final post-command diagnostic after JS fire.
- If bridge state or diagnostic report is delivered, Flutter consumes it and updates INSERT/VALUE/PAINT/FAIL/PATH.
- If no state is delivered, Flutter reports `FAIL:state-refresh-timeout-after-js-fire PATH:refresh-not-delivered`.
- No native paint PASS is claimed without real-device evidence.

## Protected surfaces
Keyboard layout/source, MORE, long-press order, AppShell, Graph, History, Solution,
and solver files were not intentionally changed.
