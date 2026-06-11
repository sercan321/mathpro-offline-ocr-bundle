# V172-Q75 Native Structural Edit Transaction Binding Audit Report

## Scope

Q75 is cursor/editor-only. It does not change keyboard layout, key order, MORE, Ans, ↵, =, long-press popup, app shell, MathLabel, TemplateTray, Graph, History, or Solution.

## Incoming package finding

The incoming archive was still tagged as V172-Q73 / `0.172.104+172`. It did not contain Q74 package identity. Q75 therefore includes the Q74 exclusive `|□` caret renderer policy and tests before advancing the active package to V172-Q75.

## Runtime change

Before Q75, a correct tap could select a structural slot, but the first text edit could still move the editing context to a detached linear caret in single-slot payloads such as `sin(□)`. Q75 adds `NativeStructuralEditTransactionBindingPolicy` and wires the controller so eligible structural edits keep the active SlotBox role and caret index after insert/delete/replace operations.

Examples covered by static/widget tests:

- `sin(□)` + `3` keeps `functionArgument` active and produces `sin(3)` with structural caret index `1`.
- Next `0` produces `sin(30)` while still keeping the same structural role active.
- Filled fraction denominator edit `12⁄345`, denominator caret index `1`, insert `9` produces `12⁄3945` and keeps `fractionDenominator` active.

## Safety constraints

- No protected UI/keyboard files changed.
- No real-device +95 claim is made.
- No Flutter analyze/test/run PASS is claimed from the assistant environment because Flutter/Dart are unavailable.
- The Q75 policy explicitly sets:
  - `structuralEditMayExitToDetachedLinearCaret = false`
  - `functionArgumentAutoExitAfterFirstDigitAllowed = false`
  - `realDevicePlus95PassClaimed = false`

## Verification performed here

- Fresh extraction of incoming ZIP.
- Protected file byte comparison against incoming ZIP.
- Static verifier: `python3 tool/verify_mathpro_contract.py .` completed without hard failures.
- ZIP integrity checked after packaging.

## Verification not performed here

The assistant environment has no Flutter or Dart executables. The following remain user-side required evidence:

```powershell
flutter pub get
flutter analyze
flutter test
flutter run -d 23106RN0DA
```

Real-device cursor court must still verify function/log/root/fraction/integral/nested/long-expression scenarios before any Photomath/Wolfram +95 cursor claim.
