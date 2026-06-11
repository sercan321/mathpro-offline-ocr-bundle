# V172-Q131 — Full App Regression Court Guard

Q131 is a guard-only batch continuation phase. It requires full-app regression evidence across keyboard/editor/cursor/Graph/History/Solution/MathLive before release-candidate review.

It does not switch MathLive into the main/default editor, does not delete legacy cursor files, does not retire the legacy main path, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution files, and does not claim cursor/device/release PASS.

Expected package-side status: `Q131_FULL_APP_REGRESSION_COURT_PACKAGE_READY_BUT_RUNTIME_BINDING_EVIDENCE_BLOCKED`.

Required before real progression:

- Q130 Graph/History/Solution runtime binding evidence
- Flutter analyze PASS evidence
- Flutter test PASS evidence
- MathLive Lab real-device evidence
- Main app real-device evidence
- explicit human approval for Q131
