# MathPro V45 — Changed Files Manifest

## Runtime files

1. `lib/theme/mathpro_tokens.dart`
   - Updated core palette to Graphite Glass Pro.
   - Added card/dock/key shadow tokens.
   - Refined accent, border, text, amber and teal values.

2. `lib/theme/mathpro_typography.dart`
   - Refined key/tab typography letter spacing and hint tone.

3. `lib/features/workspace/workspace_panel.dart`
   - Replaced flat result-card grey with graphite glass gradient.
   - Refined border, shadow, separator and card icon button surface.
   - Kept existing card keys and graph/history/solution action identities.

4. `lib/features/workspace/editor_viewport.dart`
   - Refined empty-slot ghost and caret visual treatment.
   - Kept editor interaction and slot logic unchanged.

5. `lib/features/editor/render/math_render_surface.dart`
   - Refined editor/result render colors.
   - Kept renderer, serializer, and fallback flow unchanged.

6. `lib/features/keyboard/bottom_dock.dart`
   - Added a premium graphite keyboard tray.
   - Refined tab-chip surface/border/shadow.
   - Kept tab list, callbacks, long-press flow, dock metrics and bottom inset guard.

7. `lib/features/keyboard/premium_key.dart`
   - Refined ceramic/metal key gradient, border, shadow, pressed scale and inner rim.
   - Refined amber C key and pastel teal action key styling.
   - Kept stable ValueKeys, labels, semantics, tap/long-press flow and long-press indicator logic.

8. `pubspec.yaml`
   - Version bumped to `0.45.0+45`.

9. `README.md`
   - Added V45 release note.

## Critical files intentionally not edited

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/long_press_popup.dart`
