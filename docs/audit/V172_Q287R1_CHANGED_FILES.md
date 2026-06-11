# V172-Q287R1 Changed Files

## Added

- `lib/features/camera/gauss_store_readiness_camera_ocr_release_audit_log_repair_policy.dart`
- `lib/features/camera/gauss_store_readiness_camera_ocr_release_audit_log_repair.dart`
- `test/v172_q287r1_store_readiness_camera_ocr_release_audit_log_repair_test.dart`
- `tool/verify_store_readiness_camera_ocr_release_audit_log_repair_v172_q287r1.mjs`
- `docs/audit/V172_Q287R1_STORE_READINESS_CAMERA_OCR_RELEASE_AUDIT_LOG_REPAIR_AUDIT.md`
- `docs/audit/V172_Q287R1_CHANGED_FILES.md`

## Modified

- `test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart`
  - Fixed malformed `contains(...)` assertion syntax from the real user Flutter test log.
- `lib/features/mathlive/mathlive_production_editor_surface.dart`
  - Protected surface changed intentionally for analyzer hygiene.
  - `_keepCaretVisible` is now referenced only on first production runtime mount to preserve caret contract without adding per-key command-tail latency.
- `assets/mathlive/manifest.json`
  - Added Q287R1 latest phase metadata.
- `README.md`
  - Added Q287R1 delivery note.
- `tool/verify_*` Q277R3-Q287 successor metadata/hash expectations.

## Not Changed

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/template_tray.dart`
- `assets/mathlive/main_editor_prod.html`
- `assets/mathlive/mathlive_prod_bridge.js`
- `lib/features/graph/graph_card.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/history/history_panel.dart`
- `lib/app/app_shell.dart`
- `lib/main.dart`
- `android/app/src/main/AndroidManifest.xml`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
- camera dependencies
- Android toolchain

## Runtime Boundary

No real OCR runtime, Paddle/PaddleOCR dependency, native handler, model binary, production model URL, downloader, image-to-LaTeX inference, OCR PASS, store-ready PASS, or release PASS was added.
