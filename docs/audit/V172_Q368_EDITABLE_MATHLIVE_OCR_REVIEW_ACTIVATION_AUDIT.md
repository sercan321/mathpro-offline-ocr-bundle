# V172-Q368 Editable MathLive OCR Review Activation Audit

Q368 prepares an explicit-invocation-only editable MathLive OCR review activation handoff. It does not auto-open review UI, does not import workspace, and does not trigger Solve/Graph/Solution/History.

## Guard Rules

- OCR candidate must come from Q367 candidate envelope.
- Candidate LaTeX must be non-empty before review handoff can be accepted.
- Editable MathLive review is required before import.
- Explicit user approval is required before any workspace import.
- Direct OCR-to-workspace/Solve/Graph/Solution/History remains blocked.

## Red Lines

Keyboard, MORE, long-press, MathLive production editor, workspace UI, Graph, Solution, History, splash/icon, solver/evaluator, pubspec, Gradle, and AndroidManifest are not modified by Q368. MainActivity is modified only for the explicit review handoff bridge.
