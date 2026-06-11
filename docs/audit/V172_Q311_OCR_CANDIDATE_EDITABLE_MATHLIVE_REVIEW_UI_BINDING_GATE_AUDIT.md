# V172-Q311 — OCR Candidate → Editable MathLive Review UI Binding Gate Audit

## Scope

Q311 adds a package-side/static contract for a future PP-FormulaNet-S OCR candidate to be shown in an editable MathLive review surface.

This is not a real review UI runtime phase. Q311 does **not** open the MathLive review UI, does **not** call MethodChannel, does **not** invoke native runtime, does **not** parse a native LaTeX response, does **not** import into the workspace, and does **not** run OCR.

## Required Future Evidence

- Q310 first real image-to-LaTeX inference evidence.
- Native LaTeX candidate envelope.
- Sanitized candidate LaTeX.
- Alternative candidates preserved.
- Confidence/warnings preserved.
- Crop/preprocess metadata preserved.
- Editable MathLive review draft evidence.
- User edit capability evidence.
- Explicit user approval evidence before workspace import.
- Real Android device review UI log.

## Locked Safety Rules

- OCR candidate cannot go directly to workspace.
- OCR candidate cannot trigger solve, graph, Solution, or History.
- OCR candidate cannot be auto-approved.
- Review must be editable.
- User approval is mandatory.
- No OCR/runtime/store/release PASS may be claimed from this static package.

## Runtime Boundaries

Q311 intentionally does not modify keyboard, MORE/template tray, long-press lists, MathLive production route, MathLive bridge, Graph, Solution, History, AppShell, workspace runtime, camera shell runtime, AndroidManifest, MainActivity, splash/icon, solver/evaluator, pubspec, camera dependency, or Android toolchain.
