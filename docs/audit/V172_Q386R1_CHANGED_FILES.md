# V172 Q386R1 Changed Files

## Added

- `lib/features/camera/gauss_camera_ocr_candidate_review_workspace_import_binding_q386r1.dart`
- `test/v172_q386r1_camera_ocr_candidate_review_workspace_import_binding_test.dart`
- `tool/verify_camera_ocr_candidate_review_workspace_import_binding_v172_q386r1.mjs`
- `docs/audit/V172_Q386R1_OCR_CANDIDATE_REVIEW_WORKSPACE_IMPORT_BINDING.md`
- `docs/audit/V172_Q386R1_CHANGED_FILES.md`

## Modified

- `lib/features/camera/gauss_mathlive_ocr_review_surface.dart`
  - Adds Q386R1 gate around candidate review and explicit workspace import.
  - Keeps import disabled until real candidate + editable draft + non-empty reviewed LaTeX + callback are available.
- `assets/mathlive/manifest.json`
  - Adds Q386R1 audit markers without claiming OCR/workspace PASS.

## Explicitly not modified

- Q382 keyboard/order/latency behavior untouched.
- MORE/template tray and long-press untouched.
- Graph, History, Solution/Solver untouched.
- ONNX Runtime not restored.
- No OCR model artifact bundled in base APK.
- Gradle/ABI and AndroidManifest untouched by Q386R1.

Q382 keyboard untouched.
