> HISTORICAL / SUPERSEDED NOTE: This file documents an older Phase 15/16 test-repair state. It is not the current Graph + Premium History runtime contract. The retired `mathpro-history-handle` key mentioned below must not be reintroduced into `lib/`; current authoritative truth is `GRAPH_HISTORY_V17_AUTHORITATIVE_INDEX.md` and README V17.

# MathPro Flutter Phase 17 — History Test Determinism Repair

## Target

Phase 17 targets the real user-side `flutter test` failure from Phase 15:

```text
pumpAndSettle timed out
Test: MathPro phase 15 commits evaluated expressions to history drawer
```

## Root cause

The failure is not a compile/analyze issue. `flutter analyze` was already clean on the user's machine.

The failing widget test used `pumpAndSettle()` after tapping the history handle. MathPro's editor/slot surfaces can contain premium blinking/animated UI elements. In Flutter widget tests, such animations can keep the test binding from ever reaching a fully settled state, so `pumpAndSettle()` can time out even when the drawer is openable.

## Fix

The history drawer test now uses deterministic fixed pumps after tapping the handle:

```dart
await tester.tap(find.byKey(const ValueKey('mathpro-history-handle')));
await tester.pump();
await tester.pump(const Duration(milliseconds: 320));
```

The drawer itself is configured with no sheet animation, so a fixed pump is sufficient and avoids waiting for unrelated active UI animations.

## Non-regression

Keyboard source files were not changed.
