# V172 Q386R1 — OCR Candidate Review Workspace Import Binding

## Scope

Q386R1 hardens the user-visible handoff from a real decoded OCR candidate to editable review and explicit workspace import.

This phase does not claim OCR PASS, workspace import PASS, real-device PASS, or build PASS. It does not add ONNX Runtime, does not bundle model artifacts, and does not modify keyboard/Q382, MORE, long-press, Graph, History, Solution/Solver, Gradle/ABI, AndroidManifest, splash, icon, or app startup flow.

## Contract

- A real decoded candidate is required before the import button can submit.
- An editable review draft is required.
- The reviewed LaTeX must be non-empty.
- A workspace import callback must be available.
- Explicit user approval is required.
- Direct camera-to-workspace import remains blocked.
- Auto evaluate, auto graph, auto solution, and auto history remain blocked.
- The approved import route stays AppShell-approved OCR import and MathLive `setLatexFromApprovedOcrImport`.

## Runtime behavior

Q386R1 adds a small Dart gate around `GaussMathLiveOcrReviewSheet` so the workspace import button is enabled only when review/import preconditions are satisfied. It also keeps the visible button copy and semantics aligned with the current action state.

## No PASS claim

No OCR or workspace PASS is claimed by this package. Q386R1 only proves the review/import state machine is wired defensively at source/verifier level. Flutter analyze/test/run and Android device evidence are still required.


Verifier marker: reviewed non-empty candidate + explicit user approval + no direct camera-to-workspace import.

Q382 keyboard untouched.
