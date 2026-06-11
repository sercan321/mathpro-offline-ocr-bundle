# V172-Q301 — Product Development Track Rebase / Store Track Park Audit

## Purpose

Q301 records the user's explicit direction that Play Store preparation is **not** the active target yet. Q299/Q300 remain historical audit/freeze contracts only. The active workstream returns to product development, real PP-FormulaNet-S OCR runtime readiness, premium UI/UX, MathLive input quality, and real-device QA.

## Runtime Boundary

This phase does **not** add Paddle, PaddleOCR, JNI, MethodChannel runtime binding, native runtime handler implementation, model binary, production model download, image-to-LaTeX inference, editable review runtime binding, workspace import runtime binding, or store/release work.

## Store Track Parked

The following are intentionally parked:

- Play Store listing
- Privacy policy authoring
- Data Safety form
- Store screenshots / feature graphic
- Closed testing track
- Release AAB/APK
- Production release submission

## Active Product Track

The active track is product-first:

- real PP-FormulaNet-S source/SHA/runtime path
- default-off runtime dependency trial only when evidence is ready
- private model download + SHA verification
- private artifact load real-device smoke
- runtime startup real-device smoke
- first real image-to-LaTeX inference only after runtime evidence exists
- OCR candidate → editable MathLive review
- approved OCR → workspace import
- MathLive input/caret/latency real-device quality
- workspace/keyboard/graph/solution/history premium QA

## Protected Surfaces

Q301 preserves keyboard layout, MORE/template tray, long-press lists, MathLive production route/bridge, Graph, Solution, History, AppShell, Workspace runtime, Camera shell runtime, AndroidManifest, MainActivity, splash/icon, pubspec dependencies, and Android toolchain.

## Evidence Boundary

No Flutter analyze/test/run, Android real-device, OCR, store-ready, release, or premium-final PASS is claimed by this package. Those require real user-side logs and device evidence.
