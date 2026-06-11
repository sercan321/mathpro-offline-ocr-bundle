# V172-Q80R2 Changed Files Manifest

## Runtime / contract metadata

- `lib/logic/mathpro_package_contract.dart`
  - Fixes the unescaped apostrophe in `q73NativeSlotBoxHitTestRule` that broke Dart parsing.
  - Adds Q80R2 repair metadata.

- `lib/features/formula_engine/structural_intent_resolver_policy.dart`
  - Suppresses the obsolete unused private helper warning without re-enabling nearest structural fallback.

## Tests

- `test/v172_q78_fraction_function_root_log_native_slotbox_specialization_test.dart`
  - Replaces invalid `MathNodeKind.root` with `MathNodeKind.indexedRoot`.

## Documentation / release evidence

- `README.md`
- `pubspec.yaml`
- `docs/audit/V172_Q80R2_REAL_FLUTTER_ANALYZE_REPAIR_REPORT.md`
- `docs/audit/V172_Q80R2_CHANGED_FILES_MANIFEST.md`

## Protected files

The protected keyboard/UI/Graph/History/Solution files were not changed.
