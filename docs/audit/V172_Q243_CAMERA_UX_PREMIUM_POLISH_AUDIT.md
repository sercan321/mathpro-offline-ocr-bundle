# V172-Q243 — Camera UX Premium Polish Audit

## Scope

Q243 is a visual/UX polish phase for the already isolated camera capture, crop, and MathLive OCR review foundation. It adds premium guidance copy, a focus/quality rail, low-light/blur/alignment hints, and crop quality copy.

## Explicit Non-Scope

- No OCR engine
- No Text OCR fallback
- No PaddleOCR
- No Pix2Text
- No ONNX runtime
- No model binary
- No production model URL
- No background download worker
- No MathLive production bridge call
- No direct workspace import
- No direct solve/evaluate/graph/history/solution from camera
- No keyboard, MORE, long-press, Graph, Solution, History, solver, splash, or launcher-icon mutation

## Changed Runtime Surface

- `lib/features/camera/gauss_camera_capture_shell.dart`

Reason: add Q243 premium camera guidance widgets inside the camera/crop shell only.

## Added Contract / Evidence Files

- `lib/features/camera/gauss_camera_ux_premium_polish_policy.dart`
- `lib/features/camera/gauss_camera_ux_premium_polish.dart`
- `test/v172_q243_camera_ux_premium_polish_test.dart`
- `tool/verify_camera_ux_premium_polish_v172_q243.mjs`
- `docs/audit/V172_Q243_CAMERA_UX_PREMIUM_POLISH_AUDIT.md`
- `docs/audit/V172_Q243_CHANGED_FILES.md`

## Required Real-Device Retest

Static package verification is not a real-device visual PASS. The camera screen and crop review must still be checked on Android hardware for alignment, spacing, camera permission behavior, preview aspect handling, and polish quality.
