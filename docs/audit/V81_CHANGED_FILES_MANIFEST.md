# V81 Changed Files Manifest

- `pubspec.yaml` — version bumped to `0.81.0+810`.
- `lib/logic/premium_math_key_specs.dart` — added centralized PremiumMathKeySpec source-of-truth for public math labels, canonical template expressions, focus roles, expected node families, and required slot roles.
- `lib/logic/action_utils.dart` — routes structure insertions through `PremiumMathKeySpecs` before falling back to older switch logic.
- `lib/logic/math_key_inventory.dart` — exposes spec-backed audit entries and protected-surface inventory checks.
- `lib/features/editor/node_factory.dart` — expands structural parsing for wrappers, generic log, named functions, matrix/linear helper functions, limits, and nested role propagation.
- `lib/features/editor/tex_serializer.dart` — improves TeX serialization for wrapper/function nodes including abs/floor/ceil/generic log and named functions.
- `lib/features/editor/render/math_tex_serializer.dart` — adds legacy-display support for generic `log(□)`, floor, and ceil templates.
- `lib/features/editor/editor_commands.dart` — expands atomic deletion recognition for abs/floor/ceil wrappers.
- `test/v81_premium_math_key_spec_core_test.dart` — adds V81 regression coverage for MathKeySpec routing, structural node parsing, public-token hygiene, and slot-role contracts.
- `docs/V81_PREMIUM_MATH_KEY_SPEC_CORE_AUDIT.md` — documents V81 scope, preserved contracts, limitations, and required local verification.
