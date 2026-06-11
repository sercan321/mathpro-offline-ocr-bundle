# V172-Q248 Changed Files

## Added

- `lib/features/camera/gauss_pp_formulanet_s_user_selection_policy.dart`
- `lib/features/camera/gauss_pp_formulanet_s_user_selection.dart`
- `lib/features/camera/gauss_deferred_model_download_runtime_policy.dart`
- `lib/features/camera/gauss_deferred_model_download_runtime.dart`
- `test/v172_q247r1_pp_formulanet_s_user_selection_test.dart`
- `test/v172_q248_deferred_model_download_runtime_test.dart`
- `tool/verify_pp_formulanet_s_user_selection_v172_q247r1.mjs`
- `tool/verify_deferred_model_download_runtime_v172_q248.mjs`
- `docs/audit/V172_Q248_DEFERRED_MODEL_DOWNLOAD_RUNTIME_AUDIT.md`
- `docs/audit/V172_Q248_CHANGED_FILES.md`

## Updated

- `assets/mathlive/manifest.json`
- `README.md`

## Protected Runtime Surfaces

The Q248 verifier checks that the following surfaces remain byte-stable against the active baseline:

- keyboard layout/source
- MORE/template tray source
- long-press source/order
- MathLive production editor/bridge
- workspace runtime and camera shell runtime
- Graph/Solution/History
- splash/launcher-related app files
- AndroidManifest/MainActivity
- `pubspec.yaml`
- `android/settings.gradle`

Q248 is a contract/guard phase only; no production OCR runtime path is enabled.
