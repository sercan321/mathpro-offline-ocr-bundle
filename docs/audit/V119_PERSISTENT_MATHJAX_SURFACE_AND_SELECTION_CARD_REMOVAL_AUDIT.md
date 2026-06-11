# V119 — Persistent MathJax Surface + Selection Card Removal Audit

## Scope

This repair targets the real-device report that the editor becomes blank for 1–2 seconds after taps/inputs, and the explicit request to remove the floating `Seçim / Aktif alan` card completely from the user-facing workspace.

## Root Cause Found

The editor WebView/MathJax surface was only created when `expressionText.trim().isNotEmpty`. Empty editor state used `_EmptyEditorHint` instead of `_ExpressionPreview`, and `MathRenderSurface` returned `SizedBox.shrink()` before the editor MathJax route could be mounted. That meant the first real key after an empty/transition state created a fresh WebView and waited for MathJax startup, producing a visible blank delay.

## Repairs

- `MathRenderSurface` now routes editor role to `MathJaxRenderSurface` before the non-empty renderer gate.
- Empty editor expressions render a hidden/prewarmed `□` MathJax placeholder rather than destroying the WebView.
- `EditorViewport` now keeps `_ExpressionPreview` mounted under the empty-state hint using `Visibility(... maintainState/maintainSize ...)`.
- The floating `SelectionToolbar` is no longer painted from `AppShell`; slot/selection state remains internal for editing only.
- Widget tests were updated to lock the user-facing removal of `Seçim`, `Aktif alan`, and `Temizle` toolbar UI.
- Added `test/v119_mathjax_prewarm_selection_toolbar_removal_test.dart`.

## Not Changed

- Keyboard layout and key positions.
- Tab order.
- MORE / Ans / ↵ / = contracts.
- Long-press option order/content.
- Graph / History / Solution panel UI.
- Solver behavior.

## Runtime Evidence Status

Flutter/Dart were not available in the packaging environment, so no local `flutter analyze`, `flutter test`, or real-device `flutter run` PASS is claimed here.
