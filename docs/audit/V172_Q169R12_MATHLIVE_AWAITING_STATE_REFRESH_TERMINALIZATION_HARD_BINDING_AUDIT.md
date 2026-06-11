# V172-Q169R12 — MathLive Awaiting State Refresh Terminalization Hard Binding Audit

## Scope
Q169R12 is a diagnostic/state-contract hard-binding repair following Q169R11 review. Q169R11 introduced an awaiting-state terminalization policy, but the runtime surface did not directly import and use that policy as the source of truth.

## Implemented
- `MathLiveAwaitingStateRefreshTerminalizationPolicy` now carries `hardBindingPhase = 'V172-Q169R12'`.
- The policy exposes `isBlockedIntermediateFailure`, `shouldTerminalize`, and `terminalizeIfRequired`.
- `mathlive_main_editor_surface.dart` imports the policy and calls `terminalizeIfRequired(...)` before composing the visible Q169 diagnostic.
- Final guards use `MathLiveAwaitingStateRefreshTerminalizationPolicy.requiredTerminalFailure` and `.requiredTerminalPath`.
- Intermediate failures such as `bridge-dispatched-awaiting-state-refresh`, `bridge-fire-awaiting-state-refresh`, `bridge-sent-awaiting-state-refresh`, `bridge-state-stale-after-dispatch`, and stale `tap-before-bridge` may not remain visible final diagnostics after `SEND:Bridge JS:fire` with empty value.

## Not claimed
- No native MathLive paint PASS is claimed.
- No real-device PASS is claimed.
- No Photomath/Wolfram-level rendering claim is made.
- No keyboard, MORE, long-press, AppShell, Graph, History, Solution, or solver behavior was intentionally changed.

## Expected bad-but-honest diagnostic if still broken
`FAIL:state-refresh-timeout-after-js-fire PATH:refresh-not-delivered-after-fire`
