# V151 Primitive and Operator AST Token Transition Audit

## Scope

V151 repairs a stale packaging gap after the previous handoff: the inspected source still carried `0.150.0+150` metadata. This package advances the real project metadata to `V151 / 0.151.0+151` and starts the long-term primitive/operator AST transition without changing the frozen keyboard layout or major visual surfaces.

## Intent

Long-term MathPro direction is that every mathematical input, except commands, must live inside the editor node tree. V151 does not turn primitive keys into structural templates and does not alter command behavior. Instead, it makes the parser classify primitive mathematical input as typed AST tokens:

- number tokens: `0-9`, `.`
- symbol tokens: variables/constants such as `x`, `y`, `π`, `e`, `i`, `θ`, `λ`, `μ`, `φ`, `ρ`, `∞`, `rad`, `deg`
- operator/delimiter tokens: `+`, `−`, `×`, `÷`, `%`, `=`, relations, commas, semicolon, parentheses, brackets, `±`, `·`
- differential/signed atom tokens: `dx`, `dy`, `dt`, `dθ`, `−i`, `+∞`, `−∞`

## Runtime Safety Boundary

The following command semantics remain protected:

- `C` stays `ClearAction`
- `⌫` stays `BackspaceAction`
- `MORE` stays `ToggleTemplateTrayAction`
- `Ans` stays `InsertAnswerAction`
- `↵` stays `EvaluateAction`

Basic operators continue to use the frozen text insertion path so the existing consecutive-operator replacement rule is not bypassed.

## Changed Files

- `lib/features/editor/node_factory.dart`
- `lib/logic/mathpro_package_contract.dart`
- `pubspec.yaml`
- `README.md`
- `test/v151_primitive_operator_ast_token_transition_test.dart`
- `docs/audit/V151_PRIMITIVE_OPERATOR_AST_TOKEN_TRANSITION_AUDIT.md`
- `docs/audit/V151_CHANGED_FILES_MANIFEST.md`

## Protected Files Not Edited

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_panel.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/workspace/editor_viewport.dart`
- `lib/features/editor/render/editor_interaction_layer.dart`

## Verification Status

Static package checks were performed in the assistant container. Flutter/Dart commands were not available in the assistant environment, so this audit does not claim `flutter analyze`, `flutter test`, or device `flutter run` PASS.
