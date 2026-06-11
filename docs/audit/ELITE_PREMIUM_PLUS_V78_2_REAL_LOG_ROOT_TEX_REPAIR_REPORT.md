# MathPro V78.2 — Real Log Indexed Root TeX Repair

## Source log
User-side real Flutter result after V78.1:
- `flutter pub get`: passed
- `flutter analyze`: `No issues found!`
- `flutter test`: one failing test

Failing test:
- `test/v71_premium_math_render_test.dart`
- Expected `\\sqrt[\\Box]{\\Box}`
- Actual contained `\\Box\\sqrt{\\Box}`

## Root cause
`MathTexSerializer._replaceKnownTemplates` converted the generic square-root substring `√□` before the indexed-root template `□√□`. In `□√□`, the substring `√□` was replaced first, producing `□\\sqrt{\\Box}` and preventing the intended indexed-root conversion.

## Repair
The indexed-root replacements were moved before the generic square-root replacement:
- `□√(□)` → `\\sqrt[\\Box]{\\Box}`
- `□√□` → `\\sqrt[\\Box]{\\Box}`
- then generic `√(□)` and `√□`

## Files changed
- `lib/features/editor/render/math_tex_serializer.dart`
- `pubspec.yaml` version bump to `0.78.2+782`

## Locked areas preserved
No changes were made to:
- keyboard layout files
- key positions
- tab order
- long-press lists
- solution panel
- evaluator / solver bridge

## Test status
Flutter is not available in the assistant environment, so no local `flutter analyze` or `flutter test` PASS is claimed. This repair directly targets the single real test failure reported by the user.
