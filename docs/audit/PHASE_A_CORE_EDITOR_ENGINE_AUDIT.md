# MathPro Core Editor Engine — Phase A Audit

## Scope

This package implements the first guarded Core Editor Engine step on top of the latest Phase 17 bottom-dock fix package.

Implemented scope:

- Debug clean-up for user-facing slot UI.
- TeX render lock for structural expressions that already have slot registry data.
- Sqrt / fraction / integral structural TeX foundation through `StructuralRendererBridge` + `EditorTexSerializer`.
- Invisible hit area foundation with minimum mobile target sizing and nearest-slot fallback.
- Priority hit-test scoring foundation using priority, slot depth, distance, and stable role order.

Out of scope for this package:

- Full renderer-derived glyph bounds from `flutter_math_fork` internals.
- Full custom AST mutation engine beyond the already-present expression-to-node bridge.
- Real-device 10/9 Photomath-style manual proof. This must be executed on the user's phone.

## User-facing debug ban result

Removed / hidden from normal UI:

- `Aktif slot: ...` line in the workspace.
- Technical slot role in the selection toolbar.
- Always-visible green slot rectangles.

Internal technical roles such as `sqrtValue` and `integralBody` still exist inside the engine as identifiers. They are not displayed to the user.

## TeX render foundation

`MathRenderSurface` now prefers the structural renderer path when the expression has real slots:

```text
StructuralRendererBridge.snapshotForExpression(expression).tex
```

This protects these core templates from Unicode fallback rendering:

```text
√(□)      -> \sqrt{\Box}
□⁄□       -> \frac{\Box}{\Box}
∫₀¹(□)dx -> \int_{\Box}^{\Box}{\Box}\,dx
```

Plain expressions still use the older `MathTexSerializer` fallback path.

## Hit-test foundation

`SlotHitTesting` now separates visual rect and invisible hit rect conceptually:

- visual rect: the small premium highlight shown only for the active slot.
- hit rect: expanded invisible touch target.

Minimum target:

```text
44 × 44 logical pixels minimum
```

Selection scoring now considers:

1. slot priority,
2. slot depth,
3. point distance,
4. visual rect size,
5. stable role order,
6. stable id fallback.

## Frozen product decisions preserved

The following were not modified:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/long_press_indicator.dart`

The bottom-dock file remains as it was in the prior BottomDockFix package.

Preserved product decisions:

- `MORE` remains `MORE`.
- `Ans` remains visible one-tap key.
- `↵` remains evaluation / enter action.
- `=` remains literal equality symbol.
- Tabs and key order were not changed.
- Long-press map was not changed.

## Verification performed in this environment

- Full project ZIP prepared, not a patch.
- Meta / auditor ZIP prepared.
- Relative Dart import existence check passed.
- Dirty archive hygiene check passed for:
  - `build/`
  - `.dart_tool/`
  - `.gradle/`
  - `__pycache__/`
  - `.pyc`
  - `.pytest_cache/`
- Frozen keyboard source diff against the input BottomDockFix package: no intentional keyboard source changes.
- Static grep confirms the removed user-facing `Aktif slot:` line is no longer produced by `WorkspacePanel`.

## Not verified here

Flutter SDK is not installed in the packaging container. Therefore the following were not executed here:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run
```

These must be run locally before claiming runtime PASS.
