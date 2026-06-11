# MathPro V94 — Premium Calculus Visual Surface Audit

Scope: UI/editor-surface only. No solver/CAS behavior was added.

## Goal
Move high-risk calculus templates away from plain text-chip fallback and into explicit compact MathLabel glyphs so MORE, long-press, and keycap surfaces share the same premium mathematical visual language.

## Added visual surfaces
- `∫(□)dx`
- `∫_{□}^{□}(□)d□`
- `∫₀¹(□)dx`
- `∫₀¹ f(x)`
- `Σ(□)`
- `Π(□)`
- `limₓ→□(□)`
- `limₓ→∞(□)`
- `limₓ→0(□)`
- `limₓ→0⁺(□)`
- `limₓ→0⁻(□)`
- `lim sin(x)/x`

## Product intent
These glyphs are designed to show real structural math cues: upper/lower limits, body slot, differential slot, big-operator limits/body, and limit target/body. They are not solver implementations.

## Frozen contracts preserved
- Keyboard layout was not changed.
- MORE, Ans, ↵, and = semantics were not changed.
- Graph, History, and Solution panel UI were not changed.
- Root/integral long-press option lists were not reordered.

## Test added
- `test/v94_premium_calculus_visual_surface_test.dart`

The assistant container still lacks Flutter/Dart runtime, so Flutter analyze/test/run must be executed on the user's machine.
