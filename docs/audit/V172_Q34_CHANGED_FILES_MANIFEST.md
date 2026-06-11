# V172-Q34 Changed Files Manifest

Production/code changes:

- `lib/features/formula_engine/deterministic_slot_geometry_registry.dart` — new deterministic cursor geometry authority.
- `lib/features/formula_engine/render_mapped_slot_hit_test.dart` — wires resolved slot rects through the Q34 registry.
- `lib/features/workspace/editor_caret_overlay.dart` — uses Q34 registry caret rects for active structural slots.
- `lib/logic/mathpro_package_contract.dart` — package metadata advanced to Q34.
- `tool/verify_mathpro_contract.py` — Q34 static gate.
- `README.md`, `pubspec.yaml` — Q34 identity.

Audit/report additions:

- `docs/audit/V172_Q34_DETERMINISTIC_SLOT_GEOMETRY_REGISTRY_AUDIT_REPORT.md`
- `docs/audit/V172_Q34_FILE_DIFF_VS_P6.csv`

P6 locked UI files were verified byte-identical and are not listed as changed.
