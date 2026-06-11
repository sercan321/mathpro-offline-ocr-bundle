# V172-Q249 — OCR Runtime Adapter Audit

## Scope

Q249 installs the PP-FormulaNet-S OCR Runtime Adapter contract after Q248 deferred model readiness. The phase is intentionally review-only and contract-only.

## What changed

- Added `lib/features/camera/gauss_ocr_runtime_adapter_policy.dart`.
- Added `lib/features/camera/gauss_ocr_runtime_adapter.dart`.
- Added `test/v172_q249_ocr_runtime_adapter_test.dart`.
- Added `tool/verify_ocr_runtime_adapter_v172_q249.mjs`.
- Updated `assets/mathlive/manifest.json` with `V172-Q249-OCR-RUNTIME-ADAPTER` metadata.
- Updated README with the Q249 summary.

## PP-FormulaNet-S status

- Selected engine label: PP-FormulaNet-S.
- Role: future primary math OCR adapter candidate.
- Fallback label remains Plain text OCR fallback.
- Q249 does not claim real OCR accuracy, benchmark PASS, Android runtime PASS, or production inference PASS.

## Runtime boundaries

Q249 deliberately does not add:

- no Paddle runtime,
- no PaddleOCR dependency,
- no ONNX runtime,
- no plain text OCR runtime dependency,
- no PP-FormulaNet-S model binary,
- no production model URL,
- no download worker,
- no real image-to-LaTeX inference,
- no MathLive production bridge call,
- no direct workspace import,
- no direct solve,
- no direct Graph/Solution/History writes.

## Review-only contract

The adapter envelope carries:

- capture path,
- crop/scan-frame id,
- rotation metadata,
- Q248 model evidence,
- preprocessing profile,
- primary LaTeX candidate,
- alternative LaTeX candidates,
- confidence,
- warnings,
- engine metadata,
- mandatory MathLive editable review requirement.

Every candidate is blocked unless it is review-only and uses editable MathLive review before any workspace import or Solve/Graph/Solution/History action.

## Protected-surface result

PROTECTED_HASH_UNCHANGED. Keyboard, MORE, long-press, MathLive production editor, Workspace runtime, Camera shell runtime, Graph, Solution, History, splash, launcher icon, AndroidManifest, MainActivity, `pubspec.yaml`, and `android/settings.gradle` are not changed by Q249.

## Honest limitation

This phase is static/verifier/fresh-extract only. It does not prove `flutter analyze`, `flutter test`, `flutter run`, Android device behavior, model download, PP-FormulaNet-S runtime inference, or OCR accuracy.

Q249 explicit audit markers: no Paddle runtime; no model binary; MathLive editable review.
