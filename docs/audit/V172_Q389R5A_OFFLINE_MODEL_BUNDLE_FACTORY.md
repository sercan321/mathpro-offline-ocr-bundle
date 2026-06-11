# V172-Q389R5A_OFFLINE — Model Bundle Factory

## Purpose

This phase adds the production bundle factory for the offline-only camera Formula OCR path. It does not claim OCR PASS and does not ship model bytes in the Flutter/APK ZIP. Its job is to produce the exact HTTPS-hostable bundle that the existing `Modeli indir` installer accepts.

The active product contract remains:

- No backend.
- No Docker endpoint.
- No ML Kit.
- No plain text OCR fallback.
- No server image upload.
- No fake LaTeX candidate.
- No model binary inside the base ZIP/APK.
- Device-only Formula OCR after user-approved model download.

## Added tools

- `tool/q389r5a_offline_formula_ocr_bundle_factory.mjs`
- `tool/q389r5a_offline_formula_ocr_bundle_factory.ps1`
- `tool/verify_q389r5a_offline_formula_ocr_bundle_factory.mjs`

## What the factory produces

Given a real PP-FormulaNet_plus Paddle inference model and `paddle_lite_opt`, or a prebuilt production `.nb`, it creates:

```text
<out-dir>/bundle/
  pp_formulanet_plus_android_arm64.nb
  tokenizer/vocab/decoder sidecar files
  preprocess/shape/metadata sidecar files
  q389r5_offline_formula_ocr_production_manifest.json
  README_UPLOAD_Q389R5A.txt
```

The manifest is intentionally compatible with the Q389R4 app-side installer format:

```text
q389r4-offline-bundle-manifest-v1
```

The app install URL is supplied at build/run time with:

```text
--dart-define=MATHPRO_OFFLINE_FORMULA_OCR_BUNDLE_MANIFEST_URL=https://.../q389r5_offline_formula_ocr_production_manifest.json
```

## Conversion mode

Use this when you have the official Paddle inference model directory and `paddle_lite_opt.exe`:

```powershell
powershell -ExecutionPolicy Bypass -File .\tool\q389r5a_offline_formula_ocr_bundle_factory.ps1 `
  -SourceDir "C:\models\PP-FormulaNet_plus-L_infer" `
  -PaddleLiteOpt "C:\tools\paddle_lite_opt.exe" `
  -OutDir "C:\mathpro_ocr_bundle_q389r5a" `
  -BaseUrl "https://YOUR_HOST/mathpro/q389r5a" `
  -SourceRevision "PP-FormulaNet_plus-L official release / immutable revision" `
  -ConversionProvenance "Converted by Sercan on Windows using paddle_lite_opt <version>" `
  -SidecarDir "C:\models\PP-FormulaNet_plus-L_infer"
```

## Prebuilt `.nb` mode

Use this when the `.nb` was produced elsewhere and you only need to package it:

```powershell
powershell -ExecutionPolicy Bypass -File .\tool\q389r5a_offline_formula_ocr_bundle_factory.ps1 `
  -PrebuiltNb "C:\models\pp_formulanet_plus_android_arm64.nb" `
  -SidecarDir "C:\models\pp_formulanet_plus_sidecars" `
  -OutDir "C:\mathpro_ocr_bundle_q389r5a" `
  -BaseUrl "https://YOUR_HOST/mathpro/q389r5a" `
  -SourceRevision "PP-FormulaNet_plus-L official release / immutable revision" `
  -ConversionProvenance "Prebuilt .nb received from approved conversion machine; converter/version recorded externally"
```

## Upload requirement

Every file under `<out-dir>/bundle/` must be uploaded byte-for-byte to the HTTPS directory used as `-BaseUrl`. Do not rename files after manifest generation. If any byte changes, regenerate the manifest.

## Why this phase is not an OCR PASS

Q389R5A creates the real production bundle factory and validates the app-compatible manifest format. It cannot claim device OCR PASS until a real PP-FormulaNet_plus `.nb` plus sidecars is produced, hosted, installed through `Modeli indir`, and proven on-device with airplane-mode OCR evidence and workspace import evidence.
