# V82 Changed Files Manifest

Changed files:
- `pubspec.yaml` — version bumped to `0.82.0+820`.
- `lib/logic/premium_math_key_specs.dart` — expanded Phase-04 public math surface spec coverage.
- `lib/logic/math_key_inventory.dart` — added Phase-04 required public-surface audit lists.
- `lib/logic/action_utils.dart` — removed duplicate unreachable `tan⁻¹` return.
- `lib/features/formula_engine/slot_interaction_calibration_policy.dart` — calibrated mobile targets for subscript/logBase/derivativeOrder slots.
- `lib/features/formula_engine/render_mapped_slot_hit_test.dart` — added visual rect sizing for subscript/logBase/derivativeOrder slots.
- `lib/features/formula_engine/template_slot_navigation_policy.dart` — added deterministic ordering for subscript/logBase/derivativeOrder slots.
- `lib/features/formula_engine/slot_priority_policy.dart` — added hit-priority support for subscript/logBase/derivativeOrder slots.
- `test/v82_phase04_full_surface_slot_audit_test.dart` — added Phase-04 full-surface audit regression tests.
- `docs/audit/V82_PHASE04_FULL_SURFACE_SLOT_AUDIT_REPORT.md` — audit report for this phase.

Unchanged by design:
- Keyboard positions and tab order.
- MORE/Ans/=/↵ semantics.
- Graph, History, and Solution panel UI.
