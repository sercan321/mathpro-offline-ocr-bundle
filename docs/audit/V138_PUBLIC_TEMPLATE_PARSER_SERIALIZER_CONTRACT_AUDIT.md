# V138 Public Template Parser/Serializer Contract Audit

V138 continues the MathPro keyboard / MORE / long-press unification work without changing key positions, tab order, MORE, Ans, =, ↵, long-press ordering, Graph, History, Solution, EditorViewport layout, or EditorInteractionLayer behavior.

## Scope

- Active package metadata advanced to V138 through `MathProPackageContract`.
- Added a high-risk public template parser/serializer inventory sourced from the actual keyboard, MORE and long-press surfaces.
- Added a V138 regression test to ensure high-risk public templates route through `InsertTemplateAction`, parse into non-empty AST nodes, preserve registry slot roles, and serialize without stale raw/programmer-token output.
- Kept MathJax SVG-only DOM commit and assistive MathML purge locked.

## Non-goals

- No keyboard layout changes.
- No key position changes.
- No long-press ordering changes.
- No Graph / History / Solution changes.
- No solver changes.

## Manual verification still required

Flutter/Dart are not available in this environment. Run:

```powershell
flutter clean
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
