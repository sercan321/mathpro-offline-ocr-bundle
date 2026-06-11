# V172-Q248 Deferred Model Download Runtime Audit

## Scope

Q248 prepares the PP-FormulaNet-S deferred model runtime contract after the user's explicit PP-FormulaNet-S selection. This is a guard/state-machine phase, not a production OCR inference phase.

## Implemented

- PP-FormulaNet-S is preserved as the selected candidate.
- Optional model pack identity is recorded as `gauss_pp_formulanet_s_optional_math_ocr_pack`.
- Deferred install states are declared: `notInstalled`, `queued`, `downloading`, `verifying`, `ready`, `failed`, `updateAvailable`, `disabledByUser`.
- Readiness gates require SHA256 verification, model-size budget, private app storage, offline-after-install proof, editable MathLive review, and direct-solve blocking.
- The readiness evaluator can mark a verified artifact ready only for future Q249 adapter work, never immediate Q248 inference.

## Not Implemented Intentionally

- Q248 does not bundle model bytes into the base APK.
- Q248 does not bind a production model URL.
- Q248 does not add a downloader worker.
- Q248 does not add PaddleOCR/Paddle runtime.
- Q248 does not add Text OCR fallback, ONNX, Pix2Text, TexTeller, or UniMERNet runtime dependencies.
- Q248 does not add production OCR inference.
- Q248 does not call MathLive production bridge.
- Q248 does not import camera output into workspace.
- Direct solve remains blocked.
- Direct Graph/Solution/History writes remain blocked.

## Protected Runtime Surfaces

Keyboard, MORE, long-press, MathLive production route, workspace runtime, camera shell runtime, Graph, Solution, History, splash, launcher, AndroidManifest, MainActivity, `pubspec.yaml`, and Android toolchain files are protected by the Q248 verifier hash comparison.

## Honest QA Boundary

Assistant-side Flutter/Dart/Android execution is not available. Q248 is static/verifier/fresh-extract ready only. `flutter analyze`, `flutter test`, `flutter run`, Android real-device download behavior, and PP-FormulaNet-S inference are not claimed.
