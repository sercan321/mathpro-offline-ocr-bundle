# MathPro V80 Changed Files Manifest

## Code

- `lib/logic/math_key_inventory.dart` — new central keyboard/long-press/MORE audit surface.
- `lib/logic/action_utils.dart` — MORE trig public labels normalized to mathematical notation; power labels routed to structural power templates.
- `lib/features/keyboard/key_config.dart` — keyboard layout version updated; new trig/MORE mathematical aliases registered without moving keys.
- `lib/features/keyboard/long_press_popup.dart` — mathish/wide chip support extended for new trig notation.
- `lib/features/keyboard/premium_key.dart` — math label recognition extended for new trig notation.
- `lib/features/workspace/math_label.dart` — compact premium glyph support added for `cot(□)`, `cot⁻¹(□)`, `sec(□)`, `csc(□)`, `coth(□)`.
- `lib/features/editor/node_factory.dart` — parser support added for `cot`, `cot⁻¹`, `sec`, `csc`, `coth`; legacy `acot` canonicalized to `cot⁻¹`.
- `lib/features/editor/tex_serializer.dart` — TeX serializer support added for `cot`, `cot⁻¹`, `sec`, `csc`, `coth`.
- `lib/features/editor/editor_commands.dart` — atomic edit/delete function names expanded for the same trig family.
- `lib/features/editor/render/math_tex_serializer.dart` — inverse-function replacement order repaired before generic superscript cleanup; trig renderer support expanded.

## Tests

- `test/v80_full_keyboard_more_inventory_audit_test.dart` — new regression/audit test for public UI labels, MORE trig notation, high-risk node parsing, and placeholder-template routing.

## Metadata / Docs

- `pubspec.yaml` — version bumped to `0.80.0+800`.
- `docs/audit/V80_FULL_KEYBOARD_MORE_INVENTORY_AUDIT_REPORT.md` — phase audit report.
- `docs/audit/V80_CHANGED_FILES_MANIFEST.md` — this manifest.

## Explicitly not changed

- Keyboard key positions.
- Tab order.
- `MORE` text/name.
- `Ans`, `↵`, and `=` semantics.
- Graph/history/solution panel UX.
