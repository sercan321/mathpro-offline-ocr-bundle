# Q389R6W — ONNX Runtime Mobile Integration Adaptation Notes

This package starts from the user-provided UI-updated ZIP `en günceliii.zip` and adapts the prior Q389R6B ONNX Runtime Mobile integration patch onto that newer base.

## Scope

- Keep the user-side UI/graph/workspace edits from the latest ZIP.
- Add ONNX Runtime Android dependency for the proven PP-FormulaNet_plus-S ONNX path.
- Preserve the download-only model rule: no ONNX model bytes are bundled into the APK/ZIP.
- Add app-private ONNX model discovery, SHA/size evidence, model-load smoke and guarded inference bridge code.
- Route OCR output through review-first candidate flow; no direct workspace/Graph/Solution/History auto-trigger is claimed.

## Evidence status

- Q389R6A GitHub workflow previously proved PP-FormulaNet-S and PP-FormulaNet_plus-S export to ONNX and ONNX Runtime session creation.
- This package has not been Flutter-analyzed or Flutter-tested in this environment because Flutter/Dart are unavailable here.
- No Android device OCR PASS, APK PASS, or real camera inference PASS is claimed by this package.

## Local validation required

Run on a Flutter workstation:

```powershell
flutter pub get
flutter analyze
flutter test
```

Only after analyze/test pass should device run be attempted.
