# V172-Q252 Changed Files

Added:

- `lib/features/camera/gauss_camera_ocr_premium_final_regression_policy.dart`
- `lib/features/camera/gauss_camera_ocr_premium_final_regression.dart`
- `test/v172_q252_camera_ocr_premium_final_regression_test.dart`
- `tool/verify_camera_ocr_premium_final_regression_v172_q252.mjs`
- `docs/audit/V172_Q252_CAMERA_OCR_PREMIUM_FINAL_REGRESSION_AUDIT.md`
- `docs/audit/V172_Q252_CHANGED_FILES.md`

Updated:

- `assets/mathlive/manifest.json`
- `README.md`
- `tool/verify_ocr_mathlive_review_import_v172_q250.mjs` — successor-aware metadata hygiene for Q252.
- `tool/verify_camera_math_ocr_end_to_end_court_v172_q251.mjs` — successor-aware metadata hygiene for Q252.

Runtime changes:

- None. Q252 does not mutate keyboard, MORE, long-press, MathLive production route, Graph, Solution, History, AppShell, camera shell, AndroidManifest, MainActivity, `pubspec.yaml`, or Android settings behavior.
