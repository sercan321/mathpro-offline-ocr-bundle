# V172-Q296 — OCR Result Editable MathLive Review Real Runtime Audit

## Phase

Q296 — OCR Result Editable MathLive Review Real Runtime

## Source Phase

Q295 — First Real Image-to-LaTeX Inference

## Purpose

Q296 adds the next guarded contract in the PP-FormulaNet-S Camera/OCR chain: a future runtime image-to-LaTeX candidate must open as an editable MathLive review draft before any workspace import is even prepared.

This phase is intentionally contract-only. It does not open a real editable MathLive review, does not bind OCR output to the production MathLive editor, does not run OCR inference, and does not mutate workspace state.

## Runtime Boundary

Q296 keeps the real runtime boundary closed:

- no Paddle runtime
- no PaddleOCR dependency
- no JNI/native handler
- no MethodChannel runtime binding
- no native runtime startup
- no model binary
- no production download worker
- no real image-to-LaTeX inference
- no real editable MathLive review opening
- no workspace mutation
- no direct Solve / Graph / Solution / History from camera output
- no OCR PASS
- no review-binding PASS
- no Camera/OCR runtime PASS
- no store-ready PASS
- no release PASS

## Review Contract

Q296 defines a review draft envelope with these core fields:

- review id
- source inference request id
- capture id
- engine label
- source phase
- editable LaTeX draft
- primary LaTeX candidate
- alternative candidates
- confidence
- warnings
- engine metadata
- crop metadata
- image SHA256
- review feature flag state
- user approval requirement
- direct workspace mutation guard

The review draft must stay editable. The user must be able to correct OCR output before approval. Workspace import may be prepared only after explicit user approval in a later phase.

## Protected Surfaces

Q296 does not change keyboard layout, MORE/template tray, long-press lists, MathLive production route, MathLive bridge, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, camera dependencies, or Android toolchain.

## Evidence Requirements Before Future Real Review Binding

A future phase must provide real evidence for:

- Q295 real image-to-LaTeX candidate
- primary LaTeX candidate
- alternative candidates
- confidence/warnings/engine metadata
- crop and image metadata
- image SHA256
- editable MathLive review UI opening
- editability/correction behavior
- explicit user approval boundary
- direct workspace import block
- direct Solve / Graph / Solution / History block
- Flutter analyze/test/run logs
- real-device review flow evidence

## Honest Claim Boundary

Q296 is static/verifier/fresh-extract only. Real Flutter/Android/device behavior must be proven by user-side logs.
