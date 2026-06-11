# V153 Token Boundary Editing Hardening Audit

## Scope
V153 targets deletion, operator replacement, and caret boundary behavior for typed primitive AST tokens introduced across V150-V152.

## Runtime Changes
- Multi-character typed primitive atoms now have atomic backspace coverage: subscripts, prime variants, overline/conjugate, `i²`, signed infinity/imaginary atoms, and differentials.
- Replaceable operator detection now includes typed comparison/equality/percent operators without changing the frozen keyboard.
- Linear caret anchor discovery now includes number-literal and typed-atom boundaries.

## Protected Areas
Keyboard layout/order, MORE labels, long-press order, Graph, History, Solution, EditorViewport, and EditorInteractionLayer were not intentionally changed.

## Local Tooling Truth
Flutter/Dart are not available in this environment, so `flutter pub get`, `flutter analyze`, `flutter test`, and `flutter run` were not executed here. User-side Flutter verification is required.

## Next Phase
V154: real-device full button QA closure and visual/hit-test polish for remaining problematic key/MORE/long-press/editor surfaces.
