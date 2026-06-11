# V116 Real Log Single-Test Repair Audit

## Scope

V116 is a targeted real-log repair based on the user's V115 result:

- `flutter analyze`: `No issues found!`
- `flutter test`: one remaining failing test in `v103_primary_math_family_migration_test.dart`

The only failing expectation was that `StructuralRendererBridge.snapshotForExpression('x²')` canonicalizes to `x^(2)` but the resulting `SlotRegistry` did not expose `powerBase` and `powerExponent`.

## Change

`lib/features/editor/slot_registry.dart` now treats fully-filled `MathNodeKind.power` nodes as editable structural regions when both `base` and `exponent` are filled.

This preserves the V103 primary-family migration contract:

- `x²` -> `x^(2)`
- registry roles include `powerBase`
- registry roles include `powerExponent`

## Non-goals

- No keyboard layout changes.
- No tab changes.
- No MORE / Ans / ↵ / = changes.
- No long-press list changes.
- No Graph / History / Solution panel changes.
- No solver work.
- No fake PASS claim without user-side Flutter logs.

## Expected user-side commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Status

Static repair candidate only. Flutter/Dart SDK was not available in this environment, so no local PASS is claimed.
