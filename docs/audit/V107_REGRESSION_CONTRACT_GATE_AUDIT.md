# V107 — Regression Contract Gate + Visible Token Hardening Audit

## Scope

V107 does not add a solver and does not alter the sacred keyboard layout.  Its purpose is to prevent repeated real-device regressions by adding a release-facing contract gate around:

- sacred tab order and basic core keyboard labels,
- MORE / long-press / keycap visible-token hygiene,
- preview/render bridge version lock,
- programmer-token leakage prevention.

## What Changed

- Added `lib/logic/mathpro_regression_gate.dart`.
- Connected `UnifiedMathPreviewPolicy` to the regression gate before returning compact labels.
- Connected `MathExpressionRenderBridge` to the regression gate before/after canonical display conversion.
- Updated V106 preview regression expectations to the V107 gated bridge versions.
- Added `test/v107_regression_contract_gate_test.dart`.

## Preserved Contracts

V107 intentionally does not change:

- keyboard key positions,
- tab order,
- `MORE`,
- `Ans`,
- `↵`,
- `=`,
- Graph UI,
- History UI,
- Solution panel UI,
- long-press list ordering/content.

## Why This Matters

Previous real-device cycles repeatedly found that a local repair could make one surface look correct while another surface leaked a raw/programmer form such as `asin`, `log_10`, `x_n`, or `log(2)(5)`.  V107 adds one last-resort guard so compact preview surfaces, fallback labels, and renderer bridge outputs are checked against the same contract.

## Evidence Added

The new V107 test locks:

1. sacred tab and basic-core keyboard inventory,
2. V107 render/preview bridge version values,
3. public labels after preview canonicalization contain no forbidden visible programmer tokens,
4. legacy leaks convert into user-facing math display forms,
5. release gate findings stay empty for currently registered canonical surfaces.

## Not Claimed

No `flutter analyze`, `flutter test`, or `flutter run` pass is claimed from the assistant environment because Flutter/Dart SDK is unavailable here.
