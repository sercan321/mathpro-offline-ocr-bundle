# V172-Q133 — Main Editor MathLive Runtime Activation Audit

Q133 responds to the real-device finding that legacy Flutter/MathJax cursor-coordinate repairs did not change the main editor behavior. This phase mounts the local official MathLive runtime as the visible main editor surface behind an internal runtime flag and keeps the legacy Flutter slot editor as rollback.

## What changed

- Added a minimal `assets/mathlive/main_editor.html` surface for the main workspace.
- Added `MathLiveMainEditorSurface` and `MathLiveMainEditorRuntimeController`.
- Routed MathPro keyboard labels to the MathLive bridge when the main MathLive surface is active.
- Synced MathLive bridge state back into `CalculatorController` for result/history/graph continuity.
- Kept the legacy editor path present as rollback.

## What did not change

- Keyboard layout files were not modified.
- MORE and long-press files were not modified.
- Graph, History, and Solution UI files were not modified.
- Legacy cursor files were not deleted.
- No cursor PASS, release PASS, or fake device evidence is claimed.

## Device expectation

The visible editor should no longer use the legacy Flutter caret overlay. If official MathLive vendor files are installed with `node tool/install_mathlive_runtime.mjs`, tapping inside the expression should use MathLive's own caret and selection behavior.
