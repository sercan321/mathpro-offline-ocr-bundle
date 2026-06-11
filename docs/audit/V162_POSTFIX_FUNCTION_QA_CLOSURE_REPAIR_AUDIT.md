# V162 Postfix Function and QA Closure Repair Audit

## Scope
Repairs real-log regressions after V161 without changing frozen keyboard topology or protected Graph/History/Solution/editor surfaces.

## Repairs
- Matrix postfix labels A⁻¹/Aᵀ/B⁻¹/Bᵀ preserve postfixTarget roles.
- g(□)/h(□) no longer collapse through the f(□) contract alias.
- V154 real-device QA metadata checks remain forward-compatible while preserving closure wording.
- Widget tests target MathLabel-backed key/MORE/long-press surfaces by stable keys or MathLabel predicates.

## No fake PASS
Flutter/Dart were not available in the package environment. Real PASS requires local flutter analyze/test/run evidence.
