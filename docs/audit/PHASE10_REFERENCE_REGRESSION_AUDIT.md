# MathPro Flutter Phase 10 — Reference Regression Audit

## Reference package

- `MathPro_History_V2_FULL_KATEX_INLINE_FIX.zip`

## Flutter package

- `MathPro_Flutter_Phase10_FULL.zip`

## Keyboard decision preservation

PASS — The frozen keyboard files are byte-identical to Phase 9 and continue to preserve the reference decisions:

- 5 tabs
- Temel 20-key core
- expanded 8 × 5 grid
- MORE
- Ans
- ↵ as evaluate/enter
- = as literal equality symbol
- long-press map
- keyboard height policy

## Selection semantics hardening

Phase 9 still allowed toolbar actions to treat the whole expression as the current selection. Phase 10 prevents that unsafe behavior:

- `Temizle` clears only the active selection highlight.
- Copy/cut/duplicate are disabled/no-op for empty slot highlights.
- Paste can target the active open slot.

This is a safer pre-final behavior until real node-range selection is implemented.

## Template system hardening

Phase 10 centralizes reference premium templates through `TemplateSpec` and preserves labels:

- Kuadratik
- `(x+y)^2`
- `∫₀¹ f(x)`
- `lim sin(x)/x`
- `2x2 Matris`
- Dot Product
- Euler
- Σ Seri
- Norm

The system now supports preferred focus roles after template insertion. This is not yet a full RN-style node payload/focusBoxId clone, but it is materially safer than a label-only tray.

## Active slot consistency

Phase 9 could visually auto-activate a primary slot without calculator state explicitly selecting it. Phase 10 removes that fallback. Active slot visuals now depend on explicit calculator state.

## Remaining honest limitation

Renderer-derived bounding boxes are not implemented. Slot hit-testing still uses deterministic approximate boxes as a fallback. Runtime device validation is still required.
