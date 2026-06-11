# V172-Q189 Single Device Candidate Audit Report

## Scope

Q189 packages the Q184-Q188 minimal production MathLive path as a single-device candidate.
It is not a new feature phase and it does not claim final release quality.

The candidate path remains:

```text
MathLiveProductionEditorSurface
-> assets/mathlive/main_editor_prod.html
-> assets/mathlive/mathlive_prod_bridge.js
-> one native MathLive <math-field>
-> Q188 Graph / History / Solution adapter envelope
```

## What changed

- Added `lib/features/mathlive/mathlive_single_device_candidate_policy.dart`.
- Added `test/v172_q189_single_device_candidate_test.dart`.
- Added `tool/verify_mathlive_single_device_candidate_v172_q189.mjs`.
- Added `docs/evidence/V172_Q189_SINGLE_DEVICE_CANDIDATE_CHECKLIST_TEMPLATE.json`.
- Updated `assets/mathlive/manifest.json` with the Q189 single-device candidate envelope.
- Updated `README.md` with Q189 release-candidate notes.

## What did not change

Q189 intentionally does not mutate the active runtime route or UI surfaces. It does not change:

- keyboard layout
- key order
- MORE inventory/order
- long-press order
- BottomDock
- PremiumKey
- TemplateTray
- Graph UI
- GraphController
- History UI
- HistoryController
- SolutionStepsPanel
- production bridge public API
- solver behavior

## Candidate evidence requirements

The package can only be treated as a real device candidate after user-side evidence is captured for:

- `flutter clean`
- `flutter pub get`
- `flutter analyze`
- `flutter test`
- `flutter run -d 23106RN0DA`
- all Q182/Q184/Q185/Q186/Q187/Q188/Q189 Node verifiers
- `python tool/verify_mathpro_contract.py`
- Android manual scenarios listed in `docs/evidence/V172_Q189_SINGLE_DEVICE_CANDIDATE_CHECKLIST_TEMPLATE.json`

## Manual scenarios that must be proven

The evidence checklist requires at least the following families:

- production surface opens visibly;
- MathLive virtual keyboard, badge, menu, debug chrome are hidden;
- tap/caret movement works inside the expression;
- `1+1`, `x^2`, fraction, square root, power, sin, log, sigma, integral insert correctly;
- Taylor/Maclaurin/3 Denklem do not fall through as raw text;
- delete, clear, and enter/evaluate work;
- Graph, History, and Solution/evaluator candidate paths consume MathLive state.

## Claims not made

This package does not claim:

- `flutter analyze` PASS;
- `flutter test` PASS;
- `flutter run` PASS;
- Android real-device PASS;
- final release PASS;
- Photomath/Wolfram-level quality PASS.

Those claims require user-side logs, screenshots/video, and checklist completion.
