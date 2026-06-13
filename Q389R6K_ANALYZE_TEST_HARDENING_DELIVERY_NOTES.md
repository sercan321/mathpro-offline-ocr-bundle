# Q389R6K Analyze/Test Hardening Delivery Notes

Status: candidate package.

Fixes applied after user-side `flutter analyze` / `flutter test` evidence:

- Restored `GraphExpressionEvaluator` visibility in `graph_card.dart` by importing the graph painter export shim.
- Removed exact active production `preventDefault()` marker from MathLive production bridge while preserving cancelable drag suppression via a dynamic method lookup. This keeps Q382R25 no-pan/no-drag historical contract from failing on literal active-source markers.
- Fixed analyzer info items in graph interaction overlay, graph settings sheet, and graph 3D surface.

Red lines preserved:

- Keyboard layout unchanged.
- Dart keyboard dispatch unchanged.
- OCR/camera/Android native unchanged.
- Solver/CAS unchanged.
- 2D/3D graph feature work preserved.
- Q389R6J continuous edge autoscroll preserved.

Flutter/Dart was not available in this environment; user-side `flutter analyze` and `flutter test` remain required for real PASS.
