# V172-Q239A — Workspace Camera Entry Button Replacement Audit

## Scope

Q239A is a surgical workspace action-row phase. It replaces the inert top-row ellipsis action with a camera entry button in the same slot and visual shell.

## Runtime Change

- `lib/features/workspace/workspace_panel.dart` now uses `mathpro-workspace-camera-entry-button` in the previous rightmost action slot.
- The icon is `Icons.photo_camera_outlined` with tooltip `Kamera` and semantic label `Kamera ile ifade tara`.
- Pressing the button opens a premium placeholder sheet explaining that advanced math OCR will be enabled in a later phase and that photo output will first be reviewed inside MathLive.

## Explicit Non-Goals

- No `camera` package dependency.
- No Android camera permission.
- No camera preview.
- No OCR engine.
- No model download manager.
- No Text OCR fallback, PaddleOCR, Pix2Text, ONNX, or solver integration.
- No direct camera-to-solve path.

## Red-Line Preservation

The phase does not intentionally mutate keyboard layout/source, long-press popup/source/order, MORE/template tray, MathLive production HTML/bridge/surface, Graph, Result, Solution, History, solver/evaluator, splash/startup, launcher icon, or AndroidManifest behavior.

## Honest Evidence Boundary

This is a static/source package change. Flutter analyze/test/run and real Android camera/UI behavior require user-side logs and device evidence before any PASS claim.
