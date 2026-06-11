# V172-Q115 Structural Caret Anchor Geometry Repair Audit Report

## Status

Package-side repair implemented. This is **not** a Q108/Q87 real-device cursor PASS claim.

## Scope

Q115 is a cursor/editor geometry repair only. It adds a final structural caret anchor guard so an active empty slot resolves to the visible placeholder's immediate leading rail (`|□`) after the existing SlotGeometryBundle, native SlotBox painter, structural hardening, and overlay paint paths have run.

## User failure class addressed

- Caret can appear on top of structural boxes.
- Caret can appear detached / too far from visible placeholder boxes.
- Failed Q108 families include empty placeholder, fraction numerator/denominator, sqrt/radicand, power exponent, subscript, log base/body separation, and integral limit/body/differential routing.

## Files changed

- `lib/features/formula_engine/mathlive_structural_caret_anchor_geometry_repair_policy.dart`
- `lib/features/formula_engine/slot_geometry_bundle_authority.dart`
- `lib/features/formula_engine/structural_cursor_release_hardening_policy.dart`
- `lib/features/workspace/editor_caret_overlay.dart`
- `test/v172_q115_structural_caret_anchor_geometry_repair_test.dart`
- `tool/verify_mathlive_structural_caret_anchor_geometry_repair.mjs`
- `docs/audit/V172_Q115_STRUCTURAL_CARET_ANCHOR_GEOMETRY_REPAIR_AUDIT_REPORT.md`
- `docs/audit/V172_Q115_STRUCTURAL_CARET_ANCHOR_GEOMETRY_REPAIR_CHANGED_FILES_MANIFEST.md`
- `README.md`

## Protected surface statement

No keyboard layout, key order, MORE behavior, long-press map, AppShell, MathLabel, TemplateTray, Solution, Graph, or History UI files were intentionally changed.

## Non-claims

- MathLive is not made the main/default editor.
- Legacy cursor files are not deleted.
- Q108/Q87 real-device cursor PASS is not claimed.
- Photomath/Wolfram +95 is not claimed.
- Release PASS is not claimed.

## Next required evidence

The user must rerun Flutter analyze/test and then repeat the Q108 real-device cursor court. The package-side Q115 report intentionally keeps `mayClaimCursorPass`, `maySwitchMainEditor`, and `mayDeleteLegacyCursor` false.
