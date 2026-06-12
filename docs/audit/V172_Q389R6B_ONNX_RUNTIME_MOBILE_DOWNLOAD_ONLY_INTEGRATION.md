# V172-Q389R6B — ONNX Runtime Mobile Download-Only Integration

## Decision

Q389R6A proved that the Paddle Lite `.nb` direct conversion path is not the right active route for PP-FormulaNet JSON graph models. The active production candidate is now:

```text
PP-FormulaNet_plus-S official Paddle JSON graph
→ Paddle2ONNX opset 19
→ ONNX Runtime Mobile Android
→ download-only app-private bundle
→ review-first MathLive OCR candidate handoff
```

## Evidence already obtained

- `PaddlePaddle/PP-FormulaNet-S` exported to ONNX and opened with ONNX Runtime in CI.
- `PaddlePaddle/PP-FormulaNet_plus-S` exported to ONNX and opened with ONNX Runtime in CI.
- The selected plus-S ONNX file evidence from Q389R6A run #3:
  - file: `pp_formulanet_plus_s.onnx`
  - size: `333913240`
  - sha256: `575353f72a804215329b128ed1b85e8de65fdb4b06730ac8e7954bae5c44e64d`
  - input: `[N, 1, 384, 384]` float tensor
  - output: int64 token-id style tensor

## Package rules kept intact

- No backend.
- No ML Kit.
- No text OCR fallback.
- No model bytes in the APK/AAB or repository.
- The user must explicitly tap `Modeli indir`.
- Bundle files must verify exact SHA256 and size before becoming ready.
- OCR candidates must go to the editable review surface first.
- No direct workspace import without user approval.
- No automatic Graph/Solution/History/Solver trigger.
- No Android real-device OCR PASS claim is made by this package.

## Next required user-side proof

```text
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA --dart-define=MATHPRO_OFFLINE_FORMULA_OCR_BUNDLE_MANIFEST_URL=<release-manifest-url>
```

Then on device:

```text
Modeli indir
SHA verification ready state
Internet off
Camera capture
Review surface
Approved workspace import
No auto Graph/Solution/History
```
