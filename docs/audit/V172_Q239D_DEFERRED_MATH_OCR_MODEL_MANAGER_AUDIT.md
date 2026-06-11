# V172-Q239D — Deferred Math OCR Model Manager Foundation Audit

## Scope

This phase prepares only the app-side state contract for a future optional advanced math OCR model pack. It keeps the base app small by avoiding bundled model binaries and avoids binding any production download URL or background worker before the engine benchmark/adapter phase.

## Implemented

- `GaussDeferredMathOcrModelManagerPolicy` records the Q239D boundary.
- `GaussDeferredMathOcrModelManager` provides persisted model status snapshots using existing `shared_preferences`.
- Model states are prepared: `notInstalled`, `queued`, `downloading`, `verifying`, `ready`, `failed`, `updateAvailable`, `disabledByUser`.
- Future model requirements are encoded: Wi-Fi by default, app-private storage, SHA256 verification before ready, offline availability only after verified install.
- `GaussCameraCaptureShell` shows a small premium model-manager status card in the crop confirmation sheet.

## Explicit non-goals

- No OCR engine.
- No Text OCR fallback.
- No external math OCR runtime.
- No ONNX runtime.
- No production download URL.
- No actual background worker.
- No model binary in the base package.
- No MathLive import.
- No direct camera-to-solve path.

## Protected surfaces

Keyboard, long-press, MORE/template tray, MathLive production files, Graph, Result, Solution, History, solver/evaluator, splash/startup, launcher icon, AppShell, main, MainActivity, and AndroidManifest runtime behavior are not changed in Q239D.

## Evidence

Static verifier: `node tool/verify_deferred_math_ocr_model_manager_v172_q239d.mjs`.

Flutter/Dart/Android PASS is not claimed without user-side logs.
