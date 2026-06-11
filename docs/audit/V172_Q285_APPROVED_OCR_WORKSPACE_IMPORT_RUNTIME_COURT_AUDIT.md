# V172-Q285 — Approved OCR Workspace Import Runtime Court Audit

Q285 adds a court/gate for the future transition from an accepted editable MathLive review draft to a workspace import envelope.

This phase is intentionally not a real OCR/runtime import phase. It does not execute workspace mutation, does not evaluate, does not solve, does not graph, and does not write Solution/History records. It only defines the approval, metadata-preservation, and no-auto-action gates that must be satisfied before a future runtime import can be trusted.

## Guarded requirements

- Q284 real MathLive review runtime-binding evidence must exist.
- The editable MathLive review draft must be accepted.
- The user must explicitly approve the reviewed LaTeX before import preparation.
- The import envelope must preserve review metadata, engine metadata, confidence/warnings, and image-input metadata.
- Workspace mutation remains blocked in this package.
- Any solve, graph, solution, or history action must remain manual after import.
- No OCR/runtime/Premium/release PASS is claimed without real device evidence.

## Explicit non-goals

- No Paddle runtime.
- No PaddleOCR dependency.
- No native Android handler.
- No JNI binding.
- No MethodChannel runtime binding.
- No PP-FormulaNet-S model binary.
- No production model URL or download worker.
- No real image-to-LaTeX inference.
- No direct OCR-to-workspace mutation.
- No automatic solve, graph, Solution, or History write.
