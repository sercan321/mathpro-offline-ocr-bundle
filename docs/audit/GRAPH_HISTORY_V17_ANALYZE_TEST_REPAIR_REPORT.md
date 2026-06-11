# GRAPH_HISTORY_V17 — Analyze/Test Log Repair Report

## Input evidence

The user provided a real Flutter analyze/test log. The log showed:

1. `deprecated_member_use` info in `lib/features/graph/graph_settings_sheet.dart` for `activeColor`.
2. Compile blocker in `lib/features/history/history_item_card.dart:388`: `_InlineActions` attempted to use `widget.entry` and `widget.onGraphTap`, but `_InlineActions` is a `StatelessWidget`.

## Repairs

### `lib/features/history/history_item_card.dart`

Changed the inline graph action condition from invalid `widget.*` access to constructor-field access:

```dart
if (entry.graphExpression != null && onGraphTap != null)
```

This preserves the existing behavior: graph history items still show `Grafiği Aç`, normal calculation items do not.

### `lib/features/graph/graph_settings_sheet.dart`

Replaced deprecated `activeColor` with:

```dart
activeThumbColor: GraphStyle.accent,
activeTrackColor: GraphStyle.accent.withValues(alpha: 0.28),
```

This removes the analyzer info without changing the visual accent direction.

### Regression lock

Added `test/graph_history_v17_analyze_repair_test.dart` to lock both repairs.

## Non-changes

- No keyboard source file was changed.
- No tab, key layout, long-press mapping, `MORE`, `Ans`, `↵`, or `=` behavior was changed.
- No graph/history feature was removed.

## Environment honesty

Flutter/Dart are not installed in the packaging environment, so this package is not marked as full PASS here. Re-run `flutter analyze` and `flutter test` on the development machine.
