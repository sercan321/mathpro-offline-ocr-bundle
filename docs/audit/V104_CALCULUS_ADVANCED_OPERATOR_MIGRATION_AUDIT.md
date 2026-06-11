# MathPro V104 — Calculus / Advanced Operator Migration Audit

## Scope
V104 is a core editor/render migration phase, not a solver phase. It targets the calculus and advanced operator families that must not behave as loose strings after the user fills or edits their slots:

- Limit
- Definite / indefinite integral
- Derivative display hygiene
- Sum / product
- Series template preservation

## What changed

### 1. New calculus operator policy
Added `lib/features/formula_engine/calculus_operator_policy.dart`.

This policy centralizes display canonicalization for advanced operator families:

- `lim_y → 8(8)` → `lim₍y→8₎(8)`
- `lim x→∞` → `lim₍x→∞₎(□)`
- `∫₀¹(x)dx` → `∫_{0}^{1}(x)dx`
- `∫ₐᵇ(x)dt` → `∫_{a}^{b}(x)dt`
- `Σᵢ₌₁ⁿ(x)` → `Σ_{i=1}^{n}(x)`
- `Πᵢ₌₁ⁿ(x)` → `Π_{i=1}^{n}(x)`

### 2. Renderer bridge connected to calculus canonicalization
Updated `MathExpressionRenderBridge` so canonical display expression now runs:

1. Primary math family policy
2. Calculus operator policy
3. Legacy limit fallback normalization

This prevents calculus forms from drifting back into programmer-like visual strings before parsing, TeX rendering, or slot registry generation.

### 3. NodeFactory parsing strengthened
Updated `NodeFactory` to parse compact limit forms such as:

- `lim₍y→8₎(8)`
- `lim₍x→∞₎(□)`

as real `MathNodeKind.limit` with variable / target / body slots.

Also added parsing support for compact sum/product forms:

- `Σᵢ₌₁ⁿ(x)`
- `Πᵢ₌₁ⁿ(x)`
- `Σn₌0∞(x)` / `Πn₌0∞(x)` style forms

These are promoted into `MathNodeKind.bigOperator` with lower / upper / body slots.

### 4. Direct TeX fallback strengthened
Updated `MathTexSerializer` to convert:

- `lim₍x→0₎(body)`
- `∫_{0}^{1}(body)dx`
- `Σ_{lower}^{upper}(body)` / `Π_{lower}^{upper}(body)`

without exposing raw programmer display forms.

### 5. Regression lock added
Added `test/v104_calculus_advanced_operator_migration_test.dart`.

The test locks:

- calculus policy version
- canonical limit / integral / sum / product forms
- compact limit slot roles
- definite integral slot roles
- compact Σ/Π slot roles
- direct TeX fallback for compact calculus forms

## Preserved contracts

V104 does not intentionally modify:

- keyboard key positions
- tab order
- MORE label
- Ans
- ↵ behavior
- = equality behavior
- Graph UI
- History UI
- Solution panel UI
- long-press option order/content

## Not claimed
No Flutter `analyze`, `test`, or `run` PASS is claimed unless executed in a real Flutter environment.

