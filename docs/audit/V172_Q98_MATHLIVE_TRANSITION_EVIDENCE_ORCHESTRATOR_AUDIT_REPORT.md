# V172-Q98 MathLive Transition Evidence Orchestrator Audit Report

## Verdict

CONDITIONAL PASS — package-side orchestration only.

Q98 adds a single Node-based evidence court orchestrator so the user does not need to validate every phase minute-by-minute. It collects contract verification, MathLive runtime verification, smoke-evidence writer/verifier status, optional Flutter analyze/test, and optional real-device run commands into a single JSON/Markdown ledger.

## Scope

- Adds `tool/run_mathlive_transition_court.mjs`.
- Adds `MathLiveTransitionEvidenceOrchestratorPolicy`.
- Adds `test/v172_q98_mathlive_transition_evidence_orchestrator_test.dart`.
- Updates metadata/contract/README/manifest for V172-Q98.

## Safety rules

- No fake device PASS.
- No MathLive main-editor/default activation.
- No physical legacy cursor deletion.
- No protected keyboard/MORE/long-press/AppShell/Graph/History/Solution mutation.
- Runtime vendor and canonical smoke evidence remain required.
- Flutter/device gates remain external evidence requirements.

## Orchestrator usage

Static evidence court only:

```powershell
node tool/run_mathlive_transition_court.mjs
```

One-shot Flutter evidence court:

```powershell
node tool/run_mathlive_transition_court.mjs --run-flutter
```

One-shot Flutter + real-device court:

```powershell
node tool/run_mathlive_transition_court.mjs --run-flutter --run-device
```

The script writes:

- `tool/reports/mathlive_transition_court_report.json`
- `tool/reports/mathlive_transition_court_report.md`

The script exits non-zero while required runtime/evidence/device gates are missing. That is intentional and prevents silent PASS drift.

## Blockers intentionally preserved

Q98 does not solve these by fabrication:

- Official MathLive vendor files must exist under `assets/mathlive/vendor/mathlive/`.
- Canonical Q90R5 smoke evidence must exist and verify.
- Flutter analyze/test must be run on a real Flutter environment.
- Real-device Lab and main app runs must be supplied before device-level claims.

## Protected surface statement

Protected files intentionally untouched. Q98 is restricted to tool, policy, test, metadata, and audit layers.
