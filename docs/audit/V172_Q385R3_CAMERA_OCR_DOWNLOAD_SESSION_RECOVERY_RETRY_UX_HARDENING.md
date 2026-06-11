# V172-Q385R3 — Camera OCR Download Session Recovery and Retry UX Hardening

## Scope

Q385R3 is a surgical continuation after Q385R2. It hardens only the deferred camera/OCR model download session lifecycle. It does not enable OCR inference, re-add ONNX Runtime, bundle model bytes, modify keyboard/Q382 ordering, change MORE/long-press inventory, or touch Graph/History/Solution/Solver semantics.

## Repairs

1. Added a process-local active install guard in `GaussDeferredMathOcrModelManager`.
2. Active persisted snapshots now recover immediately when no install is running in the current process, so a process-death/interrupted download does not keep the user locked behind the disabled `İndiriliyor` button for the previous 30-minute grace window.
3. Active progress snapshots are persisted with a throttled cadence while the worker is still running, so a real active download refreshes `stateUpdatedAtIso` without excessive SharedPreferences writes.
4. The download worker accepts `FutureOr` progress callbacks and awaits them, preventing stale async progress writes from racing after a final ready/failed state.
5. The review button copy is state-aware: `Modeli indir`, `İndiriliyor`, or `Tekrar indir`.
6. The Q385R2 audit hygiene note about generated `tool/reports` is documented in this successor changed-files record.

## Non-claims

- No Flutter analyze/test/build PASS is claimed in this environment.
- No real-device camera download PASS is claimed.
- No release APK/AAB size PASS is claimed.
- No OCR inference/image-to-LaTeX PASS is claimed.
- No Q382 ordering real-device PASS is claimed.

## Protected boundaries

Keyboard layout/order/labels, KeyConfig inventory, MORE/template tray, long-press inventory, MathLive editor/caret authority, Q382 ordering pipeline, Graph, History, Solution/Solver, ONNX Runtime dependency, bundled model files, AndroidManifest permissions, Gradle ABI policy, splash/icon, and startup flow remain protected.
