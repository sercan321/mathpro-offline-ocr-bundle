# MathPro V67 — Audit Snapshot / Execution Lock

Created: 2026-05-14 20:45:10 UTC

## Baseline

- Baseline package: `MathProFlutterPhase17_ELITE_PREMIUM_PLUS_V66_1_ANALYZER_CLEAN_REPAIR_FULL.zip`
- Purpose: start the multi-phase repair sequence without silently changing production behavior.
- Production code changes in this phase: **none**.
- This phase adds only audit documents under `docs/audit/`.

## Reason for this phase

The reported issues are not one isolated warning. They affect layout constraints, editor viewport behavior, transformed hit-testing, deletion semantics, math label rendering, MORE/long-press content, and contract tests. Fixing all of them in one untracked commit would make Meta review harder and increase regression risk. V67 freezes the exact baseline before the real repairs start.

## Frozen red lines verified at snapshot time

The following files were hashed and left untouched in this phase:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/logic/evaluator_bridge.dart`
- `lib/features/solution/solution_step_models.dart`

See `ELITE_PREMIUM_PLUS_V67_AUDIT_SNAPSHOT_HASH_BASELINE.md` for exact SHA256 values.

## Confirmed source hotspots

- Shared width: `app_shell.dart`, `workspace_panel.dart`, `bottom_dock.dart`
- Long-expression navigation: `editor_viewport.dart`, `editor_interaction_layer.dart`, formula-engine hit-test utilities
- Slot hit-testing: `math_layout_engine.dart`, `slot_hit_testing.dart`, `render_mapped_slot_hit_test.dart`
- Atomic deletion / operator replacement / percent behavior: `calculator_controller.dart`, `calculator_actions.dart`, `key_handlers.dart`, `action_utils.dart`
- Premium math rendering: `math_label.dart`, `premium_key.dart`, `long_press_popup.dart`, `math_tex_serializer.dart`
- Long-press/MORE content cleanup: `key_config.dart`, `action_utils.dart`, existing keyboard tests

## Important discovery

`EditorViewport` currently enables pan/scale only when the expression is very long **and** does **not** contain `□`. This directly explains why nested template expressions and boxed structures do not behave like professional long equations: template-heavy expressions are excluded from panning even when they overflow.

## Next executable phase

V68 should be the first code-change phase:

1. Shared outer width repair.
2. No solution panel internals.
3. No key order changes.
4. Add/adjust tests only if needed to protect width contracts.
5. Deliver full zip + meta zip + diff/hash proof.

## Test truth

Flutter/Dart are not available in this execution environment. No local `flutter analyze`, `flutter test`, or `flutter run` PASS is claimed in this audit snapshot.
