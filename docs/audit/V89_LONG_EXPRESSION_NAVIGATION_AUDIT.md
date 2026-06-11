# V89 — Long Expression Navigation / Pan / Caret-Follow Audit

## Scope

V89 is an editor/UI phase only. It does not add CAS, solver, OCR, camera, or solution-step intelligence.

The goal is to reduce the class of defects where long or deeply nested mathematical expressions become impossible to inspect, pan, or keep the active cursor/slot visible on a phone.

## Changed files

- `lib/features/formula_engine/long_expression_navigation_policy.dart`
- `lib/features/workspace/editor_viewport.dart`
- `test/v89_long_expression_navigation_contract_test.dart`
- `docs/audit/V89_LONG_EXPRESSION_NAVIGATION_AUDIT.md`
- `docs/audit/V89_CHANGED_FILES_MANIFEST.md`
- `README.md`
- `pubspec.yaml`

## Engineering changes

### Central navigation policy

A new `LongExpressionNavigationPolicy` now centralizes:

- long-expression navigation threshold;
- deep nesting detection;
- wide structural surface detection for calculus/matrix templates;
- canvas width calculation with a hard performance cap;
- role-aware active target inflation;
- role-aware visibility margins;
- safe transform clamping after pan/zoom;
- transform correction to keep the active slot/caret visible.

### Editor viewport integration

`EditorViewport` now delegates navigation, scale, canvas-width, boundary-margin and target-follow behavior to the central policy instead of hard-coding these values locally.

### Caret/slot follow behavior

When a slot or linear caret becomes active inside a long expression, the viewport adjusts toward the active target using role-aware margins. This is especially important for:

- `logBase`;
- `subscript`;
- `powerExponent`;
- `rootIndex`;
- `fractionNumerator` / `fractionDenominator`;
- integral/sum/product limits;
- matrix cells;
- derivative body slots.

### Safe pan/zoom bounds

After a user pan/zoom gesture, the transform is clamped so the expression cannot be pushed into a state where the user effectively loses the canvas. Scale is clamped to the existing premium range.

## Frozen areas

V89 does not intentionally modify:

- keyboard key positions;
- tab order;
- `MORE` label or placement;
- `Ans` semantics;
- `↵` evaluate semantics;
- `=` equality semantics;
- Graph UI;
- History UI;
- Solution Steps UI;
- root long-press contract;
- integral long-press contract.

## Non-claims

V89 is not a Photomath/WolframAlpha parity claim. It is one structural step toward premium math-editor interaction quality. Flutter analyze/test/run still require user-side execution because Flutter SDK is not available in the assistant container.
