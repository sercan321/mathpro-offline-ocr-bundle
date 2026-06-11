# V172-Q56 Structural Intent Resolver Audit Report

## Scope

Q56 is a cursor/editor-only repair. It preserves the existing MathPro cursor motor and adds `StructuralIntentResolverPolicy` so exact bundle hit, nearest structural hit and template-region intent resolve before detached linear fallback.

## Active package identity

```yaml
version: 0.172.89+172
description: MathPro Flutter phase 17 - V172-Q56 structural intent resolver.
```

## Protected-surface decision

The following surfaces remain frozen and were not edited in this phase:

- `lib/features/keyboard/key_config.dart`
- `lib/features/keyboard/math_keyboard.dart`
- `lib/features/keyboard/bottom_dock.dart`
- `lib/features/keyboard/long_press_popup.dart`
- `lib/features/keyboard/premium_key.dart`
- `lib/features/workspace/math_label.dart`
- `lib/features/workspace/template_tray.dart`
- `lib/app/app_shell.dart`
- `lib/features/solution/solution_steps_panel.dart`
- `lib/features/graph/graph_card.dart`
- `lib/features/history/history_controller.dart`
- `lib/features/history/history_panel.dart`

## Implementation notes

- New policy: `lib/features/formula_engine/structural_intent_resolver_policy.dart`
- Runtime wiring: `lib/features/editor/render/editor_interaction_layer.dart`
- Metadata/test-contract updates: `lib/logic/mathpro_package_contract.dart`, `README.md`, Q38-Q56 metadata tests, verifier.
- Structural intent now uses Q55 `SlotGeometryBundleAuthority` bundles rather than detached hit-only rectangles.
- Template-region linear fallback is suppressed when structural intent is available.
- Empty-slot `|□` leading-rail law is preserved; Q56 does not move the caret inside the placeholder.

## Honest limits

Q56 does not claim real-device +95 PASS, Photomath/Wolfram parity, full native renderer, stable AST slot to SVG node identity, or local Flutter analyze/test PASS from the assistant environment. Real Flutter and device evidence must come from the user's machine.

## Static verification

`python3 tool/verify_mathpro_contract.py` completed without hard failures inside the final extracted package.
