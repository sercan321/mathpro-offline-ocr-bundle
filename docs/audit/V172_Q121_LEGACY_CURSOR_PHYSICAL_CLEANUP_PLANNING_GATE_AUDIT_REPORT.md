# V172-Q121 — Legacy Cursor Physical Cleanup Planning Gate Audit Report

## Scope

Q121 is a planning gate only; it does not delete legacy cursor files, does not retire the legacy main path, does not switch or mount MathLive as the main/default editor, and does not mutate protected UI surfaces.

## Why this phase exists

Q120 established that legacy main-path retirement review must remain blocked until Q119/Q120 runtime, device, post-activation soak, and human-review evidence are complete. Q121 extends that chain so physical cleanup planning cannot be mistaken for physical deletion.

## Hard blockers before later cleanup execution review

- Q120 retirement-review evidence must be complete.
- Q120 human review must be approved.
- Explicit Q121 cleanup-planning approval must exist.
- Flutter analyze/test PASS evidence must be real.
- MathLive Lab and main-app real-device evidence must be real.
- Graph, History, and Solution runtime evidence must be real.
- Post-activation soak evidence must be real.
- Protected-surface hashes must remain unchanged.
- Legacy rollback and shared editor data-path files must remain present.

## Safety claims

- physicalCleanupImplementedInThisPackage: false
- legacyCursorPhysicalDeletionImplementedInThisPackage: false
- legacyMainPathRetirementImplementedInThisPackage: false
- mathLiveDefaultSwitchImplementedInThisPackage: false
- mainWorkspaceMountImplementedInThisPackage: false
- cursorPassClaimAllowedInThisPackage: false
- releasePassClaimAllowedInThisPackage: false

## Verification

Run:

```bash
node tool/verify_legacy_cursor_physical_cleanup_planning_gate.mjs
```

Expected package-side status without user-side evidence:

```text
Q121_LEGACY_CURSOR_PHYSICAL_CLEANUP_PLANNING_PACKAGE_READY_BUT_EVIDENCE_BLOCKED
```
