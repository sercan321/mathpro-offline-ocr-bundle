# Phase H Deep Audit Repair — Changed Files Manifest

## Runtime/editor files

1. `lib/logic/action_utils.dart`
   - Changed `ⁿ√` inserted expression from `ⁿ√(□)` to `□√(□)`.

2. `lib/features/editor/node_factory.dart`
   - Added editable indexed-root parser support for `□√(□)` / `n√(□)`.
   - Changed legacy `ⁿ√(□)` parsing to fixed `n` index + editable radicand only.

3. `lib/features/editor/render/math_tex_serializer.dart`
   - Added fallback TeX mapping for `□√(□)`.

4. `lib/features/formula_engine/templates.dart`
   - Synchronized stale constants with current structural templates.

## Tests

5. `test/core_editor_regression_test.dart`
   - Added regression checks for indexed-root source alignment and template constant drift.

## Audit docs

6. `docs/audit/PHASE_H_DEEP_AUDIT_REPAIR_REPORT.md`
   - New deep-audit repair report.

7. `docs/audit/PHASE_H_DEEP_AUDIT_REPAIR_CHANGED_FILES_MANIFEST.md`
   - This manifest.

## Explicitly unchanged

- `lib/features/keyboard/` — unchanged
- bottom dock layout — unchanged
- tab names — unchanged
- long-press map — unchanged
- `MORE`, `Ans`, `↵`, `=` behavior — unchanged
