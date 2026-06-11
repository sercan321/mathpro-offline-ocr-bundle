# V172-Q33 Failure Map and +95 Cursor Path

## User-observed failures carried into Q33

| Failure | Technical interpretation | Next phase |
|---|---|---|
| Caret overlaps placeholder box in √□ / empty slots | slot rect and caret rect are too tightly coupled; placeholder-safe caret edge is not enforced enough | Q35 |
| Caret does not shrink in superscript/subscript/log base | role-aware caret sizing must be sourced from active slot role at draw time | Q36 |
| Tap inside scripts/log/root may choose unrelated place | role rect and priority/hit containment must be tightened | Q37-Q39 |
| Cursor not Photomath/Wolfram-level | engine uses calibrated/approximate geometry, not full renderer-slot/glyph identity | Q34/Q40/Q44 |
| P6 UI must not regress | visual keyboard/MORE/layout files must remain byte-identical to P6 | all phases |

## Realistic +95 definition

The target is +95 on the core expression set: numbers, function arguments, fractions, scripts, log/root, nested functions, and primary structural insert/delete. It is not honest to claim universal +95 for all possible math notation without real renderer-slot/glyph identity and device QA.
