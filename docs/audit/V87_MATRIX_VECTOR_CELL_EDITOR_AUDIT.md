# MathPro V87 — Matrix / Vector Real Cell Editor Audit

## Scope

This phase starts the Phase-09 linear algebra migration without changing the frozen keyboard shell.  The goal is not to add a solver.  The goal is to make matrix and vector input behave less like bracket strings and more like real editable math structures.

## Changed areas

- `lib/features/editor/node_factory.dart`
- `lib/features/editor/matrix_cell_navigation_policy.dart`
- `lib/features/formula_engine/template_slot_navigation_policy.dart`
- `lib/features/formula_engine/render_mapped_slot_hit_test.dart`
- `lib/features/formula_engine/slot_interaction_calibration_policy.dart`
- `lib/logic/premium_math_key_specs.dart`
- `pubspec.yaml`
- `test/v87_matrix_vector_cell_editor_contract_test.dart`

## Product contract preserved

- Keyboard key positions were not changed.
- Tab order was not changed.
- MORE, Ans, `↵`, and `=` semantics were not changed.
- Graph / History / Solution panel UI was not modified.
- Root and integral long-press contracts were not changed.

## What was improved

### 1. Matrix/vector bracket parsing

The parser can now promote filled bracket notation into real matrix/vector nodes instead of leaving it as raw text:

- `[□ □; □ □]` → `MathNodeKind.matrix`
- `[1 2; 3 4]` → `MathNodeKind.matrix`
- `[□; □; □]` → `MathNodeKind.vector`
- `[5; 6; 7]` → `MathNodeKind.vector`
- `[5 6 7]` → row-vector node

### 2. Matrix/vector cells remain addressable after being filled

Matrix and vector cells now remain slot-registry entries even when a cell contains a real value.  This is required for professional editing: the user must be able to tap a filled cell and edit/replace it rather than only editing empty `□` cells.

### 3. Row-major focus/navigation policy

A new pure policy file was added:

```text
lib/features/editor/matrix_cell_navigation_policy.dart
```

It provides row-major ordering, next-cell and previous-cell behavior for matrix/vector slots.

### 4. Two-dimensional hit-test preservation

Render-mapped hit testing no longer flattens matrix/vector placeholders back onto one inline text row.  Matrix cells keep the 2D grid geometry from the structural layout layer.  This is necessary for comfortable mobile tapping in 2x2, 3x3, 4x4 and preview m×n matrices.

### 5. Public matrix key contract cleanup

`0 matris` is now backed by a structural zero-matrix expression (`[0 0; 0 0]`) rather than the scalar text `0` while preserving the public key label.

## Non-goals / remaining risk

- This does not add matrix solving.
- This does not implement a full spreadsheet-like matrix editor UI yet.
- This does not prove real-device UX; the user must still run `flutter run` and manually tap cells.
- Flutter SDK was not available in the assistant environment, so local analyze/test/run PASS is not claimed.

## Required user-side verification

```bash
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
