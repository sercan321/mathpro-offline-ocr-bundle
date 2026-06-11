# V172-Q381R1 Camera OCR Runtime Risk Repair Audit

Q381R1 is a direct repair on top of Q381. It is not a new OCR PASS claim and it does not bundle the 308 MB ONNX model.

## Scope

- Keep Q381 camera OCR user-flow binding intact.
- Harden the Q381 native OCR bridge against UI-thread blocking, large-image decode memory spikes, EXIF orientation drift, unsafe MethodChannel argument casts, and native worker exceptions.
- Preserve review-first and explicit-approval-only workspace import.

## Intentional changes

- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`
  - Q381 MethodChannel branch now captures arguments safely and runs heavy OCR/crop/model work on a dedicated Q381R1 worker thread.
  - Result delivery is posted back through `Handler(Looper.getMainLooper())`.
  - Q381 crop preprocessing now uses bounds-first sampled decode with a 2048 px max dimension guard.
  - Q381 crop preprocessing now reads EXIF orientation and combines it with user-requested quarter-turn rotation.
  - Crop evidence now reports source/decoded/rotated/crop dimensions, sample size, EXIF/user/total rotation, coordinate-space label, JPEG quality, and Q381R1 hardening flags.
  - Q380 cropped-image preprocessing now recycles the decoded bitmap after tensor build.
  - Native worker failure returns blocked evidence instead of fake LaTeX.
- `lib/features/camera/gauss_camera_ocr_runtime_finalization_q381_policy.dart`
  - Adds Q381R1 repair policy markers.
- `lib/features/camera/gauss_camera_ocr_runtime_finalization_q381.dart`
  - Exposes Q381R1 repair evidence fields.
- `test/v172_q381_camera_ocr_runtime_finalization_test.dart`
  - Adds policy/result assertions for the Q381R1 repair markers.
- `tool/verify_camera_ocr_runtime_risk_repair_v172_q381r1.mjs`
  - Adds static verifier for Q381R1 repair requirements.
- `assets/mathlive/manifest.json`
  - Adds Q381R1 repair metadata while preserving Q381 latest finalization metadata for compatibility.
- `README.md`
  - Adds Q381R1 delivery note.

## Protected red lines

Q381R1 does not intentionally modify keyboard layout, MORE/template tray, long-press inventory/order, MathLive production HTML/bridge assets, workspace template tray, Graph, Solution, History, splash/icon, solver/evaluator, Gradle, pubspec, or AndroidManifest.

## Honest limitations

- Q381R1 does not provide the ONNX model artifact.
- Q381R1 does not claim Flutter analyze/test/run PASS.
- Q381R1 does not claim Android real-device OCR PASS.
- Real OCR still depends on verified model/vocab availability and model-specific output compatibility.
