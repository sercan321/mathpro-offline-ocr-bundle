# V172-Q382R31 — RESULT / SOLUTION IDLE PIPELINE

## Scope

Q382R31 separates result/status and Solution Steps composition from the MathLive keyboard hot path. Expression/caret updates remain immediate through the Q382R30 hot workspace frame, while result/status and SolutionSteps composition read a debounced idle snapshot.

## What changed

- Added `ResultSolutionIdlePipelineQ382R31Policy`.
- Added an AppShell idle snapshot for result/status/SolutionSteps.
- Keystroke-driven calculator changes update expression immediately but debounce result/status and solution composition for 140 ms.
- Explicit actions flush the idle pipeline before evaluation, graph, OCR import completion, and opening Solution Steps.

## Protected surfaces

No changes were made to keyboard layout/order/labels, long-press inventory, MORE/template tray inventory, MathLive JS semantics, OCR/camera, Graph, History, AndroidManifest, Gradle, MainActivity, splash/icon, or pan/drag-scroll.

## Honest boundary

This phase is a structural pipeline change. It does not claim Flutter analyze/test/run PASS or real-device latency PASS without user-side execution.
