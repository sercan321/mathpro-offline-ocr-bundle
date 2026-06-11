# V172-Q116 Post-Q115 Cursor Court Rerun Audit Report

## Scope

Q116 is the stale-evidence shield after Q115. It does not repair UI again, does not switch the main editor, does not retire or delete the legacy cursor stack, and does not claim cursor PASS. It adds an explicit post-Q115 rerun gate so the same Q108 real-device cursor court cannot be closed with pre-Q115 captures.

## Why this phase exists

Q115 added a package-side structural caret anchor geometry guard. The remaining acceptance question is real-device evidence: after Q115, the user must rerun the 12 Q108 scenarios on the phone and prove that the caret no longer appears on top of structural boxes or detached from visible slots.

## Required evidence

- Q115 structural caret anchor geometry repair report is package-ready.
- Q108 real-device cursor court execution report is package-ready.
- Q101 Lab smoke evidence closure is real on the user machine.
- Official MathLive runtime bundle is verified on the user machine.
- Flutter analyze and Flutter test evidence are present.
- MathLive Lab and main app are both run on the real device after Q115.
- `tool/reports/mathlive_post_q115_cursor_court_rerun_capture.json` explicitly names `V172-Q115` as the repair under test.
- All 12 Q108 scenarios pass with `blockingFailureCount: 0`.
- `structuralCaretMisalignmentAbsent` is true.

## Non-goals

- No Q108/Q87 cursor PASS claim is made by the package.
- No MathLive default/main editor switch is implemented.
- No legacy cursor retirement or physical deletion is performed.
- No Graph, History, Solution, AppShell, keyboard, MORE, or long-press surface is mutated.
