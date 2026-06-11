# V172 Q352 — ONNX Conversion Evidence Acceptance / Runtime Strategy Pivot Gate Audit

## Scope

Q352 accepts user-side PP-FormulaNet-S ONNX conversion evidence and pivots the runtime strategy from a blocked Paddle Lite `.nb`-only path toward a default-off ONNX Runtime Mobile candidate.

## Accepted external evidence

- Official PP-FormulaNet-S PaddleOCR/PaddleX model was downloaded outside the Flutter project.
- `paddle2onnx` conversion succeeded using explicit `inference.json` and `inference.pdiparams` filenames.
- ONNX output file exists outside the Flutter project:
  - `../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx`
- ONNX size: `308743097` bytes.
- ONNX SHA256: `6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a`.

## Intentional non-goals

Q352 does not add ONNX Runtime Mobile, does not bundle the 308 MB ONNX model into the app, does not copy the model into app-private storage, does not load a model, does not run inference, does not open OCR review, and does not import anything into the workspace.

## Runtime strategy state

- Paddle Lite `.jar/.so` bundle from Q344 is preserved.
- Paddle Lite `.nb` artifact is still unavailable.
- Paddle Lite model load remains blocked.
- ONNX Runtime Mobile is opened as the next runtime candidate, but no dependency is added in Q352.

## Red-line file impact

Q352 does not modify `MainActivity.kt`, Gradle, pubspec, AndroidManifest, workspace, keyboard, MORE/template tray, long-press, MathLive production bridge/editor, Graph, Solution, History, splash/icon, or solver/evaluator files.
