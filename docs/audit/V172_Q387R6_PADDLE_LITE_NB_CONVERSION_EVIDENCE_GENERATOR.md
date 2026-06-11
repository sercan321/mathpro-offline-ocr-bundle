# V172-Q387R6 — Paddle Lite .NB Conversion Evidence Generator

## Scope

Q387R6 continues the Q387 → Q387R5 Android Paddle Lite `.nb` line. Q387R5 can intake an external `.nb` artifact, but it still needs trustworthy local conversion/build evidence. Q387R6 adds that evidence generator and repairs a static compile-risk observed during the fresh extract review.

This phase does **not** convert a model inside the Flutter app, bundle a `.nb`, invent a URL/SHA, claim OCR inference, or claim real-device/build PASS.

## What changed

- Added `lib/features/camera/gauss_paddle_lite_nb_conversion_evidence_generator_q387r6.dart`.
- Added `tool/generate_q387r6_paddle_lite_nb_conversion_evidence.mjs`.
- Added `test/v172_q387r6_paddle_lite_nb_conversion_evidence_generator_test.dart`.
- Added `tool/verify_paddle_lite_nb_conversion_evidence_generator_v172_q387r6.mjs`.
- Updated `gauss_deferred_math_ocr_model_manager.dart` with Q387R6 phase constants and compile-risk repairs.
- Updated `assets/mathlive/manifest.json` and `README.md`.

## Evidence generator contract

The generator requires:

- Source model id: `pp_formulanet_s`.
- Immutable source revision, not `main`, `master`, `latest`, or `head`.
- Source inference directory containing:
  - `config.json`
  - `inference.json`
  - `inference.yml`
  - `inference.pdiparams`
- Local converted `.nb` file.
- Conversion log file.
- Exact conversion command containing `paddle_lite_opt`, `--optimize_out`, and `--valid_targets=arm`.
- Conversion tool version.
- Immutable HTTPS `.nb` download URL ending in `.nb`.
- Conversion provenance text.
- Explicit reviewer approval and production-hosted-source approval.

The tool computes:

- SHA256 and size for all required source inference files.
- SHA256 and size for the local `.nb` artifact.
- SHA256 digest of the conversion log.

It writes a Q387R5-compatible evidence JSON for:

```text
node tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs <evidence.json> <local.nb>
```

## Compile-risk repair found during Q387R6

Fresh extract review found that `gauss_deferred_math_ocr_model_manager.dart` had a broken Q387R2 install method signature and Q387R4/Q387R5 product-copy strings with apostrophe risk. Q387R6 restores the `installVerifiedPaddleLiteNbModelQ387R2` method signature and converts the affected copy strings to safe Dart strings.

## Explicit non-claims

- No `.nb` file is included.
- No `.pdiparams`, `.pdmodel`, `.onnx`, `.tflite`, `.safetensors`, `.apk`, `.aab`, `.part`, or `.tmp` is bundled.
- ONNX Runtime is not reintroduced.
- Q382 keyboard ordering is not changed.
- MORE, long-press, MathLive caret authority, Graph, History, Solution/Solver, splash/startup, AndroidManifest, and Gradle ABI policy are not changed.
- Flutter analyze/test/run PASS is not claimed unless real tool logs are supplied.
- OCR/camera/workspace PASS is not claimed until a real `.nb` is generated, hosted, accepted by Q387R5, installed by Q387R2, loaded by native Paddle Lite, and proven on device.

## User-side command template

```powershell
cd $env:USERPROFILE\Desktop\MathProFlutterPhase17

node tool/generate_q387r6_paddle_lite_nb_conversion_evidence.mjs `
  --source-dir "C:\Path\To\PP-FormulaNet-S" `
  --output-nb "C:\Path\To\pp_formulanet_s_arm64.nb" `
  --conversion-log "C:\Path\To\q387r6_conversion.log" `
  --source-revision "0572450e501be9eb1b1cdb7e00fccf4b22fab4df" `
  --conversion-tool-version "2.14" `
  --conversion-command "paddle_lite_opt --model_file=inference.pdmodel --param_file=inference.pdiparams --optimize_out=pp_formulanet_s_arm64 --valid_targets=arm --optimize_out_type=naive_buffer" `
  --download-url "https://your-immutable-host.example/releases/0572450e501be9eb1b1cdb7e00fccf4b22fab4df/pp_formulanet_s_arm64.nb" `
  --provenance "audited local paddle_lite_opt conversion from pinned PP-FormulaNet-S revision" `
  --reviewer-approved `
  --production-hosted

node tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs tool/reports/q387r6_paddle_lite_nb_conversion_evidence.json "C:\Path\To\pp_formulanet_s_arm64.nb"
```

## Next phase

Q388 remains blocked until Q387R6 evidence is generated from a real `.nb`, Q387R5 accepts it, Q387R2 installs it, and device logs prove the native Paddle Lite load/inference path.
