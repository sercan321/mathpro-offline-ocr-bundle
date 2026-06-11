# MathPro V79 Premium Math Editor Engine Phase 01 Audit

## Scope
This phase starts the UI-first premium math editor engine migration without changing the frozen keyboard shell, tab order, MORE placement, Ans, `=`, `↵`, Graph, History, or Solution Steps surfaces.

## Implemented in this package

### 1. Display token vs internal semantic token separation
- Long-press and MORE no longer expose inverse trig as programmer tokens (`asin`, `acos`, `atan`) in user-facing lists.
- User-facing inverse trig labels are now `sin⁻¹(□)`, `cos⁻¹(□)`, `tan⁻¹(□)`, `sinh⁻¹(□)`, `cosh⁻¹(□)`, `tanh⁻¹(□)`.
- Legacy `asin(□)` / `acos(□)` / `atan(□)` aliases are still accepted internally so old history or saved expressions do not break.

### 2. Structural subscript node
- Added `MathNodeKind.subscript`.
- Added `NodeFactory.subscript()`.
- `x_□`, `y_□`, and `I_□` are parsed as structural subscript nodes with editable `subscript` slots.
- `xₙ`, `yₙ`, and `Iₙ` are treated as legacy aliases that route to editable placeholder forms.
- Slot registry now exposes `subscript` and `subscriptBase` roles.

### 3. Structural log-base node
- `MathNodeKind.logBase` is now used by the parser instead of treating log-base templates as loose text/function labels.
- `log₁₀(□)`, `log₂(□)`, `log_□(□)`, and `log₍□₎(□)` map to structural log nodes with separate base and argument slots.
- Slot registry now exposes `logBase` and `functionArgument` roles for log templates.

### 4. Structural inverse trig parsing
- `sin⁻¹(□)`, `cos⁻¹(□)`, `tan⁻¹(□)`, and hyperbolic inverse variants parse as `functionCall` nodes using visible mathematical operators.
- Legacy `asin`, `acos`, `atan`, `asinh`, `acosh`, `atanh` are canonicalized internally to visible mathematical display operators during node creation.

### 5. Test coverage added
- Added `test/v79_math_editor_engine_phase01_test.dart` for:
  - inverse trig long-press/MORE display contract,
  - structural subscript node creation,
  - structural log-base node creation,
  - structural inverse trig node creation.

## Explicitly preserved
- Keyboard topology and key positions.
- Root long-press contract: `['√□', '∛□', '□√□']`.
- Integral long-press contract: `['∫□dx', '∫ₐᵇ', '∬', '∭', '∮']`.
- MORE button text and location.
- Ans behavior.
- `↵` as evaluation.
- `=` as equality symbol.
- Graph, History, and Solution Steps files were not redesigned.

## Remaining phases
- Fraction/root/integral/derivative/sum/product node cleanup.
- Full node-layout-box renderer instead of remaining mixed text/template paths.
- Render-measured slot hit-test map for all templates.
- Long expression cursor-follow and pan/zoom refinement against the actual render map.
- Matrix/vector cell editing hardening.
- Visual golden tests on real Flutter runtime.

## Verification truth
The assistant environment did not contain Flutter/Dart, so `flutter analyze`, `flutter test`, and `flutter run` were not executed locally. This package includes static source changes and zip hygiene verification only. The user's machine remains the source of truth for Flutter runtime results.
