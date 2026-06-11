# V97 Real Device Cursor + Structural Slot Repair Audit

## Scope
This repair targets real-device failures reported after the V96 analyze/test pass. It does not add solver capability and does not change the frozen keyboard layout.

## Fixed / hardened areas
- Filled structural slots remain addressable after user input, including fraction numerator/denominator, log base/argument, limit variable/target/body, integral slots, big-operator slots, matrix/vector cells, power/subscript/root slots.
- Added selected-slot replacement and selected-slot clear paths for filled slots so users can edit/delete fraction numerator/denominator after entering values.
- Added parser support for legacy filled log form `log(2)(5)` and render/export it as a structural log-base node.
- Added parser support for filled limit form such as `lim_y → 8(8)` and render/export it as a structural limit node.
- Added parser support for filled `Σ(body)` / `Π(body)` forms so body slot edits do not collapse into plain text.
- Capped visible slot selection rectangles to avoid huge green overlays on long nested expressions and Σ/Π/body slots while preserving larger invisible hit targets.
- Long-press math labels are wrapped in scale-down FittedBox and chip widths were increased for math-heavy surfaces to reduce clipping.

## Preserved contracts
- Keyboard key positions unchanged.
- Tab order unchanged.
- MORE / Ans / ↵ / = semantics unchanged.
- Graph, History and Solution panel UI untouched.
- Root and integral long-press option contracts intentionally not changed.

## Honest limit
Flutter/Dart are not available in this assistant container, so local `flutter analyze`, `flutter test` and `flutter run` were not executed here. Real device verification remains required.
