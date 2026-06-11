# MathPro V92 — Premium Editor Performance Policy Audit

## Scope

This phase does **not** add a solver, CAS, OCR, camera recognition, or a new keyboard layout. It adds a central performance policy for the existing premium math editor surfaces so long-expression measurement, long-press animation, MORE chip animation, canvas bounds and structural-width budgeting stop drifting across widgets.

## Files changed

- `lib/features/formula_engine/premium_editor_performance_policy.dart`
- `lib/features/formula_engine/long_expression_navigation_policy.dart`
- `lib/features/workspace/editor_viewport.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/workspace/template_tray.dart`
- `test/v92_premium_editor_performance_policy_test.dart`
- `docs/audit/V92_PREMIUM_EDITOR_PERFORMANCE_POLICY_AUDIT.md`
- `docs/audit/V92_CHANGED_FILES_MANIFEST.md`
- `pubspec.yaml`

## Product contract preserved

- Keyboard key positions were not changed.
- `MORE`, `Ans`, `↵`, and `=` semantics were not changed.
- Graph, History, and Solution Panel UI were not redesigned.
- No solver success is claimed.
- No heavy AI model is introduced.

## What changed

1. A central `PremiumEditorPerformancePolicy` now holds the explicit 60 fps target budget, long-press/MORE animation durations, expression-measurement cache budget, structural-width bonus cap, and long-press panel sizing policy.
2. `EditorViewport` now caches measured expression widths per expression + viewport width. This reduces repeated `TextPainter` measurement cost during rebuilds from key taps, slot focus updates, and pan/caret-follow corrections.
3. Structural width bonus calculation is capped. Very long or slot-heavy expressions should no longer inflate canvas sizing with unbounded bonus growth.
4. `LongExpressionNavigationPolicy.maxCanvasWidth` is tied to the central performance policy, preventing a separate drift between navigation and measurement budgets.
5. Long-press and MORE press animation durations now come from the same performance policy.
6. Long-press panel desired width is calculated by the performance policy rather than a local duplicate formula.

## Remaining honest limitations

- This is not a real-device UX PASS.
- Flutter SDK was not available in the assistant environment, so `flutter analyze`, `flutter test`, and `flutter run` were not executed here.
- This does not replace the eventual need for real screenshot/golden visual regression tests and real-device 60 fps profiling.
