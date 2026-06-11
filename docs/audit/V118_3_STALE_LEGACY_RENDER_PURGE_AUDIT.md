# V118.3 — Stale Legacy Render Purge Audit

## Scope
This package targets the real-device report that the editor math surface first shows an old/bad expression frame and only later swaps to the corrected MathJax render.

## Product contract
- Keyboard layout unchanged.
- Tab order unchanged.
- MORE / Ans / ↵ / = unchanged.
- Graph / History / Solution panel unchanged.
- Long-press list/order unchanged.
- Solver not added.

## Fix
`MathJaxRenderSurface.didUpdateWidget` now hides the WebView immediately when the TeX/display expression changes. The user sees the premium ghost/loading surface until MathJax finishes the next SVG render and posts the `rendered:<tex>` signal. The editor/test WebView fallback no longer paints a text/math fallback label; it shows the neutral holder instead, so old expressions are not displayed while MathJax is unavailable.

## Why
The previous implementation hid the WebView before the first confirmed render, but it kept the previously rendered WebView visible during later expression updates. On device this can look like an old/legacy expression flashing before the new MathJax result.

## Changed files
- `pubspec.yaml`
- `lib/features/editor/render/mathjax_render_surface.dart`
- `test/v118_local_mathjax_real_render_surface_test.dart`
- `docs/audit/V118_3_STALE_LEGACY_RENDER_PURGE_AUDIT.md`
- `docs/audit/V118_3_CHANGED_FILES_MANIFEST.md`

## Verification performed in assistant environment
- Static diff inspection.
- Zip hygiene check.
- Zip integrity check.

## Not verified in assistant environment
Flutter/Dart SDK is unavailable here, so the assistant did not run:
- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run -d 23106RN0DA`
