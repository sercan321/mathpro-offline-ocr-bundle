# V172-Q286 — Full Camera/OCR Runtime Premium Regression Audit

Q286 adds a full Camera/OCR runtime premium regression court after Q285. This is still a gate-only/static package phase. It does not run PP-FormulaNet-S, does not invoke a native bridge, does not load a real model, and does not execute image-to-LaTeX inference.

## Scope

- Require Q278 → Q285 chain continuity before any future full Camera/OCR runtime regression PASS claim.
- Preserve keyboard layout, MORE/template tray, long-press lists, MathLive production route, Camera shell, Graph, Solution, History, AppShell, workspace, splash/icon, Android manifest/activity, camera dependencies, and Android toolchain.
- Verify review-first flow remains mandatory: camera/crop candidate → editable MathLive review → explicit user approval → future workspace import envelope only.
- Keep automatic Evaluate/Solve/Graph/Solution/History writes blocked from camera/OCR output.
- Keep model/native/runtime binaries out of the base package.

## Runtime Boundary

No real runtime is added in Q286. The following remain absent: Paddle runtime, PaddleOCR dependency, JNI binding, Android native handler, MethodChannel runtime binding, PP-FormulaNet-S model binary, production model URL, production downloader, real image-to-LaTeX inference, OCR PASS, Camera/OCR runtime PASS, premium final PASS, and release PASS.

## Required Future Evidence

Q286 can only be closed as a real full runtime regression after real Flutter analyze/test/run logs, real Android device evidence, Q282 runtime smoke evidence, Q283 image-to-LaTeX candidate evidence, Q284 editable MathLive review evidence, Q285 approved workspace import envelope evidence, and direct-solve/direct-graph/direct-history block evidence are supplied.
