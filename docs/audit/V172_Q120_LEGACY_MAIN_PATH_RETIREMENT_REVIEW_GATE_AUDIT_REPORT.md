# V172-Q120 Legacy Main Path Retirement Review Gate Audit

Q120 is a review gate only; it does not retire the legacy main path, does not switch or mount MathLive as the main/default editor, does not delete legacy cursor files, does not mutate protected keyboard/MORE/long-press/AppShell/Graph/History/Solution surfaces, and does not create fake runtime/device/approval evidence.

## Purpose

Q119 created a Graph / History / Solution runtime binding gate but runtime binding evidence remains blocked until user-side real-device and human-review evidence exists. Q120 therefore blocks legacy main-path retirement review until Q119 runtime binding evidence, Q119 human review approval, explicit Q120 retirement-review approval, Flutter analyze/test evidence, Lab/main device evidence, Graph/History/Solution runtime evidence, post-activation soak evidence, protected-surface invariants, and rollback availability are all real.

## Package-side safety result

The package may be considered ready only as a guard. It must remain `Q120_LEGACY_MAIN_PATH_RETIREMENT_REVIEW_PACKAGE_READY_BUT_EVIDENCE_BLOCKED` until real user-side evidence is supplied. `mayRetireLegacyMainPathNow`, `mayDeleteLegacyCursor`, `maySwitchDefaultEditorNow`, and `mayProceedToPhysicalCleanupPlanning` remain false in the package-side report.

## Protected surfaces

Protected files intentionally untouched. Keyboard layout, MORE, long-press, Ans, ↵, =, AppShell, Graph, History, and Solution protected surfaces remain outside Q120 scope.
