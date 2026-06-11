# V172-Q250 Changed Files

## Added

- `lib/features/camera/gauss_ocr_mathlive_review_import_policy.dart`
- `lib/features/camera/gauss_ocr_mathlive_review_import.dart`
- `test/v172_q250_ocr_mathlive_review_import_test.dart`
- `tool/verify_ocr_mathlive_review_import_v172_q250.mjs`
- `docs/audit/V172_Q250_OCR_MATHLIVE_REVIEW_IMPORT_AUDIT.md`
- `docs/audit/V172_Q250_CHANGED_FILES.md`

## Modified

- `lib/features/camera/gauss_mathlive_ocr_review_surface.dart`
- `assets/mathlive/manifest.json`
- `README.md`

## Runtime behavior note

The active camera shell remains pending/review-only. Q250 adds the import contract and fixes review draft compile hygiene; it does not bind OCR inference, production MathLive bridge calls, workspace mutation, solve, graph, solution, or history.
