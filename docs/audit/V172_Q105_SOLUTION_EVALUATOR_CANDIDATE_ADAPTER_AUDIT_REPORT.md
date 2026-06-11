# V172-Q105 Solution/Evaluator Candidate Adapter Audit Report

## Scope

Q105 adds MathLive normalized expression to Solution/Evaluator candidate envelope binding. It converts Q102 normalized MathLive snapshots, Q103 GraphEligibility metadata, and Q104 History reference data into deterministic package-side Solution/Evaluator candidate envelopes.

## What Q105 adds

- `MathLiveSolutionEvaluatorCandidateAdapterPolicy`
- `tool/verify_mathlive_solution_evaluator_candidate_adapter.mjs`
- deterministic candidate samples for numeric, fraction, algebraic, implicit, and unsupported MathLive expressions
- metadata and contract gates preventing fake solution output

## Guarded behavior

Q105 deliberately keeps the phase package-side only:

- no `solution_steps_panel.dart` mutation
- no Solution UI mutation
- no Graph/History UI mutation
- no keyboard/MORE/long-press/AppShell mutation
- no main-editor switch or mount
- no MathLive default activation
- no runtime Solution write
- no fake solution steps
- no fake runtime or smoke evidence
- no cursor/device PASS claim
- no legacy cursor deletion

## Evidence status

Q105 package-side deterministic samples may pass without real MathLive runtime, but runtime binding remains blocked until Q101 Lab smoke evidence closure is genuinely complete.

## Expected verifier command

```powershell
node tool/verify_mathlive_solution_evaluator_candidate_adapter.mjs
```

Expected package-side status while runtime evidence is absent:

```text
MATHLIVE_SOLUTION_EVALUATOR_ADAPTER_PACKAGE_READY_BUT_RUNTIME_EVIDENCE_BLOCKED
```
