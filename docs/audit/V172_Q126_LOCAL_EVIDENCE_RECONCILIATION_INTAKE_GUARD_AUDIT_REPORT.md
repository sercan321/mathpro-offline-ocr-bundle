# V172-Q126 — Local Evidence Reconciliation Intake Guard

Q126 is a guard-only batch continuation phase. It collects and validates the user-machine evidence set in one place before later runtime activation or release gates may progress.

It does not switch MathLive into the main/default editor, does not delete legacy cursor files, does not retire the legacy main path, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution files, and does not claim cursor/device/release PASS.

Expected package-side status: `Q126_LOCAL_EVIDENCE_RECONCILIATION_INTAKE_PACKAGE_READY_BUT_USER_EVIDENCE_REQUIRED`.

Required before real progression:

- Q125 final package evidence closure intake guard package readiness
- Flutter analyze PASS evidence
- Flutter test PASS evidence
- MathLive Lab real-device evidence
- Main app real-device evidence
- explicit human approval for Q126
