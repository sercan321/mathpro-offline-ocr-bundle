# Elite Premium Plus V50 — Changed Files Manifest

## Runtime changes

1. `lib/features/workspace/math_label.dart`
   - Improved compact derivative and derivative-family math glyphs.
   - Refined bounded integral compact spacing.
   - Refined slot box visual treatment.

2. `lib/features/keyboard/long_press_popup.dart`
   - Refined graphite-glass popup/chip presentation.
   - Increased bounded integral long-press chip width guard to remain above the expected test envelope.
   - No option lists were changed.

3. `lib/features/editor/render/math_render_surface.dart`
   - Tuned editor/result/inline math color and height for premium render consistency.

4. `lib/features/editor/render/premium_root_glyph.dart`
   - Refined root glyph stroke/geometry.

5. `pubspec.yaml`
   - Version bumped to `0.50.0+50`.

6. `README.md`
   - V50 package notes added.

## Explicitly unchanged frozen keyboard files

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
