# V172-Q253 — Android Toolchain Modernization Audit

Phase marker: `V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION`

Source baseline: `V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION`

Source package SHA256: `0d1d6f118744dabe3faf48c821b6d009eb163aa5eef854708dca0718e37fd358`

## Purpose

Q253 is a separate Android toolchain modernization phase. It addresses the remaining Android build warning surface after Q252 without mixing Android build changes with Camera/OCR runtime work.

## Android toolchain decision

- Previous AGP: `8.3.2`
- Target AGP: `8.6.1`
- Kotlin Gradle Plugin: `2.1.0` preserved
- Gradle wrapper: `8.7` preserved
- Java source/target: `17` preserved
- Kotlin `jvmTarget`: `17` preserved

The official basis is that Android's Kotlin 2.1 D8/R8 compatibility line requires AGP `8.6`, and AGP 8.6 requires Gradle `8.7` plus JDK `17`.

## Camera/OCR preservation

Q253 does not change the Camera/OCR runtime path. It preserves the Q245→Q252 chain:

- Q245 real-device evidence closure
- Q246 OCR benchmark package
- Q247 winner gate
- Q247R1 PP-FormulaNet-S user selection
- Q248 deferred model runtime guard
- Q249 review-only adapter envelope
- Q250 editable MathLive review import
- Q251 end-to-end court guard
- Q252 premium final regression closure

PP-FormulaNet-S remains the selected primary candidate. Text OCR fallback remains fallback only.

## Explicit non-goals

Q253 does not add:

- Paddle runtime
- PaddleOCR dependency
- PP-FormulaNet-S model binary
- production model URL
- download worker
- image-to-LaTeX inference
- direct workspace import
- direct solve
- direct Graph
- direct Solution
- direct History

Editable MathLive review and explicit user approval remain mandatory before any camera/OCR output can be prepared for workspace import.

## Protected surface contract

The following surfaces must remain unchanged:

- keyboard layout/source
- MORE/template tray
- long-press source/order
- MathLive production route
- Graph
- Solution
- History
- AppShell/main
- AndroidManifest
- MainActivity
- splash/launcher assets
- camera capture shell runtime
- Q248/Q249/Q250/Q251 Camera/OCR foundation contracts

## Honest boundary

Q253 is static/verifier/fresh-extract ready only. Flutter analyze/test/run, Android real-device PASS, and OCR PASS are not claimed without real logs.

Plain marker: AGP 8.6.1 / Kotlin 2.1.0 / Gradle 8.7 / Java 17 / no real OCR runtime / editable MathLive review / user approval.

## Successor-aware verifier hygiene

Because Q253 intentionally changes `android/settings.gradle`, older static camera/OCR verifiers that hard-pinned AGP `8.3.2` were made Q253-successor-aware. They still accept their original phase state, but also accept the Q253 `8.6.1` toolchain only when `v172Q253AndroidToolchainModernization` is present in the manifest.
