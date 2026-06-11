# MathPro Graph / History V5 — Known Limitations

This V5 package hardens graph settings. It is not a final +95 closure package yet.

## Still intentionally out of scope

- Full symbolic mathematics engine.
- Implicit graphing for equations such as `x² + y² = 1`.
- Multi-curve graph sessions.
- Advanced root/min/max detection overlays.
- Direct numeric keypad optimized for graph setting entry.
- Final real-device navigation-bar proof.

## Needs local verification

The assistant delivery environment lacks Flutter/Dart, so these must be run on the user's machine:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Risk notes

- The graph evaluator remains lightweight and explicit-function focused.
- Very advanced expressions may still be rejected by the graph evaluator rather than fully parsed.
- Settings validation prevents unusable viewports but does not solve all graph math semantics.
