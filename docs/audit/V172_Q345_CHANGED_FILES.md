# V172-Q345 Changed Files Manifest

## Added

- `lib/features/camera/gauss_gradle_abi_packaging_build_trial_q345_policy.dart`
- `lib/features/camera/gauss_gradle_abi_packaging_build_trial_q345.dart`
- `test/v172_q345_gradle_abi_packaging_build_trial_test.dart`
- `tool/verify_gradle_abi_packaging_build_trial_v172_q345.mjs`
- `docs/audit/V172_Q345_GRADLE_ABI_PACKAGING_BUILD_TRIAL_AUDIT.md`
- `docs/audit/V172_Q345_CHANGED_FILES.md`

## Modified

- `android/app/build.gradle` — Q345 declares `implementation files('libs/PaddlePredictor.jar')` so the Q344-approved PaddlePredictor jar participates in the Android app module packaging/classpath.
- `assets/mathlive/manifest.json` — records Q345 as the active camera/OCR product packaging gate.
- `README.md` — documents Q345.
- Q326-Q344 successor-aware tests — accept Q345 as the active successor phase while keeping Q344 binary hashes and OCR runtime non-goals guarded.

## Unchanged / not added

- No `System.loadLibrary`.
- No Paddle Lite Predictor instantiate.
- No model loader or model load.
- No runtime startup or dummy call.
- No image-to-LaTeX inference.
- No OCR review UI or workspace import.
- No workspace, keyboard, MORE, long-press, MathLive production bridge/editor, Graph, Solution, History, splash/icon, or solver/evaluator mutation.
