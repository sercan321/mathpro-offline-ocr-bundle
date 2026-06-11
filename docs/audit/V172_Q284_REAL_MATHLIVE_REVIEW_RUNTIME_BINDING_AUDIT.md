# V172-Q284 — OCR Result Real MathLive Review Runtime Binding Audit

Q284 adds a gate-only runtime review-binding court after Q283.

## Added

- `lib/features/camera/gauss_ocr_result_real_mathlive_review_runtime_binding_policy.dart`
- `lib/features/camera/gauss_ocr_result_real_mathlive_review_runtime_binding.dart`
- `test/v172_q284_ocr_result_real_mathlive_review_runtime_binding_test.dart`
- `tool/verify_ocr_result_real_mathlive_review_runtime_binding_v172_q284.mjs`
- `docs/audit/V172_Q284_REAL_MATHLIVE_REVIEW_RUNTIME_BINDING_AUDIT.md`
- `docs/audit/V172_Q284_CHANGED_FILES.md`

## Scope

Q284 defines how a future accepted Q283 image-to-LaTeX candidate envelope becomes an editable MathLive review draft. It preserves primary/alternative candidates, confidence, warnings, engine metadata, and image-input metadata.

## Explicit non-goals

- no Paddle runtime
- no PaddleOCR dependency
- no native Android handler
- no JNI binding
- no MethodChannel runtime binding
- no PP-FormulaNet-S model binary
- no production model URL
- no production download worker
- no real image-to-LaTeX inference
- no OCR PASS claim
- no Camera/OCR runtime PASS claim
- no release PASS claim

## Protected surfaces

Keyboard layout, MORE/template tray, long-press lists, MathLive production route, Graph, Solution, History, AppShell, workspace, camera shell runtime, splash/icon, Android manifest, MainActivity, Android toolchain, and camera dependencies remain protected.
