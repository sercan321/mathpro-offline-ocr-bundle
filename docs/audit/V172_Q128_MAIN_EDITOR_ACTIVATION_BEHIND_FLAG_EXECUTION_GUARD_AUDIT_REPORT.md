# V172-Q128 — Main Editor Activation Behind Flag Execution Guard

Q128 is a guard-only batch continuation phase. It keeps MathLive main-editor activation behind an explicit internal flag and blocks activation while Q127 cursor evidence is absent or failed.

It does not switch MathLive into the main/default editor, does not delete legacy cursor files, does not retire the legacy main path, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution files, and does not claim cursor/device/release PASS.

Expected package-side status: `Q128_MAIN_EDITOR_ACTIVATION_BEHIND_FLAG_PACKAGE_READY_BUT_CURSOR_EVIDENCE_BLOCKED`.

Required before real progression:

- Q127 cursor court closure decision
- Flutter analyze PASS evidence
- Flutter test PASS evidence
- MathLive Lab real-device evidence
- Main app real-device evidence
- explicit human approval for Q128
