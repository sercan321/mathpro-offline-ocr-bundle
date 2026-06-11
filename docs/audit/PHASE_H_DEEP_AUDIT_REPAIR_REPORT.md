# MathPro Phase H Deep Audit + Repair Report

## Scope

Source package audited: `MathProFlutterPhase17_CoreEditor_PhaseH_FULL.zip`.

Audit target:

- Phase A debug-clean / TeX render lock
- Phase B MathNode + template / slot ownership
- Phase C invisible hit targets
- Phase D priority hit-test
- Phase E selection / caret controller
- Phase F pan/zoom coordinate transform
- Phase G regression contract
- Phase H real-device evidence gate
- Frozen keyboard / dock contract
- Release ZIP hygiene

## Environment limitation

This execution environment does not include Flutter or Dart, so the following commands could not be executed here:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Static file inspection, diff inspection, ZIP extraction checks, forbidden-cache checks, keyboard hash checks, and bracket-balance checks were performed.

## Findings

### PASS — ZIP opens cleanly

The Phase H full ZIP was extracted successfully and the project tree was readable.

### PASS — Release hygiene

No forbidden release artifacts were found in the repaired package:

- `build/`
- `.dart_tool/`
- `.gradle/`
- `__pycache__/`
- `*.pyc`
- `.pytest_cache`

### PASS — Keyboard contract preserved

The `lib/features/keyboard/` directory was compared against Phase H before repair. No keyboard file changed.

Preserved decisions:

- `MORE` stays `MORE`
- `Ans` remains a direct key
- `↵` remains the evaluation / enter command
- `=` remains literal text insert
- tab names unchanged
- key order unchanged
- long-press map unchanged
- bottom dock files unchanged

### PASS — User-facing debug leak surface

No user-facing `Aktif slot:` line, green debug rectangle, or raw slot-role toolbar label was reintroduced. Raw identifiers such as `sqrtValue`, `integralBody`, and `slotId` remain internal model/test/protocol identifiers only.

### CONDITIONAL — Flutter command evidence missing

Because Flutter SDK was not available in this environment, the package cannot honestly be marked as runtime PASS here. It remains a code-level repair until these are executed on the user's machine:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

## Defect found and fixed

### Defect: editable indexed-root slot/source mismatch

The previous Phase H package had a subtle source-of-truth mismatch around `ⁿ√`:

- The long-press `ⁿ√` template inserted `ⁿ√(□)`.
- The parser created an indexed-root AST with a `rootIndex` slot and a `sqrtValue` slot.
- But the source string only contained one visible `□`, inside the radicand.
- Therefore a future tap on the root-index slot could map to the wrong source placeholder and fill the radicand instead of the index.

This was a real editor-engine risk because it violated the Phase B/Phase C principle:

```text
visible/editable slot contract must match source placeholder contract
```

### Repair

The indexed-root template has been made source-aligned:

```text
old inserted expression: ⁿ√(□)
new inserted expression: □√(□)
```

This produces two real editable slots:

```text
rootIndex → first □
sqrtValue → second □
```

Legacy expressions are still supported:

```text
ⁿ√(□) → fixed n index + editable radicand only
```

So old saved expressions do not falsely expose a non-existent root-index source slot.

## Files changed in this repair

- `lib/logic/action_utils.dart`
  - `ⁿ√` now inserts `□√(□)` so index and radicand both have real source placeholders.

- `lib/features/editor/node_factory.dart`
  - Added parser support for editable indexed roots such as `□√(□)` and `n√(□)`.
  - Legacy `ⁿ√(□)` now parses with fixed textual index `n`, not fake editable `rootIndex`.

- `lib/features/editor/render/math_tex_serializer.dart`
  - Added fallback TeX support for `□√(□)` → `\sqrt[\Box]{\Box}`.

- `lib/features/formula_engine/templates.dart`
  - Synchronized stale template constants:
    - `indexedRoot = '□√(□)'`
    - `power = '□^(□)'`
    - `definiteIntegral = '∫_{□}^{□}(□)d□'`

- `test/core_editor_regression_test.dart`
  - Added regression coverage for indexed-root source alignment.
  - Added template constant drift checks.

## Static verification performed

- Full ZIP extraction checked.
- Keyboard directory diff checked: no changes.
- Forbidden cache/build artifact scan checked.
- Dart file bracket-balance static scan checked.
- Debug leak grep checked; runtime UI leak not found.
- Phase H vs repair changed-file diff reviewed.

## Remaining required user-machine checks

Run from project root:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Then perform the real-device protocol in:

```text
docs/PHASE_H_REAL_DEVICE_MANUAL_TEST_PROTOCOL.md
```

The final PASS decision is allowed only after those command results and real-device screenshot/video evidence exist.
