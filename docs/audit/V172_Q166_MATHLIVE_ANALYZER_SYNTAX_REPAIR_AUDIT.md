# V172-Q166 MathLive Analyzer Syntax Repair Audit

## Trigger
User-side Q165 log showed `flutter analyze` failed with:

- `unused_element` for `_syncMathLiveSimpleKeyFallbackForTests`
- unterminated string literal in `mathlive_main_editor_surface.dart` around `_prettyExpression()`

## Repairs
- Rewrote `_prettyExpression()` string replacements with valid Dart string literals.
- Restored proper raw strings for `\textstyle`, `\times`, `\to`, and `\bmod` replacements.
- Kept Q165 AppShell visible fallback path intact.
- Kept Q153 simple-key fallback helper reachable by invoking it after Q165 fallback with a duplicate-write guard.

## Protected contracts
Keyboard layout, key order, MORE inventory/order, long-press source/order, Graph/History/Solution UI, solver behavior, and MathLive mapping semantics were not intentionally changed.

## Truth statement
Flutter/Dart were unavailable in the assistant environment, so this audit does not claim assistant-side `flutter analyze`, `flutter test`, `flutter run`, real-device, cursor, or Photomath-level PASS.
