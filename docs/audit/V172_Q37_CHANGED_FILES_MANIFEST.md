# V172-Q37 Changed Files Manifest

## Changed/Added Versus Q36 Scope

- `pubspec.yaml` — advances package identity to Q37.
- `README.md` — adds Q37 release notes.
- `lib/logic/mathpro_package_contract.dart` — advances active contract metadata to Q37.
- `lib/features/formula_engine/fraction_precision_cursor_policy.dart` — new fraction lane policy.
- `lib/features/formula_engine/slot_hit_testing.dart` — routes overlapping fraction candidates through Q37 lane resolution.
- `lib/features/formula_engine/deterministic_slot_geometry_registry.dart` — exposes Q37 fraction precision markers without changing P6 UI files.
- `tool/verify_mathpro_contract.py` — adds Q37 static contract gate.
- `docs/audit/V172_Q37_*` — audit evidence and diff report.

## Explicitly Untouched P6-Locked Areas

- Keyboard layout and key config.
- Visible key faces / `premium_key.dart`.
- MORE tray / `template_tray.dart`.
- Long-press popup.
- App shell/layout.
- MathLabel.
- Graph, History, Solution protected files.
