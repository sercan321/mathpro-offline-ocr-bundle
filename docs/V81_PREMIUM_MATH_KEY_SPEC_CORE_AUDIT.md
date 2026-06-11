# MathPro V81 — Premium MathKeySpec Core Migration Audit

## Scope

V81 is a UI/editor-engine phase. It does **not** add a real solver and it does **not** claim Photomath/WolframAlpha parity. It moves more of the visible keyboard, long-press, and MORE math surface toward a centralized math-editor contract so the same public-token defects do not keep returning.

## Non-negotiable contracts preserved

- Keyboard tab order remains: `Temel`, `Cebir`, `Kalkülüs`, `Kompleks`, `Lineer Cebir`.
- Base core keyboard still includes `MORE`, `0`, `.`, `Ans` in the frozen bottom row.
- `MORE` remains text label, not `...`.
- `↵` remains evaluate.
- `=` remains equality symbol.
- Root long-press contract remains `√□`, `∛□`, `□√□`.
- Integral long-press contract remains `∫□dx`, `∫ₐᵇ`, `∬`, `∭`, `∮`.
- Graph, History, and Solution panel UX were not redesigned in this phase.

## Added source-of-truth

New file:

- `lib/logic/premium_math_key_specs.dart`

This introduces `PremiumMathKeySpec` and `PremiumMathKeySpecs`. Each protected math surface can now bind:

- public label
- canonical inserted expression
- preferred focus role
- expected root `MathNodeKind`
- audit family
- required slot roles
- legacy alias flag

This specifically protects high-risk families:

- subscript
- fraction
- root
- power
- wrappers such as absolute/floor/ceil/norm
- trig/inverse trig
- log/log-base
- complex functions
- derivative/integral/limit/big-operator
- matrix/vector
- named functions and linear algebra function wrappers

## Runtime behavior changes

- `ActionUtils.templateSpecForStructure()` now checks `PremiumMathKeySpecs` first, before legacy switch fallbacks.
- Generic `log(□)` is now parsed as a structural `functionCall` instead of falling back to raw text.
- `|□|`, `‖□‖`, `⌊□⌋`, and `⌈□⌉` now parse as function/wrapper nodes rather than plain character wrappers.
- `f(□,□)`, `det(□)`, `rref(□)`, `rank(□)`, `eig(□)`, `solve(□)`, `EBOB(□,□)`, `EKOK(□,□)`, `asal?(□)`, and related named functions are now recognized by `NodeFactory` as `functionCall` nodes.
- `limₓ→□(□)`, `limₓ→∞(□)`, `limₓ→0⁺(□)`, `limₓ→0⁻(□)`, and related limit forms are parsed into `limit` nodes.
- Nested placeholder parsing now propagates the requested slot role through `_slotNodeFromToken()`. This prevents multi-slot expressions like `f(□,□)` or `e^(i□)` from losing their intended editor role and falling back to anonymous `body` slots.
- Legacy TeX rendering now explicitly supports `log(□)`, `⌊□⌋`, and `⌈□⌉`.

## Added regression test

New file:

- `test/v81_premium_math_key_spec_core_test.dart`

The test locks:

- frozen keyboard shell
- duplicate-free `PremiumMathKeySpec` registry
- no public programmer-token leak for `asin/acosh/atan/acot` family
- canonical `ActionUtils` routing through specs
- node parsing for high-risk expressions
- legacy TeX display for log/inverse trig/floor/ceil
- required slot roles for spec-backed non-legacy templates

## Honest limitations

- This is not a final Photomath/WolframAlpha-level editor engine.
- The project still stores the live expression as a lightweight string while structural parsing/rendering/slot mapping are progressively hardened.
- Full node-first editing for every single MathPro surface is not finished in this phase.
- Real solver/CAS remains out of scope.
- Flutter SDK was not available in the packaging environment, so local `flutter analyze`, `flutter test`, and `flutter run` were not executed here.

## Required user-side verification

Run:

```bash
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Do not mark UX final until device interaction confirms long-press popup quality, slot tapping, cursor focus, and delete behavior.
