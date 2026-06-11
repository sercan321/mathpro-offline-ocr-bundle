# V172-Q169R8 MathLive Insert/Value Failure Reason Court Audit

## Scope

Q169R8 responds to real-device evidence that Q169R6/Q169R7 moved the main editor past `SEND:Queued` and `JS:pending`, but the remaining failure was still:

```text
Q169 KEY:□/□ SEND:Bridge JS:fire MF:true INSERT:false VALUE:empty PAINT:pending
```

This phase is not a visual-polish phase and does not claim native paint success. It adds failure-reason instrumentation and guarded value-commit reporting so a single future device screenshot can identify the exact broken layer.

## Runtime changes

Changed `assets/mathlive/mathlive_bridge.js`:

- Adds `insertValueFailureReasonCourtPhase: V172-Q169R8`.
- Adds `q169FailureReason` / `failureReason` bridge fields.
- Adds `lastValueApiPath`, `lastValueApiError`, `lastInsertPath`, `lastMathfieldValueWritePath`, `lastFallbackOverlayState`, and `lastPaintRectState` fields.
- Adds detailed value reading through `readMathfieldValueDetailed()`.
- Keeps Q169R7 guarded value commit behavior.
- Records failure reasons including:
  - `insert-api-missing`
  - `insert-throw`
  - `value-api-empty-after-insert`
  - `direct-value-commit-empty-after-write`
  - `paint-rect-zero`
  - `paint-pending-empty-value`
- Keeps raw `#0/#?/#@` tokens blocked from user-visible output.

Changed `lib/features/mathlive/mathlive_main_editor_surface.dart`:

- Parses the Q169R8 failure reason and value API path fields.
- Extends the real-device diagnostic overlay from `SEND/JS/MF/INSERT/VALUE/PAINT` to also show `FAIL:` and `PATH:`.
- Keeps Q169/Q169R1/Q169R2/Q169R3/Q169R4/Q169R6 compatibility markers.

## Guardrail confirmation

No protected keyboard, MORE, long-press, AppShell, Graph, History, Solution, or solver files were intentionally modified.

## Truth status

- Real-device/native-paint PASS: not claimed.
- Photomath/Wolfram-level rendering: not claimed.
- Flutter analyze/test/run: not claimed from assistant environment.
- Package-side verifier: `node tool/verify_mathlive_insert_value_failure_reason_court_v172_q169r8.mjs`.

## Acceptance target

```text
Q169 KEY:... SEND:Bridge JS:ok MF:true INSERT:true VALUE:non-empty PAINT:ok FAIL:none PATH:<value-api-path>
```

If the target is not reached, Q169R8 should still show a precise `FAIL:` reason for the next repair.
