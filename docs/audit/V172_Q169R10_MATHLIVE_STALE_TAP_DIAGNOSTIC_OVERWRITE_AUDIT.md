# V172-Q169R10 — MathLive Stale Tap Diagnostic Overwrite Repair

## Trigger evidence

Real-device Q169R9 showed:

```text
Q169 KEY:log SEND:Bridge JS:fire MF:true INSERT:false VALUE:empty PAINT:pending FAIL:tap-before-bridge PATH:not-read
```

That state is inconsistent: `tap-before-bridge` is only a pre-dispatch Flutter marker. Once the command reaches `SEND:Bridge JS:fire`, that marker must be overwritten by either a real JS/value/paint failure reason or by an honest state-refresh delivery timeout.

## Repair scope

- Added `MathLiveStaleTapDiagnosticOverwritePolicy`.
- Sanitized visible Q169 diagnostics so `FAIL:tap-before-bridge PATH:not-read` cannot remain final after `SEND:Bridge` / `JS:fire`.
- Preserved Q169R9 state refresh behaviour.
- Added a final Dart guard after post-bridge refresh.
- Added JS/manifest metadata markers for Q169R10.

## Non-goals

- No native paint PASS claim.
- No visual polish.
- No keyboard layout, MORE, long-press, AppShell, Graph, History, Solution, or solver mutation.
