# Q389R6L — Analyze/Test Stale Contract Hardening

Purpose: repair user-side analyzer info and stale test-contract failures after Q389R6K without changing keyboard layout, MathLive input dispatch, graph behavior, OCR runtime implementation, Android native code, or solver/CAS.

Changes:
- graph_interaction_overlay.dart now uses Dart interpolation instead of string concatenation in pi labels.
- pubspec.yaml version realigned to MathProPackageContract.version (0.172.112+172) and the stale ONNX comment marker was reworded to avoid false dependency detections from comments.
- Q291 private model download policy no longer blocks the intentional http package introduced for deferred model download.
- Old Q240/Q244/Q246/Q247 tests now recognize INTERNET permission as intentional for Q384R1 deferred model download; the tests still block READ_MEDIA_IMAGES and forbidden OCR/runtime dependency families.
- OCR review surface received a compatibility marker for the legacy model-manager wording without UI/runtime mutation.

No Flutter/Dart/device PASS is claimed from this package. User-side flutter analyze/test/build/run evidence is still required.
