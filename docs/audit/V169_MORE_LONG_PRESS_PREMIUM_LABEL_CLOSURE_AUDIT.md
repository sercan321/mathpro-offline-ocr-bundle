# V169 MORE + Long-Press Premium Label Closure Audit

## Scope

V169 restores the visible label layer for keyboard keycaps, MORE chips and long-press options after semantic template migration leaked internal AST/template previews into the UI.

## Binding Rule

Visible label and execution contract are separate:

- visible UI label: what the user sees on keycap/MORE/long-press
- canonical template expression: hidden insertion/AST/slot contract used by ActionUtils/NodeFactory

A human-readable label such as `Taylor`, `Kuadratik`, `EBOB`, `EKOK`, `2×2 Matris`, `RREF`, `Rank`, or a bare function key such as `sin`, `cos`, `tan`, `ln`, `log` must not be replaced by hidden template/debug text.

## Changed Files

- `lib/features/formula_engine/unified_math_preview_policy.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/workspace/template_tray.dart`
- `pubspec.yaml`
- `README.md`
- `lib/logic/mathpro_package_contract.dart`
- `docs/audit/V169_MORE_LONG_PRESS_PREMIUM_LABEL_CLOSURE_AUDIT.md`

## Explicitly Preserved

- keyboard positions
- tab order
- MORE action semantics
- long-press option ordering
- Graph UI
- History UI
- Solution panel UI
- EditorViewport layout
- EditorInteractionLayer behavior
- AST/node insertion contracts

## Static Verdict

This is a static package repair. Flutter was not available in the assistant environment, so no local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed.
