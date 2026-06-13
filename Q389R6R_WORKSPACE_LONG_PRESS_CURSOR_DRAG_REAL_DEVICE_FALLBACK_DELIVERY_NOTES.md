# Q389R6R — Workspace Long-Press Cursor Drag Real-Device Fallback

## User-side trigger
Q389R6Q passed `flutter analyze`, `flutter test`, and release APK build, but device feedback reported that the caret still did not behave like Photomath: long-press and drag with the finger did not reliably move the cursor.

## Root risk
Q389R6I/J attached pointer listeners to the MathLive field, but Android WebView/MathLive can swallow, retarget, or stop some gesture sequences before the JS listener path behaves like a native editor drag. A small pre-activation drift could also cancel the long-press candidate too early.

## Runtime changes
- Adds Q389R6R real-device fallback markers.
- Keeps Q389R6I/J behavior and continuous edge autoscroll.
- Adds capture-phase listeners on the MathLive host and math-field.
- Adds touchstart/touchmove/touchend fallback for Android WebView.
- Adds document-level move/end fallback so drag can continue even if pointer capture is unreliable.
- Raises pre-activation movement tolerance from 18 px to 34 px.
- Cancels pending long-press only for mostly vertical pre-activation movement.
- Preserves MathLive native caret authority via `getOffsetFromPoint`, `setPosition` / `position`.

## Protected surfaces not changed
- Flutter keyboard layout and key order.
- Dart keyboard dispatch and queue.
- Graph runtime/UI.
- OCR/camera runtime.
- Android native/Kotlin/Gradle.
- Solver/CAS.
- Legacy Flutter cursor is not restored.

## Evidence boundary
This package includes static JavaScript syntax and contract verification only. Real PASS for Photomath-style cursor drag requires device video/user-side confirmation.
