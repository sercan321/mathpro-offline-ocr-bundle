# V172-V172-Q250-OCR-MATHLIVE-REVIEW-IMPORT / Q250 — OCR → MathLive Review Import Audit

## Scope

Q250 connects the Q249 PP-FormulaNet-S adapter envelope to a review-first MathLive import contract. The goal is to let future OCR candidates become editable MathLive review drafts while preserving the hard rule that camera OCR output never goes directly to workspace, solve, graph, solution, or history.

## Implemented

- Added `GaussOcrMathLiveReviewImportPolicy`.
- Added `GaussOcrMathLiveReviewImport` contract.
- Added editable MathLive candidate draft shape with original LaTeX, edited LaTeX, confidence, engine label, and warnings.
- Added Q249 adapter envelope gate.
- Added primary-candidate-required gate.
- Added user approval gate before workspace import readiness.
- Preserved candidate alternatives, confidence, and warning metadata.
- Updated MathLive OCR review draft data model so Q250 review imports remain blocked until explicit user approval.
- Repaired duplicate `draft` field in the review surface class while preserving runtime behavior for pending OCR review.

## Explicitly not implemented

- No real PP-FormulaNet-S inference.
- No Paddle runtime.
- No PaddleOCR dependency.
- No PP-FormulaNet-S model binary in base APK.
- No production model URL.
- No production download worker.
- No direct workspace import.
- No direct solve.
- No direct graph.
- No direct solution write.
- No direct history write.
- No production MathLive bridge call.

## Protected surfaces

Q250 is intended to preserve keyboard, MORE, long-press, MathLive production editor, Graph, Solution, History, AppShell, `main.dart`, Android manifest, MainActivity, camera dependency line, Kotlin plugin, and AGP line. The verifier checks these surfaces.

## Evidence boundary

This is a static/verifier package phase. Flutter analyze/test/run, Android real-device behavior, PP-FormulaNet-S runtime inference, and OCR accuracy are not claimed by the assistant without user-side logs or real runtime evidence.

Marker summary: V172-Q250-OCR-MATHLIVE-REVIEW-IMPORT, Q250, PP-FormulaNet-S, editable review, user approval, no Paddle runtime, no model binary.
