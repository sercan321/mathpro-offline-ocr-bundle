# V172-O Regression / Contract Hardening Audit Report

## Scope

V172-O is a contract-hardening phase, not a new cursor behavior phase. It adds a source-level regression policy and strengthens the Flutter-free static verifier so MathPro's V172 A-N cursor work cannot silently disappear in later phases.

## Baseline Verified Before Work

- Current package was inspected as V172-N premium cursor visual polish.
- V172-A through V172-N audit/runtime markers were present.
- `paintVisibleSlotOverlay: true` was not present in production `lib/` code.
- No editor loupe or editor long-press cursor menu path was added.
- Keyboard, MORE, Ans, `=`, `↵`, long-press, Graph, History, and Solution protected files were not edited.

## Runtime Changes

Added:

- `lib/features/formula_engine/regression_contract_hardening_policy.dart`

Updated:

- `tool/verify_mathpro_contract.py`
- `test/core_editor_regression_test.dart`
- `README.md`
- `pubspec.yaml`

## Contract Locked

The new policy records:

- no editor loupe
- no editor long-press menu
- no Pay/Payda/Üs textual cursor labels
- no green debug overlay
- no legacy slot-box production allowance
- no static Flutter PASS claim
- no real-device cursor PASS claim
- required V172 A-O cursor phase identifiers
- required runtime cursor-policy files
- required audit report files
- protected keyboard/Graph/History/Solution files

## Honest Limitations

This phase does not run Flutter in the assistant environment and does not claim real-device PASS. It also does not clean legacy raw-math alias warnings; those are deferred to a later renderer/raw-math cleanup phase.
