# V172-Q140 — MathLive Premium Surface Repair Audit Report

## Outcome

Q140 is a real behavior-repair package for the MathLive main editor. It does not claim real-device cursor PASS, Photomath/Wolfram-level PASS, Flutter analyze PASS, Flutter test PASS, or Flutter run PASS.

## Real-device defects targeted

- Visible `MathLive` badge/debug label covered the left side of the expression area.
- Main editor keyboard flow contained a selection-aware helper but the active `insertLatex()` path bypassed it.
- Structural templates overused `#?`, producing naked exponent, disconnected placeholders, broken radicals/fractions/integrals/sums/limits, and plain-text named templates.
- Named templates such as `Taylor` and `{3 denklem` could fall through to plain text insertion.
- Mathfield focus/caret could become sticky after a tap or keyboard command.
- MathLive chrome/virtual keyboard controls had to remain hidden while MathPro keyboard stayed primary.

## Implemented repairs

- Removed the visible Flutter `MathLive` migration badge from `MathLiveMainEditorSurface`.
- Added `premiumSurfaceRepairPhase = 'V172-Q140'` marker without changing the Q135-Q139 migration key.
- Routed active `insertLatex()` through `insertIntoMathfield()` so `replaceSelection` and `selectionMode: placeholder` are used by the real keyboard path.
- Added focus restoration before and after MathLive insertions.
- Added pointer/mouse/touch focus hardening for the WebView mathfield host and `<math-field>` element.
- Added `#0` to template detection and expanded template detection for `lim` and `cases`.
- Reworked main-editor template mappings for fraction, root, power, factorial, abs, trig/log, derivative, integral, limit, sum/product, Taylor/series, and system/cases labels.
- Added CSS relief for structural math: visible vertical overflow inside mathfield content, more generous line-height/min-height, lighter selection, placeholder styling hooks, touch action, pointer events, and text selection ownership.
- Preserved MathLive virtual keyboard/menu hiding CSS and JS.

## Protected surfaces

The following were intentionally not edited:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`

## Remaining real-device validation required

The user must run the app on device and verify:

- No visible `MathLive` badge covers the expression.
- No MathLive keyboard/menu chrome appears.
- `a/b`, `√x`, `x^y`, `∫dx`, `∫ₐᵇ`, `lim`, `Σ`, `Taylor`, and `{3 denklem` render as math structures instead of raw text.
- Caret can move from one tap target to another without getting stuck.
- Placeholders, radicals, fractions, limits, sums, and integrals are not clipped.

## PASS boundaries

Package-side static checks may pass, but real-device cursor/premium PASS remains unclaimed until screenshots/logs prove it.
