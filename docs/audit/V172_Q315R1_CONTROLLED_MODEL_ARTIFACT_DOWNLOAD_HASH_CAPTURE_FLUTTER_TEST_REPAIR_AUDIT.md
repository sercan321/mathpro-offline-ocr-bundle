# V172-Q315R1 Controlled Model Artifact Download Hash Capture Flutter Test Repair Audit

Phase: `V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR`
Source phase: `V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE`

## User-side failure repaired

The user ran `flutter test` and hit a failure in:

`test/v172_q315_controlled_model_artifact_download_hash_capture_test.dart`

The failing assertion expected the capture script to contain the exact literal:

`../MathProOcrArtifacts/PP-FormulaNet-S`

The Q315 script was semantically correct because it used `path.resolve(projectRoot, '..', 'MathProOcrArtifacts', MODEL_NAME)`, but the Flutter test was intentionally checking for the explicit user-facing outside-project artifact directory policy. Q315R1 repairs this by adding `DEFAULT_OUTPUT_DIR_POLICY = '../MathProOcrArtifacts/PP-FormulaNet-S'` and resolving the output directory from that constant.

## Runtime boundary

Q315R1 is a Flutter-test repair only. It does not add Paddle/PaddleOCR/Paddle Lite/ONNX/TFLite dependencies, does not mutate Android runtime files, does not download or bundle the model artifact, does not compute local SHA in the assistant environment, does not accept the model for runtime, and does not claim OCR PASS.

## Protected surfaces

Keyboard, MORE, long-press, MathLive production bridge, workspace, camera shell runtime, Graph, Solution, History, AppShell, splash, icon, AndroidManifest, MainActivity, and pubspec remain protected.
