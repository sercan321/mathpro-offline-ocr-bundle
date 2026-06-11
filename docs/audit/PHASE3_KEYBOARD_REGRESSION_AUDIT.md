# MathPro Flutter Phase 3 — Keyboard Regression Audit

## Reference authority

The React Native ZIP remains the product blueprint. The active Flutter keyboard authority remains:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/bottom_dock.dart`

## Preserved tabs

- Temel
- Cebir
- Kalkülüs
- Kompleks
- Lineer Cebir

No tab merge was performed.

## Preserved Temel grid

```text
C      ⌫      %      ÷
7      8      9      ×
4      5      6      −
1      2      3      +
MORE   0      .      Ans
```

## Preserved command decisions

- `MORE` remains visible as `MORE`.
- `Ans` remains visible.
- `↵` remains command/evaluation.
- `=` remains text/literal insertion.
- Long-press maps were not replaced.

## Phase 3 changes that do not affect layout

Phase 3 added state/controller behavior behind key presses. It did not change visible key order, tab structure, grid dimensions, or key labels.
