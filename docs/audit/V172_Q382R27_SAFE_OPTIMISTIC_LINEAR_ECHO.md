# V172 Q382R27 — Safe Optimistic Linear Echo

## Scope

Q382R27 enables a narrow optimistic Flutter-side expression echo for append-only linear labels after Q382R26 exposes trusted native MathLive caret context.

This phase is not a template/MORE/long-press acceleration phase and does not claim real-device latency PASS.

## Enabled only for

- `0`–`9`
- `+`
- `−` / `-`
- `.`
- `x`
- `y`

## Required gate

Optimistic echo is allowed only when the last MathLive caret context says:

- `trusted == true`
- `selectionCollapsed == true`
- `caretAtDocumentEnd == true`
- `insidePlaceholder == false`
- `insideTemplate == false`

A continuing optimistic linear chain may append further safe linear labels until canonical MathLive state catches up or a non-linear command resets the chain.

## Explicitly not enabled for

- `□/□`, `√□`, `|□|`, `□^□`, structural templates
- `sin`, `cos`, `tan`, `log`, `ln`, `Σ`, `lim`, integral/Taylor templates
- MORE/template tray inventory
- long-press parent or child labels
- delete, clear, solve/evaluate, graph
- pan/drag-scroll

## Native MathLive authority guard

Because the Flutter optimistic expression is only a mirror, Q382R27 arms a one-shot guard before syncing the optimistic value into `CalculatorController`:

- `MathLiveMainEditorRuntimeController.suppressNextExternalExpressionSyncForOptimisticEcho()`
- `_q382r27SuppressNextExternalExpressionSync`

This prevents the optimistic Flutter prop update from calling `setLatex(...)` back into MathLive and duplicating the real JS command. MathLive canonical state still wins on the next bridge state push.

## Reconciliation

When MathLive sends canonical state:

- if canonical expression equals optimistic expression, the optimistic chain is closed;
- if canonical expression is a prefix of an in-flight optimistic chain, the chain is kept;
- if canonical expression diverges, the optimistic chain is reset and canonical downstream sync wins.

## Protected surfaces

Unchanged by this phase:

- keyboard layout/order/labels
- long-press lists
- MORE/template tray inventory/order
- Graph, Solution, History UI
- OCR/camera and Android side
- Gradle, AndroidManifest, MainActivity
- MathLive JS bridge command semantics
- pan/drag-scroll
- legacy Flutter cursor/render path

## Evidence

Static verifier:

```bash
node tool/verify_safe_optimistic_linear_echo_v172_q382r27.mjs
```

Regression verifier chain should still include Q382R12, Q382R17–Q382R26, and `python tool/verify_mathpro_contract.py`.

## Honest boundary

This phase does not claim:

- `flutter analyze` PASS
- `flutter test` PASS
- `flutter run` PASS
- real-device latency PASS
- all-key latency closure

Those require user-side Flutter/Android execution.
