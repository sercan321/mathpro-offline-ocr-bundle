# V172-Q385 Changed Files

## Modified

- `android/app/build.gradle`
- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`

## Added

- `lib/features/camera/gauss_paddle_runtime_abi_trim_delivery_guard_q385.dart`
- `test/v172_q385_paddle_runtime_abi_trim_delivery_guard_test.dart`
- `tool/verify_paddle_runtime_abi_trim_delivery_guard_v172_q385.mjs`
- `docs/audit/V172_Q385_PADDLE_RUNTIME_ABI_TRIM_AND_DELIVERY_GUARD.md`
- `docs/audit/V172_Q385_CHANGED_FILES.md`

## Not modified intentionally

- Keyboard layout/order/labels
- KeyConfig inventory
- MORE/template tray inventory/order
- Long-press inventory/order
- MathLive editor/caret authority
- Q382 ordering pipeline
- Graph
- History
- Solution/Solver semantics
- OCR model download manifest and SHA lock from Q384R1
- Q384R2 model-format preflight semantics
- AndroidManifest permissions (no new Q385 permission; INTERNET was introduced earlier by Q384R1 for real deferred model download)
- Splash/icon/startup flow


## Q385R1 clarification

- INTERNET permission was introduced by Q384R1 for the real deferred model download.
- Q385 did not add a new permission beyond Q384R1.
- armeabi-v7a source fallback remains present but is not packaged by Q385 release abiFilters.
