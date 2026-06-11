# V172-Q127 — Cursor Court Closure Or Repair Decision Gate

Q127 is a guard-only batch continuation phase. It forces a clean decision between Q116 cursor-court closure and Q115R repair before any activation work continues.

It does not switch MathLive into the main/default editor, does not delete legacy cursor files, does not retire the legacy main path, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution files, and does not claim cursor/device/release PASS.

Expected package-side status: `Q127_CURSOR_COURT_CLOSURE_OR_REPAIR_DECISION_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED`.

Required before real progression:

- Q126 reconciled local evidence intake
- Flutter analyze PASS evidence
- Flutter test PASS evidence
- MathLive Lab real-device evidence
- Main app real-device evidence
- explicit human approval for Q127
