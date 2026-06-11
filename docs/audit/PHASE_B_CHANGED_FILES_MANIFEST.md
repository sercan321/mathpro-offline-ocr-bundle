# PHASE B CHANGED FILES MANIFEST

## Modified source files

1. `lib/features/editor/node_factory.dart`
   - Added partial-fill structural parsing for fraction, sqrt, power, and editable definite integral templates.
   - Added fixed-limit vs editable-limit integral distinction.

2. `lib/features/editor/slot_registry.dart`
   - Added addressable-slot filtering so non-placeholder fixed text slots do not create false hit targets.
   - Updated registry version.

3. `lib/features/editor/editor_commands.dart`
   - Replaced brittle role-index mapping with MathNode traversal-based placeholder index resolution.

4. `lib/features/editor/tex_serializer.dart`
   - Added editable differential rendering as `d\Box` while preserving fixed `dx` output.

5. `lib/features/editor/render/math_render_surface.dart`
   - Keeps structural TeX rendering active for filled structural expressions, not only expressions with open slots.

6. `lib/features/formula_engine/math_layout_engine.dart`
   - Updated version marker only.

7. `lib/features/formula_engine/slot_engine_self_check.dart`
   - Added Phase B smoke expressions for canonical power, editable definite integral, nested root, and partial fractions.

8. `lib/logic/action_utils.dart`
   - `^` now inserts canonical `□^(□)`.
   - `∫ₐᵇ` now inserts canonical editable `∫_{□}^{□}(□)d□`.
   - `³√` focus corrected to `sqrtValue`; `ⁿ√` still focuses `rootIndex`.

9. `test/widget_test.dart`
   - Added Phase B structural ownership and integral slot regression tests.

## Added audit files

1. `docs/audit/PHASE_B_CORE_EDITOR_ENGINE_AUDIT.md`
2. `docs/audit/PHASE_B_CHANGED_FILES_MANIFEST.md`
3. `docs/audit/PHASE_B_REGRESSION_REPORT.md`
4. `docs/audit/PHASE_B_RELEASE_HYGIENE_REPORT.md`
5. `docs/audit/PHASE_B_KEYBOARD_FREEZE_HASH_CHECK.md`
