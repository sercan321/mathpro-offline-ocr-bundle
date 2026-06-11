# V172-Q246 OCR Engine Real Benchmark Package Audit

Q246 is a benchmark-package phase over Q245. It prepares the real math OCR engine evaluation package without binding an OCR engine into the app runtime.

## Scope

The phase adds a candidate-probe contract, real-image benchmark case contract, mobile-selection metric gates, rejection rules, a Flutter test, a Node verifier, README metadata, and manifest metadata.

## Candidate Families

The package keeps the six candidate families that must be evaluated before Q247 winner selection:

- PP-FormulaNet-S
- PP-FormulaNet_plus-S
- Pix2Text MFR ONNX
- UniMERNet tiny
- TexTeller
- Plain text OCR fallback

Text OCR fallback remains a simple text fallback candidate only. It is not accepted as the primary structural formula recognizer for integral, fraction, radical, derivative, limit, sigma, or matrix cases.

## Required Benchmark Coverage

Q246 records real-image case requirements for arithmetic, equation, power/subscript, fraction, radical, indefinite integral, definite integral, derivative prime notation, derivative Leibniz notation, limit, sigma, matrix, nested complex expression, handwriting, low light, skewed capture, mild blur, and trigonometry.

## Runtime Boundary

Q246 does not add Text OCR fallback, PaddleOCR, Pix2Text, ONNX, TexTeller, UniMERNet, model binaries, production model URLs, background download workers, inference runtime, MathLive production bridge calls, direct workspace import, direct solve, direct Graph, direct Solution, or direct History writes.

The camera result must still pass through editable MathLive review in later phases before any workspace import.

## Android Boundary

Q246 preserves the active Q244R8/Q245 Android state: `camera: 0.10.6`, `camera_android: 0.10.9+3`, no `camera_android_camerax`, Kotlin Gradle plugin `2.1.0`, and AGP `8.3.2`. Android toolchain modernization remains deferred to Q253.

## Protected Surface

Keyboard, MORE, long-press, MathLive production editor, workspace runtime, camera shell runtime, Graph, Solution, History, splash, launcher icon, Android manifest runtime behavior, MainActivity runtime behavior, camera dependency, Kotlin plugin, and AGP were not changed by Q246.

## Evidence Limit

Assistant-side Flutter/Dart/Android execution is unavailable in this environment. Q246 does not claim `flutter analyze`, `flutter test`, `flutter run`, Android real-device camera PASS, OCR PASS, benchmark PASS, premium final PASS, or release PASS. Fresh user-side logs and real benchmark artifacts are still required.
