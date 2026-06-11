# V172-Q387R7 — Paddle Lite .NB User-Side Conversion Protocol

## Scope

Q387R7 packages the user-side PowerShell protocol that turns a real local PP-FormulaNet-S Paddle inference directory plus a real `paddle_lite_opt` executable into a local Android Paddle Lite `.nb` artifact, then invokes the Q387R6 evidence generator and Q387R5 intake checker.

This phase is intentionally not an OCR runtime phase. It does not execute conversion inside the Flutter app, does not bundle `.nb`, does not invent URL/SHA values, does not reintroduce ONNX Runtime, and does not claim Flutter, Android, camera, OCR, APK/AAB, or real-device PASS.

## New artifacts

- `lib/features/camera/gauss_paddle_lite_nb_user_side_conversion_protocol_q387r7.dart`
- `test/v172_q387r7_paddle_lite_nb_user_side_conversion_protocol_test.dart`
- `tool/generate_q387r7_paddle_lite_nb_user_conversion_protocol.mjs`
- `tool/verify_paddle_lite_nb_user_side_conversion_protocol_v172_q387r7.mjs`

## Protocol chain

The generated PowerShell script performs these user-side steps only after the user supplies real local paths:

1. Verify the PP-FormulaNet-S source directory contains `config.json`, `inference.json`, `inference.yml`, and `inference.pdiparams`.
2. Verify `paddle_lite_opt` exists.
3. Run `paddle_lite_opt --model_dir ... --optimize_out ... --valid_targets=arm --optimize_out_type=naive_buffer`.
4. Verify the `.nb` output file exists.
5. Call `tool/generate_q387r6_paddle_lite_nb_conversion_evidence.mjs`.
6. Call `tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs` with the generated evidence JSON and local `.nb` file.

## Guardrails

Q387R7 rejects:

- missing protocol input,
- mutable source revisions such as `main`, `master`, `latest`, or `head`,
- non-`.nb` output file names,
- non-HTTPS or mutable hosted `.nb` URLs,
- missing reviewer/production-hosting approval,
- command sequences that do not include the Q387R6 generator and Q387R5 intake tool,
- any model binary bundled into the base app.

## Protected scope

Q387R7 does not touch keyboard layout/order/labels, Q382 ordering pipeline, MORE/template tray, long-press inventory, MathLive caret authority, Graph, History, Solution/Solver, AndroidManifest, Gradle ABI policy, splash/startup, or the download-only APK/AAB model-bundling contract.

## Remaining blocker

Q388 real inference is still blocked until the user-side Q387R7 script is executed successfully, Q387R6 evidence is generated, Q387R5 intake accepts the local `.nb`, Q387R2 installs the `.nb`, and real-device logs prove Paddle Lite model load and `predictor.run()` execution.
