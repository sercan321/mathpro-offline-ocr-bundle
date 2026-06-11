# V172-Q387R1 Changed Files

## Added

- `lib/features/camera/gauss_paddle_lite_nb_artifact_manifest_q387r1.dart`
  - Defines the strict `.nb` artifact manifest/evidence gate.
  - Blocks missing URL/SHA/size/provenance and base-app bundling.
  - Does not claim that a production `.nb` artifact exists.

- `test/v172_q387r1_paddle_lite_nb_artifact_manifest_evidence_gate_test.dart`
  - Verifies that Q387R1 blocks without a real `.nb` candidate.
  - Verifies that non-`.nb` files and non-HTTPS placeholder URLs are rejected.
  - Verifies that only a download-only `.nb` candidate with SHA/size/provenance is accepted for the next download/install phase.

- `tool/verify_paddle_lite_nb_artifact_manifest_evidence_v172_q387r1.mjs`
  - Static verifier for Q387R1 policy, docs, manifest, native bridge markers, and forbidden model artifacts.

- `docs/audit/V172_Q387R1_PADDLE_LITE_NB_ARTIFACT_MANIFEST_EVIDENCE_GATE.md`
  - Audit summary for the Q387R1 decision.

- `docs/audit/V172_Q387R1_CHANGED_FILES.md`
  - This file.

## Modified

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
  - Adds Q387R1 constants and user-facing blocked messages.
  - Adds `q387R1ValidateNbManifestEvidence`.
  - Requires adjacent `q387r1_paddle_lite_nb_manifest.json` before any `.nb` can be passed to `MobileConfig.setModelFromFile`.
  - Emits `q387R1NbManifestEvidence` in the OCR evidence map.
  - Keeps fake OCR blocked.

- `lib/features/camera/gauss_deferred_math_ocr_model_manager.dart`
  - Adds Q387R1 manifest/evidence constants to the deferred model manifest copy.
  - Makes model status copy honest: legacy inference-directory verification is not enough for Android Paddle Lite real OCR; `.nb` evidence is required.

- `assets/mathlive/manifest.json`
  - Records Q387R1 as the latest `.nb` artifact manifest/evidence phase.
  - Records that production `.nb` URL/SHA/size are not bound in this package.
  - Records that no `.nb` model is bundled in the base app.

- `README.md`
  - Adds the Q387R1 status and non-claims.


## Not changed

- Keyboard/Q382 ordering pipeline
- Keyboard layout/order/labels
- MORE/template tray
- Long-press lists
- MathLive caret authority
- Graph/History/Solution/Solver semantics
- ONNX Runtime is not reintroduced
- No `.nb`, `.pdiparams`, `.onnx`, `.tflite`, `.safetensors`, APK, or AAB is added
