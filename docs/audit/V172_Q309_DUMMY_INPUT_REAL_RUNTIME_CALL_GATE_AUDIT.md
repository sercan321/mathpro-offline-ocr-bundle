# V172-Q309 — Dummy Input Real Runtime Call Gate Audit

Q309 continues the product-development OCR/runtime track after Q308 by defining the first dummy-input runtime-call gate for a future PP-FormulaNet-S integration.

This is still a **contract/static guard phase**. Because Q308 runtime-startup real-device evidence is not complete, Q309 does **not** call MethodChannel, does **not** invoke native runtime, does **not** implement JNI/native handler binding, does **not** mutate `MainActivity.kt`, does **not** mutate `AndroidManifest.xml`, does **not** mutate `pubspec.yaml`, does **not** add Paddle/PaddleOCR/runtime dependencies, does **not** parse a dummy native response, does **not** send camera image data, does **not** run image-to-LaTeX inference, does **not** open MathLive review, and does **not** import to workspace.

## Required before a future real dummy call

- Q308 runtime startup smoke gate present.
- Real Android runtime startup evidence.
- Native runtime MethodChannel bound.
- Native handler implemented.
- Deterministic dummy input fixture.
- Dummy input payload SHA256.
- Real Android device dummy-call log.
- Timeout/cancellation/memory-pressure policy.
- Rollback/cleanup plan.
- Editable MathLive review remains mandatory before any user-visible OCR import.

## Forbidden in Q309

- Calling MethodChannel.
- Invoking native runtime.
- Implementing native runtime handler.
- Adding runtime dependencies.
- Modifying protected production surfaces.
- Sending camera images to runtime.
- Running image-to-LaTeX.
- Claiming dummy runtime call, OCR, runtime, store, or release PASS.
