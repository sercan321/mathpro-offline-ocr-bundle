# V172-Q129 — Main App Real Device Runtime Court Guard

Q129 is a guard-only batch continuation phase. It requires a real-device main-app runtime court after any flag-gated activation before downstream runtime bindings can proceed.

It does not switch MathLive into the main/default editor, does not delete legacy cursor files, does not retire the legacy main path, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution files, and does not claim cursor/device/release PASS.

Expected package-side status: `Q129_MAIN_APP_REAL_DEVICE_RUNTIME_COURT_PACKAGE_READY_BUT_ACTIVATION_EVIDENCE_BLOCKED`.

Required before real progression:

- Q128 flag-gated activation evidence
- Flutter analyze PASS evidence
- Flutter test PASS evidence
- MathLive Lab real-device evidence
- Main app real-device evidence
- explicit human approval for Q129
