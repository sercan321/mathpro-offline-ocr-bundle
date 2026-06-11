# V172-Q225 Graph Mini Panel Visual Parity Repair / Canvas Dominance Pass — Audit Report

## Scope

Q225 is a surgical graph mini-panel visual parity repair. It follows Q224 and targets three items only:

1. Canvas dominance: increase the available mini graph height on normal/tall workspaces and reduce graph-card chrome so the canvas occupies the visual majority of the card.
2. Trace default clean state: new graph previews start with trace disabled; trace remains user-controlled from the settings sheet.
3. 3D compact binding: the mini 3D surface receives the same compact/tight fit state as the 2D preview and suppresses compact text clutter.

## Explicit non-goals

- No keyboard layout or key-position mutation.
- No MORE or long-press mutation.
- No MathLive production editor/bridge mutation.
- No History or Solution mutation.
- No solver, cursor, splash/startup, or launcher icon mutation.
- No graph evaluator or graph eligibility semantic rewrite.
- No fullscreen graph runtime behavior rewrite.
- No 3D final/PASS claim.

## Static evidence

- `WorkspacePanel` graph requested height is no longer the stale `compact ? 132.0 : 188.0` pair; it now scales up to 226/212/176/148 depending on available workspace height.
- `GraphCard` chrome is thinner and marked with the Q225 canvas dominance contract.
- `GraphExpression.traceEnabled` defaults to `false`; JSON restore also defaults missing trace to `false`.
- Mini 3D surface is called with `compact: canvasCompact || canvasPixelTight`.
- Compact 3D labels and unavailable text are suppressed to reduce clutter.
- The settings sheet trace control remains present.

## Evidence boundary

The package is statically verified in the assistant environment. Flutter analyze/test/run and Android real-device/pixel QA are not claimed without user-side logs and screenshots.
