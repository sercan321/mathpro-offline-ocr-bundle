# Elite Premium Plus V50 — Math Render / Long-Press Symbol Alignment Audit Report

## Scope

V50 is a presentation-only phase for mathematical symbols, compact template glyphs and long-press chip surfaces. It does not add solver behavior, does not change keyboard topology, and does not change graph/history/solution logic.

## Runtime files changed

- `lib/features/workspace/math_label.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/editor/render/math_render_surface.dart`
- `lib/features/editor/render/premium_root_glyph.dart`
- `pubspec.yaml`
- `README.md`

## Key improvements

- `d/dx` compact glyph changed from inline slash text to stacked fraction-style notation.
- Derivative-family glyph spacing/rules were refined for premium compact math presentation.
- Slot boxes were made visually quieter and more consistent with graphite-glass UI language.
- Bounded integral compact glyph spacing was refined; long-press chip width is preserved above the existing envelope requirement.
- Long-press popup shell/chips were visually aligned with the V46–V49 graphite glass system without changing options.
- Math render surface text color/height was tuned for editor/result/inline roles.
- Root glyph stroke was refined for a more polished math-render accent.

## Frozen keyboard proof

The following source-of-truth keyboard files were not changed in V50:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`

`long_press_popup.dart` changed only visual shell/chip presentation and chip width guard. Long-press option lists remain sourced from `key_config.dart` and were not modified.

## Local verification limits

Flutter/Dart SDK is not installed in the assistant container. No local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed. The user-side Flutter log remains the authoritative runtime evidence.
