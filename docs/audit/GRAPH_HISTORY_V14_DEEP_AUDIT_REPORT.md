# GRAPH_HISTORY_V14_DEEP_AUDIT_REPORT
Generated: 2026-05-10

## Outcome
CONDITIONAL PASS — static/package closure only.

## Why not full PASS
Flutter and Dart are not installed in this delivery environment. Therefore `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run -d 23106RN0DA` were not executed here. Real PASS requires those commands and manual Android UI validation on the development machine.

## Deep audit scope
The V13 package was re-opened and checked again instead of being accepted blindly. The audit covered:

- graph/history module presence,
- Graph Painter numeric type safety,
- History Drawer numeric type safety,
- constructor `required this.*` fields,
- string/comment-aware Dart bracket balance,
- old crude history handle scan,
- dead callback scan,
- stale fake Flutter PASS wording scan,
- keyboard SHA256 freeze,
- release ZIP hygiene.

## Repairs applied

### 1. Graph trace x numeric type repair
File: `lib/features/graph/graph_painter.dart`

Problem found:

The trace clamp used an integer zero inside the `math.max` call.

This could infer `num` because `0` is an `int` while `expression.xMin` is a `double`. That value is passed to `GraphExpressionEvaluator.evaluate(double)`, so it is a compile-risk hotspot.

Repair:

```dart
final x = math.min(math.max(0.0, expression.xMin), expression.xMax);
```

### 2. History drawer drag offset numeric type repair
File: `lib/features/history/history_panel.dart`

Problem found:

The drawer drag clamp used integer bounds inside the nested `math.min` / `math.max` calls.

This could infer `num` and assign it into `_dragOffset`, which is a `double`.

Repair:

```dart
_dragOffset = math.min(0.0, math.max(-88.0, _dragOffset + details.delta.dy));
```

### 3. Stale audit wording repair
File: `docs/audit/GRAPH_HISTORY_V8_STATIC_CHECK.txt`

The file already said Flutter/Dart were unavailable, but its “Not claimed” bullet wording still contained grep-confusing analyzer/test/run PASS phrases. Those lines were rewritten to say NOT RUN / PASS not claimed.

### 4. Regression lock
File: `test/graph_history_v14_static_contract_test.dart`

Added a static regression lock for:

- graph trace double-literal repair,
- history drag double-literal repair,
- no fake analyzer/test/run PASS wording in README/audit docs.

## Keyboard freeze result
The frozen keyboard files were not edited.

```text
lib/features/keyboard/key_config.dart        1f512b6d96a528a0363d00b2d9ac9006ca3f10e9892f7f2a10b513af1d380144
lib/features/keyboard/math_keyboard.dart     f4f2a9acdc226cdc9838a265a96f2539a5b9ecf1f4feccd5fbb76745370b7ad2
lib/features/keyboard/bottom_dock.dart       e2063efc93b7b7470ba5940db8da1a49ded633cd8c31619f2659132c82d243a7
lib/features/keyboard/long_press_popup.dart  a7f7c8a0d2c6df9efa02cb984f9109f090992e944145f124d8c258059d3f7d75
```

## Required local verification

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
