# V172-Q387R5 — Paddle Lite .NB External Artifact Intake Closure

## Purpose

Q387R5 closes the handoff between the Q387R3/Q387R4 evidence gates and the Q387R2 download/install worker. It accepts an externally produced or hosted PP-FormulaNet-S Paddle Lite `.nb` candidate only when the source evidence is immutable, reviewer-approved, and optionally matches a local file SHA/size check.

## What changed

- Added `GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate`.
- Added a Node intake tool: `tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs`.
- Added a static test court for missing evidence, mutable URLs, non-immutable revisions, optional local file digest match, and digest mismatch.
- Added manager entry points that can evaluate external artifact evidence and, only after acceptance, pass the resulting source into the existing Q387R2 worker.
- Added manifest and README markers for static verifier continuity.

## Required external evidence

The external evidence JSON must provide:

- `sourceModelId: pp_formulanet_s`
- immutable `sourceModelRevision`
- source inference files: `config.json`, `inference.json`, `inference.yml`, `inference.pdiparams`
- `conversionTool: paddle_lite_opt`
- conversion tool version
- `androidTarget: android-arm64-v8a`
- exact conversion command containing `paddle_lite_opt` and `--optimize_out`
- conversion log digest
- `.nb` output filename
- output SHA256
- output byte size
- immutable HTTPS `.nb` download URL
- conversion provenance
- explicit reviewer approval
- production hosting approval
- `bundledInBaseApp: false`

## Safety boundaries

Q387R5 does not bundle `.nb`, `.onnx`, `.pdmodel`, `.pdiparams`, `.tflite`, or other model binaries. It does not reintroduce ONNX Runtime. It does not claim OCR inference, Android real-device PASS, APK/AAB size PASS, or Flutter analyze/test PASS. It does not touch keyboard/Q382, MORE, long-press, MathLive caret authority, Graph, History, Solution/Solver, splash/startup, AndroidManifest, or Gradle ABI behavior.

## Blocked reasons

- `q387r5-external-nb-artifact-evidence-required`
- `q387r5-explicit-reviewer-approval-required`
- `q387r5-immutable-source-revision-required`
- `q387r5-mutable-download-url-rejected`
- `q387r5-local-nb-file-sha-size-evidence-required`
- `q387r5-local-nb-file-sha-size-mismatch`
- `q387r5-q387r4-production-binding-rejected`

## Next phase

Q388 real Paddle Lite inference can only start after a real immutable `.nb` source is supplied, Q387R5 accepts it, Q387R2 installs it, and device evidence confirms model load and `predictor.run()` execution.
