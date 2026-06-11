# V172-Q315 Controlled Model Artifact Download Hash Capture Audit

## Phase

V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE

## Source Phase

V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN

## Purpose

Q315 records the controlled PP-FormulaNet-S artifact download and hash-capture boundary without pretending that the assistant environment downloaded the model. The Hugging Face repository file inventory and the published large-file SHA256 for `inference.pdiparams` are recorded as remote evidence only. Local runtime acceptance remains blocked until the user runs the controlled capture script, stores the artifact outside the project root, computes SHA256 from the real local file, and verifies that it matches the published hash.

## Remote Artifact Evidence Recorded

- Repository: `hf://PaddlePaddle/PP-FormulaNet-S`
- License label: `apache-2.0`
- Repository size label: `238 MB`
- Primary required runtime artifact: `inference.pdiparams`
- Primary artifact size label: `232 MB`
- Published large-file SHA256: `b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489`
- Published Xet hash: `704471ae47042d516484ce674f8e0973c3aa1e45db9f4f7e7bd1e22952c4527f`

## Controlled Capture Script

`tool/capture_pp_formulanet_s_artifact_hash_v172_q315.mjs`

Default artifact output directory:

`../MathProOcrArtifacts/PP-FormulaNet-S`

This is deliberately outside the project root so the model binary is not committed into the app package ZIP.

## Honest Boundary

The assistant container could not perform the real download because external DNS/network access was unavailable. Therefore Q315 does not claim local artifact SHA computation, runtime acceptance, runtime startup, dummy call, image-to-LaTeX inference, editable MathLive review, workspace import, camera/OCR runtime PASS, Android real-device PASS, store PASS, or release PASS.

## Runtime Boundaries Preserved

Q315 does not add Paddle, PaddleOCR, Paddle Lite, ONNX Runtime, TFLite, WorkManager, downloader dependencies, JNI/native handler, MethodChannel runtime binding, MainActivity mutation, AndroidManifest mutation, pubspec mutation, model binary, production downloader, private storage implementation, runtime load, runtime startup, dummy runtime call, image-to-LaTeX inference, editable MathLive review, workspace import, auto solve, Graph write, Solution write, or History write.

## Next Phase

Q316 may begin only after local artifact evidence exists and its SHA256 matches the recorded published hash. Q316 must remain default-off and rollback-safe.
