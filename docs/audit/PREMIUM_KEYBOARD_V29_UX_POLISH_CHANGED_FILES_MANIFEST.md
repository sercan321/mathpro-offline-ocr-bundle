# MathPro Premium Keyboard V29 — Changed Files Manifest

## Runtime files changed

- `lib/features/keyboard/key_config.dart`
  - Bumped keyboard layout marker to `v37-premium-keyboard-ux-polish`.
  - Simplified Temel expert row by moving `f(□)` / `θ` out of the visible Temel surface and replacing them with `=` / `n`.

- `lib/features/keyboard/long_press_indicator.dart`
  - Reduced long-press dot size and opacity for lower visual noise.

- `lib/features/keyboard/premium_key.dart`
  - Tightened long-press indicator visibility rules so only meaningful hidden math families show hints.

- `lib/features/keyboard/long_press_popup.dart`
  - Refined popup width calculation after the close-chip removal.
  - Softened popup border/shadow and reduced normal option chip width.

- `lib/features/workspace/template_tray.dart`
  - Polished MORE panel padding, radius, category chip scale, and template chip scale.

- `lib/features/workspace/math_label.dart`
  - Rebalanced fraction/system/matrix/vector glyph proportions for compact mobile keycaps.

## Audit files added

- `docs/audit/PREMIUM_KEYBOARD_V29_UX_POLISH_CHANGED_FILES_MANIFEST.md`
- `docs/audit/PREMIUM_KEYBOARD_V29_UX_POLISH_IMPLEMENTATION_REPORT.md`
- `docs/audit/PREMIUM_KEYBOARD_V29_UX_POLISH_RELEASE_HYGIENE_REPORT.md`
- `docs/audit/PREMIUM_KEYBOARD_V29_UX_POLISH_STATIC_CHECK.txt`

## Files deliberately not changed

- Graph runtime files
- History runtime files
- Solver/evaluator behavior outside key template mapping
- Android/Gradle project files
- Existing test files
