# V114 Real Log Analyze/Test Repair Audit

## Scope
V114 is a targeted real-log repair package based on the user-provided `flutter pub get`, `flutter analyze`, and `flutter test` output after the V109 package. It does not add solver capability, does not redesign Graph/History/Solution, and does not change keyboard layout.

## Real log failures targeted
- `SlotRegistry.fromRoot` missing in `test/v105_matrix_vector_piecewise_foundation_test.dart`.
- Analyzer info: unnecessary braces in string interpolation in `editor_commands.dart`.
- Analyzer warning: unnecessary null comparison in `calculator_controller.dart`.
- Analyzer info: prefer const declaration in `test/v98_real_device_p0_structural_repair_test.dart`.
- Regression failures around fixed integral slot exposure, indexed-root fixed index exposure, version-marker compatibility, inverse-trig canonical display, linked series propagation, subscript slot ordering, derivative parsing, and partial-fill structural slot ownership.

## Repairs
- Added `SlotRegistry.fromRoot(root)` as a backward-compatible alias for `SlotRegistry.build(root)`.
- Rebalanced filled-slot exposure so partial templates keep legacy open-slot ownership while fully filled real-device fraction/log/limit/big-operator surfaces can remain editable.
- Fixed fixed integral/indexed-root/power/subscript slot exposure drift by preventing false filled fixed-target slots.
- Protected inverse-trig notation (`sin⁻¹`, `cos⁻¹`, `tan⁻¹`) from the generic superscript-to-power canonicalizer.
- Moved derivative-like parsing ahead of generic power/subscript parsing so `d²/dx²(□)` stays a derivative node.
- Restored V66/V84 version marker compatibility while preserving later matrix/system wording.
- Made linked series propagation sequentially choose the first repeated open link-group, repairing Taylor/Binom/Geometric keyboard-fill regression.
- Removed the analyzer string interpolation warning and const declaration warning.
- Reworked filled-slot replacement checks in the controller to avoid the unnecessary-null-comparison warning pattern.

## Non-scope
- No keyboard layout/key order/long-press list change.
- No solver/step engine work.
- No Graph, History, or Solution panel UI work.
- No claim of Flutter PASS from this environment.

## Required user-side verification
Run:

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

V114 is a repair candidate until those logs are provided.
