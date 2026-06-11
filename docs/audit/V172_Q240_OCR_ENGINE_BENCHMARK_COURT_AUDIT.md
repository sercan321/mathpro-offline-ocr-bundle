# V172-Q240 — OCR Engine Benchmark Court Foundation Audit

## Scope

Q240 prepares the benchmark court contract for choosing the future free/offline math OCR engine without binding any engine to production.

## Implemented

- Added `GaussOcrEngineBenchmarkCourtPolicy`.
- Added `GaussOcrEngineBenchmarkCourt` candidate registry.
- Registered benchmark-only candidate families:
  - PP-FormulaNet-S
  - PP-FormulaNet_plus-S
  - Pix2Text MFR ONNX
  - UniMERNet tiny
  - TexTeller
  - Plain text OCR fallback
- Added required benchmark case taxonomy for arithmetic, equations, powers/subscripts, roots, fractions, trigonometry, integrals, derivatives, limits, sigma, matrices, handwriting, low-light, skewed, and blurred captures.
- Added scoring dimensions for LaTeX exactness, integral limits, derivative notation, fraction/radical structure, model size, speed, RAM, offline viability, Android binding risk, and license/distribution risk.
- Added Q240 test/verifier and manifest metadata.

## Explicitly Not Implemented

- No OCR runtime.
- No plain text OCR dependency.
- No PaddleOCR / Paddle runtime.
- No Pix2Text runtime.
- No ONNX runtime.
- No TexTeller runtime.
- No UniMERNet runtime.
- No model binary in the base app.
- No production model URL.
- No background download worker.
- No production MathLive bridge call.
- No direct workspace import.
- No direct solve/evaluate/graph/history from camera.
- No benchmark winner selection.

## Protected Areas

Keyboard, MORE, long-press, MathLive production files, Graph, Result, Solution, History, solver/evaluator, splash/startup, launcher icon, AppShell, main, Android startup, and AndroidManifest were not modified by Q240.

## Honest Boundary

This phase is static/contract foundation only. It does not prove OCR accuracy, Android runtime OCR viability, Flutter analyze/test/run, or real-device camera/OCR behavior.
