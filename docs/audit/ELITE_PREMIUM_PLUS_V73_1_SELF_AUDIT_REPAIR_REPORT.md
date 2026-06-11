# MathPro V73.1 — Self-Audit Repair Report

## Purpose
V73 was rechecked after the final audit package. The static review found that two user-reported requirements were not fully closed at implementation level:

1. The `y^(n)` derivative-order request was only visually improved; the editable numeric-order-to-prime conversion was not implemented.
2. The duplicate generic `log(□)` entry was removed from the `log` long-press list, but it still appeared in the MORE / Fonksiyon surface.

## V73.1 Repair Scope
- Replace the y long-press nth derivative option with a fillable slot label: `y⁽□⁾`.
- Add a structural template path for `y⁽□⁾`.
- Add derivative-order slot expansion: `y⁽□⁾` + `4` becomes `y''''`.
- Add a structural parser role for the derivative-order placeholder so slot focus/hit-test can target it as `derivativeOrder`.
- Preserve legacy `y⁽ⁿ⁾` compatibility in serializers/renderers, but remove it from the visible y long-press options.
- Remove duplicate `log(□)` from MORE / Fonksiyon labels while keeping `log₁₀(□)`, `log₂(□)`, and `log_□(□)`.

## Explicit Non-Goals
- No solver / CAS.
- No solution panel changes.
- No keyboard layout or tab order redesign.
- No MORE key behavior change.
- No graph/history change.
