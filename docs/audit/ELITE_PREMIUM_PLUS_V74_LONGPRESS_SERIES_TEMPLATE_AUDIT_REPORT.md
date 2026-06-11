# MathPro V74 — Long-Press / Series / Template Notation Repair Audit

## Baseline
- Baseline package: `MathProFlutterPhase17_ELITE_PREMIUM_PLUS_V73_1_SELF_AUDIT_REPAIR_FULL.zip`
- V74 scope: new user-reported UI/template issues after V73.1.

## Closed issues
1. Long-press chips now use a uniform fitted content rail so math/text labels share the same optical size envelope.
2. Algebra system template now serializes to a true two-line `cases` TeX form instead of a single-line raw string.
3. `f(□)` long-press no longer exposes the unwanted `parçalı` option.
4. Integral/root/derivative long-press sizing is normalized by the common chip content rail.
5. Limit templates serialize as `\lim_{x\to ...}` with target below `lim` in TeX.
6. `Taylor` no longer inserts `Taylor(□)`; it inserts the general Taylor series formula.
7. The visible `seri` long-press option is removed.
8. Common series templates were added to the Σ long-press list: Taylor, Maclaurin, Geometrik, Binom, eˣ, sin, cos, ln, arctan.
9. Series labels can appear on the selection cards, but inserted workspace content is mathematical formula text/TeX, not name-call text.

## Explicit non-goals
- No solver/CAS was added.
- No solution panel layout was changed.
- No tab order or key positions were changed.
- No MORE, Ans, `=`, or `↵` behavior was changed.

## Test status
Flutter/Dart are not installed in this execution environment, so local `flutter analyze`, `flutter test`, and `flutter run` were not executed here.
