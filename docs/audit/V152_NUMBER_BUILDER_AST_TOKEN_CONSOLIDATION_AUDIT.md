# V152 Number Builder AST Token Consolidation Audit

## Scope

V152 continues the long-term single-tree math input plan without changing keyboard layout, tab order, MORE, Ans, ↵, Graph, History, Solution, EditorViewport, or EditorInteractionLayer.

## Change

`NodeFactory` now groups numeric runs such as `12`, `12.3`, `0.5`, and `.75` into one typed `numberLiteral` AST token with `numberBuilder` metadata. Standalone `.` remains a primitive number token so the frozen key behavior is not changed.

## Guardrails

- Commands remain commands and are not AST expression nodes.
- Operators and primitive symbols keep V151 typed-token behavior.
- No protected keyboard/surface files were intentionally changed.
- No Flutter PASS is claimed by this audit document.

## Not Verified Here

Flutter was not available in the packaging environment. The user must run `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run -d 23106RN0DA`.
