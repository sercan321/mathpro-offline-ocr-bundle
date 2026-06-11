# MathPro V115 — Real Log Test Repair Audit

## Scope
V115 is a targeted real-log repair based on the user's V114 execution result. The user-side log showed:

- `flutter pub get`: completed
- `flutter analyze`: `No issues found!`
- `flutter test`: 6 failing tests

This phase does not add a solver and does not redesign the keyboard, graph, history, or solution panel. It only repairs the remaining test-contract drift found in the real V114 log.

## Repairs

1. Protected derivative templates from primary-family power canonicalization so `d²/dx²(□)` stays a derivative expression instead of becoming a power/subscript-like expression.
2. Restored structural `sqrtValue` registry coverage for filled square roots such as `√x` / `√(x)`.
3. Preserved sparse n-preview matrix/vector topology so preview ellipsis rows/cells do not become fake hidden editable cells.
4. Prioritized linked-series placeholder propagation before generic filled-slot replacement in `CalculatorController` so Taylor/Binom linked placeholders propagate as intended.
5. Reconciled the V104 regression test with the older core contract: fixed filled compact integrals remain structural but non-addressable, while genuinely open explicit integral slots remain editable.

## Explicit Non-Claims

- No local Flutter/Dart execution was performed in this environment.
- This package is not claimed as PASS until the user reruns `flutter analyze`, `flutter test`, and `flutter run -d 23106RN0DA`.
- No Photomath/WolframAlpha equivalence claim is made.

## Required User Commands

```bash
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```
