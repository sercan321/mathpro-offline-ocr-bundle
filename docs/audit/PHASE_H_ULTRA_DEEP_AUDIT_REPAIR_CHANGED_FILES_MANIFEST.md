# Phase H Ultra Deep Audit Repair — Changed Files Manifest

Changed files:

1. `lib/features/editor/node_factory.dart`
   - Added parsing for filled compact definite integrals such as `∫₀¹(x)dx` and `∫ₐᵇ(x)dx`.
   - Added parsing for filled generic integrals such as `∫(x)dx`.
   - Keeps open-slot integral parsing compatible with previous Phase H behavior.

2. `lib/features/editor/tex_serializer.dart`
   - Hardened integral differential serialization so `dt`, `dx`, and `d\Box` keep the leading `d`.

3. `lib/features/editor/render/math_tex_serializer.dart`
   - Added fallback TeX coverage for filled compact/generic integral expressions.

4. `test/core_editor_regression_test.dart`
   - Added regression tests for filled integral structural rendering and differential preservation.

5. `docs/audit/PHASE_H_ULTRA_DEEP_AUDIT_REPAIR_REPORT.md`
   - Added this audit report.

6. `docs/audit/PHASE_H_ULTRA_DEEP_AUDIT_REPAIR_CHANGED_FILES_MANIFEST.md`
   - Added this manifest.

7. `docs/audit/PHASE_H_ULTRA_DEEP_AUDIT_REPAIR_CONTENTS.txt`
   - Added full package content listing.

Frozen keyboard files: unchanged.
