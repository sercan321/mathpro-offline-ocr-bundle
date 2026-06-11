# V172-Q382R11 Workspace Context Menu Analyze / Q239B Copy Expectation Repair Audit

## Phase
V172-Q382R11-WORKSPACE-CONTEXT-MENU-ANALYZE-Q239B-COPY-EXPECTATION-REPAIR

## Scope
This is a user-log-driven analyzer/test expectation repair on top of Q382R10.

## Repairs
- Converted Q277R1 local sheet marker declarations from `final` to `const` to remove `prefer_const_declarations` analyzer infos.
- Made Q239B workspace camera invocation expectation successor-aware for the current multiline `_openCameraCaptureShell(` invocation that passes `onApprovedLatexImport`.
- Kept Q239C legacy/current OCR review copy expectations successor-aware for Q239C through Q382R11.

## Runtime behavior
No runtime behavior was intentionally changed.

## Protected surfaces
Keyboard, MORE/template tray, long-press, MathLive production assets, Q381R1 OCR native/runtime/camera flow, Graph, History, solver/evaluator, splash/icon, pubspec, AndroidManifest, Gradle, and MainActivity were not modified.

## PASS boundary
No assistant-side Flutter analyze/test/run PASS is claimed. User-side rerun is required.
