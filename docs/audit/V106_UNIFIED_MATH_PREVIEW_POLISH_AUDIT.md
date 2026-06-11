# V106 — Unified Math Preview + Real Device Polish Foundation Audit

## Scope

V106 does not add a solver and does not change keyboard layout, tab order, MORE semantics, Ans, ↵, =, Graph, History, or Solution panel behavior.

The goal is to reduce real-device clipping / weak mathematical preview drift across:

- keycaps
- long-press cards
- MORE chips
- compact inline math labels

## Main repair

A new central preview policy was added:

- `lib/features/formula_engine/unified_math_preview_policy.dart`

This policy centralizes compact preview decisions that were previously scattered across several UI surfaces:

- canonical preview label
- math-preview eligibility
- long-press chip width
- MORE chip min/max width
- viewport protection classification

## Behavioral intent

The following labels are now normalized before preview rendering:

- `asin(□)` → `sin⁻¹(□)`
- `log(2)(5)` → `log₍2₎(5)`
- `lim_y → 8(8)` → `lim₍y→8₎(8)`

The purpose is to avoid programmer-token leakage and make every compact math surface use the same display vocabulary.

## UI integration

The policy is wired into:

- `MathLabel`
- `PremiumKey`
- `LongPressPopup`
- `TemplateTray`

MORE math chips now use `FittedBox` for math labels instead of allowing dense glyph widgets to clip inside small chip bounds. Dense calculus/series/function labels receive larger min/max width reserves.

`MathLabel` now has compact support for filled preview forms such as:

- `log₍2₎(5)`
- `lim₍y→8₎(8)`
- `Π`

## Changed files

- `pubspec.yaml`
- `lib/features/formula_engine/math_expression_render_bridge.dart`
- `lib/features/formula_engine/unified_math_preview_policy.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`
- `test/v106_unified_math_preview_polish_test.dart`
- `docs/audit/V106_UNIFIED_MATH_PREVIEW_POLISH_AUDIT.md`
- `docs/audit/V106_CHANGED_FILES_MANIFEST.md`

## Contract preservation

The following are not changed intentionally:

- keyboard layout
- tab order
- key maps / long-press maps
- MORE wording
- Ans behavior
- ↵ / = semantics
- Graph UI
- History UI
- Solution panel UI

## Test status

Flutter/Dart SDK was not available in the assistant container, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.

The package must be validated by the user with:

```bash
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Manual real-device checks

1. MORE → Fonksiyon: log chips must not look clipped or disconnected.
2. MORE → Kalkülüs: `lim sin(x)/x`, integral and series chips must remain readable.
3. Long-press `Σ`: `Π`, Taylor/Maclaurin/series options should not clip at card edges.
4. Long-press `log`: base/argument preview should be visually connected.
5. Long-press `sin/cos/tan`: inverse labels must stay as math notation, not programmer tokens.
6. Existing editor slot behavior must not regress.
