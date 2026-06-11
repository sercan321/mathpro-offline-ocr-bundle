# V172-Q251 Changed Files

## Added

- `lib/features/camera/gauss_camera_math_ocr_end_to_end_court_policy.dart`
- `lib/features/camera/gauss_camera_math_ocr_end_to_end_court.dart`
- `test/v172_q251_camera_math_ocr_end_to_end_court_test.dart`
- `tool/verify_camera_math_ocr_end_to_end_court_v172_q251.mjs`
- `docs/audit/V172_Q251_CAMERA_MATH_OCR_END_TO_END_COURT_AUDIT.md`
- `docs/audit/V172_Q251_CHANGED_FILES.md`

## Updated

- `assets/mathlive/manifest.json`
- `README.md`

## Runtime Boundary

The active camera shell remains pending/review-only. Q251 adds the end-to-end court guard and does not bind OCR inference, production MathLive bridge calls, workspace mutation, solve, graph, solution, or history.
- `tool/verify_ocr_mathlive_review_import_v172_q250.mjs` — successor-aware metadata hygiene so Q250 accepts Q251 as the active camera OCR successor without changing Q250 runtime behavior.
