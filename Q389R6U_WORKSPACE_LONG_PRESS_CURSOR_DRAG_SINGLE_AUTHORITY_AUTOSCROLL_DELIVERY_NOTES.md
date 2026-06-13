# Q389R6U — Workspace Long-Press Cursor Drag Single-Authority Autoscroll Repair

Device feedback confirmed the Q389R6T failure mode: holding on the expression can send the caret to the expression end, and the expected Photomath-style hold-and-drag cursor session still does not operate as the production authority.

## Runtime repair

- Keeps the Q389R6S/Q389R6T Flutter parent Listener bridge.
- Adds Q389R6U payload phase and sends Flutter surface width/height with each cursor-drag command.
- JS normalizes Flutter local pointer coordinates into WebView client coordinates before calling MathLive native caret APIs.
- JS internal long-press path is suppressed at install time so production has a single cursor-drag authority.
- External bridge start/move/end owns the drag session.
- External bridge starts its own continuous edge-autoscroll loop.
- Holding at left/right edge now has a production loop that does not require new pointer-move events.
- Flutter pointer-move dispatch is coalesced to a 16 ms cadence before runJavaScript calls.
- JS also coalesces external move application with requestAnimationFrame / 16 ms fallback.

## Protected lines

- No keyboard layout/key-order changes.
- No Dart keyboard dispatch queue changes.
- No JS-side keyboard command queue changes.
- No document-level touchmove/pointermove fallback revival.
- No direct-pan / host-scrollport-force revival.
- No graph/OCR/Android native/Solver change.
- No legacy Flutter cursor overlay.
- MathLive native caret remains authoritative.

## Claim boundary

Static verifier and node syntax checks only in this environment. Flutter/Dart/Gradle are not available here; analyze/test/build/run PASS requires user-side logs.
