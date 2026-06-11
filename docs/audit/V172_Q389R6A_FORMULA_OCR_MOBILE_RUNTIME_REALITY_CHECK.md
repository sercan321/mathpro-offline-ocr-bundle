# V172-Q389R6A — Formula OCR Mobile Runtime Reality Check

## Why this phase exists

The Q389R5C/R5F/R5G Paddle Lite path reached a real conversion failure rather than a Flutter/test failure.

Observed evidence from GitHub Actions:

- PP-FormulaNet_plus-L snapshot download: succeeded.
- Paddle Lite opt acquisition: succeeded.
- Direct `inference.json + inference.pdiparams -> paddle_lite_opt -> .nb`: failed.
- Failure class: `SIGABRT` inside Paddle Lite opt while loading `inference.json` topology.

This means the direct Paddle Lite `.nb` assumption is no longer reliable. We should not fake a green workflow by emitting a dummy `.nb`.

## Internet research conclusion

### PP-FormulaNet model packaging

The official Hugging Face repositories for the PP-FormulaNet family expose Paddle deployment files in the new JSON graph format:

- `PaddlePaddle/PP-FormulaNet_plus-L`
  - `inference.json`
  - `inference.pdiparams`
  - `inference.yml`
  - approx. 735 MB repository size
- `PaddlePaddle/PP-FormulaNet_plus-S`
  - `inference.json`
  - `inference.pdiparams`
  - `inference.yml`
  - approx. 264 MB repository size
- `PaddlePaddle/PP-FormulaNet-S`
  - `inference.json`
  - `inference.pdiparams`
  - `inference.yml`
  - approx. 238 MB repository size

No `.pdmodel` artifact is present in the current public HF package layout.

### Paddle Lite direct conversion

Paddle Lite opt documentation describes an optimization/conversion tool that outputs a lightweight executable model, but the current workflow evidence shows direct conversion of the FormulaNet `inference.json` graph fails before producing `.nb`.

Conclusion: Paddle Lite `.nb` remains possible only if a compatible export/legacy graph path is found. It should not be treated as the primary path anymore.

### Paddle2ONNX compatibility

Paddle2ONNX documentation states that the exporter accepts Paddle deployment model files consisting of:

- `model_name.json` for model structure
- `model_name.pdiparams` for model parameters

and converts them to ONNX via a command like:

```bash
paddle2onnx --model_dir model_dir \
  --model_filename model.json \
  --params_filename model.pdiparams \
  --save_file model.onnx
```

This exactly matches the public PP-FormulaNet artifact shape, except the filenames are `inference.json` and `inference.pdiparams`.

Conclusion: the most evidence-aligned next path is:

```text
PP-FormulaNet inference.json + inference.pdiparams
  -> paddle2onnx
  -> formula_ocr.onnx
  -> ONNX Runtime Mobile Android
```

### ONNX Runtime Mobile Android

ONNX Runtime official docs support Android deployment via `onnxruntime-android`. They also document mobile optimization and custom runtime builds to reduce binary size.

Conclusion: if Paddle2ONNX export works, ONNX Runtime Mobile is the strongest Android runtime candidate.

### LiteRT/TFLite

LiteRT/TFLite is Android-friendly, but the immediate bridge from Paddle FormulaNet to TFLite is less direct. It likely requires Paddle -> ONNX -> TensorFlow/TFLite or another model rewrite path.

Conclusion: keep TFLite as a second-order fallback after ONNX export evidence.

### NCNN/MNN

Paddle2ONNX notes ONNX can be used to deploy into engines such as TensorRT, OpenVINO, MNN, TNN, NCNN and other ONNX-compatible runtimes.

Conclusion: NCNN/MNN are fallback candidates after ONNX export, but Android integration and decoder handling may be more work than ONNX Runtime Mobile.

## Decision

Q389R6A should stop trying to force FormulaNet `inference.json` through Paddle Lite opt.

Primary next target:

```text
PP-FormulaNet_plus-S / PP-FormulaNet-S
  -> Paddle2ONNX export
  -> ONNX checker
  -> ONNX Runtime session load smoke
  -> artifact report
```

Only after ONNX export and ORT load work should the Flutter/Android app be moved from Paddle Lite bridge to an ONNX Runtime bridge.

## Model order

Use this order to minimize download and CI time:

1. `PaddlePaddle/PP-FormulaNet-S`
2. `PaddlePaddle/PP-FormulaNet_plus-S`
3. `PaddlePaddle/PP-FormulaNet_plus-L`

Do not start with plus-L unless S/plus-S prove exportable.

## Acceptance criteria

R6A is accepted only if one of these is true:

1. A real ONNX file is produced from a PP-FormulaNet model and passes `onnx.checker`.
2. ONNX Runtime can create an inference session from the produced ONNX/ORT model.
3. If export fails, the workflow artifact contains exact stdout/stderr reports explaining why.

R6A must not claim:

- Android OCR PASS
- device inference PASS
- workspace import PASS
- offline camera OCR PASS

## User-side action later

When the R6A workflow is present, user only needs:

```text
GitHub -> Actions -> Q389R6A Formula OCR Mobile Runtime Reality Check -> Run workflow
```

Then send either the green result or the failed export log.
