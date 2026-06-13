# Q389R6S — Workspace Long-Press Cursor Drag External Bridge

Q389R6S hardens the long-press cursor drag path by adding a Flutter parent-pointer observer around the production WebView and forwarding hold/drag/end coordinates into the MathLive production JS bridge.

Runtime contract:
- Android WebView / MathLive DOM pointer handling is no longer the only entry path.
- Flutter observes pointer down/move/up around the WebView without changing keyboard layout or key dispatch.
- After a hold delay, Flutter sends `externalCursorDragStart`, `externalCursorDragMove`, and `externalCursorDragEnd` into `MathProProductionMathLiveBridge`.
- MathLive native caret remains the only visible caret authority.
- No legacy Flutter cursor overlay is revived.

Protected surfaces not touched:
- keyboard layout
- Dart keyboard dispatch queue
- Graph runtime
- OCR/runtime/Kotlin/native Android
- solver/CAS
