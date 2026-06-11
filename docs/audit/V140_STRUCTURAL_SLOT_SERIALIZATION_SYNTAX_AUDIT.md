# V140 Structural Slot Serialization Syntax and Round-Trip Audit

V140 continues the MathPro keyboard / MORE / long-press unification work without changing key positions, tab order, MORE, Ans, =, ↵, long-press ordering, Graph, History, Solution, EditorViewport layout, or EditorInteractionLayer behavior.

## Scope

- Keep active package metadata current at V140.
- Remove stale V139 active-version markers from pubspec authority.
- Repair the structural plain serializer matrix branch so it cannot carry a stale extra-brace defect.
- Add regression coverage for filled structural slots across definite integrals, limits, Σ/Π, matrix/vector and postfix templates.
- Keep MathJax SVG-only DOM commit and assistive-MathML purge untouched.

## Changed files

- pubspec.yaml
- README.md
- lib/logic/mathpro_package_contract.dart
- lib/logic/math_key_visual_contract.dart
- lib/features/editor/editor_commands.dart
- test/v139_structural_slot_roundtrip_series_persistence_test.dart
- test/v140_structural_slot_serialization_syntax_audit_test.dart
- docs/audit/V140_STRUCTURAL_SLOT_SERIALIZATION_SYNTAX_AUDIT.md
- docs/audit/V140_CHANGED_FILES_MANIFEST.md

## Preserved contracts

The following areas were not modified: keyboard layout files, Graph, History, Solution, EditorViewport, EditorInteractionLayer, key positions, tab order, MORE, Ans, =, ↵ and long-press ordering.
