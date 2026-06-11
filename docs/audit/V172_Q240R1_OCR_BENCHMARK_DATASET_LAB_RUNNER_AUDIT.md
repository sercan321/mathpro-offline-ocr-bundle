# V172-Q240R1 OCR Benchmark Dataset + Lab Runner Foundation Audit

## Scope

Q240R1 creates a deterministic dataset manifest and dry-run lab runner foundation for future OCR engine benchmarking. It is not an OCR runtime integration phase.

## Added

- `lib/features/camera/gauss_ocr_benchmark_dataset_lab_runner_policy.dart`
- `lib/features/camera/gauss_ocr_benchmark_dataset_lab_runner.dart`
- `test/v172_q240r1_ocr_benchmark_dataset_lab_runner_test.dart`
- `tool/verify_ocr_benchmark_dataset_lab_runner_v172_q240r1.mjs`

## Preserved

- Q240 benchmark court remains benchmark-only.
- Q239E MathLive OCR review foundation remains protected from production bridge calls.
- Q239D deferred model manager remains foundation-only.
- Camera/crop runtime shell is not modified.
- Keyboard, MORE, long-press, MathLive production route, Graph, Result, Solution, History, solver, splash, launcher icon, Android startup remain unchanged.

## Explicit non-goals

- No real OCR engine.
- No Text OCR fallback, PaddleOCR, Pix2Text, TexTeller, UniMERNet, ONNX runtime.
- No model binary or image fixture bundled in the base app.
- No production model URL.
- No background download worker.
- No MathLive production bridge call.
- No direct workspace import.
- No direct solve from camera.
- No benchmark winner selected.

## Dataset coverage

The canonical case metadata reserves at least 30 future fixtures across arithmetic, linear equations, powers/subscripts, fractions, radicals, trigonometry, integrals, derivatives, limits, sigma, matrices, handwriting, low-light, skewed, and blurred capture conditions.

## Verification command

```powershell
node tool/verify_ocr_benchmark_dataset_lab_runner_v172_q240r1.mjs
```
