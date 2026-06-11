# V172-Q90 Legacy Cursor Retirement Phase 1 Guard Audit Report

## Scope

Q90 is a guarded retirement-policy phase only. It does not delete the legacy Flutter SlotBox cursor engine, does not mount MathLive in the main workspace, and does not switch the active editor by default.

## Implemented

- Added `LegacyCursorRetirementPolicy`.
- Added Q90 tests that prove legacy remains active when Q87/Q88/Q89 proof is absent.
- Added a future-only Phase 1 bypass verdict for the proven MathLive path.
- Added Q90 markers to the local MathLive lab manifest and bridge state.
- Updated package contract, README, and static verifier.

## Explicitly Not Implemented

- No physical deletion of legacy cursor files.
- No removal of `LegacyFlutterSlotEditor` rollback.
- No main-editor MathLive mount.
- No MathLive runtime bundling claim.
- No virtual keyboard enablement.
- No remote/CDN script usage.
- No Photomath/Wolfram/+95 cursor claim.

## Protected UI Surface Status

The following families remain locked and were not intentionally changed:

- Keyboard layout and key order
- MORE tray
- Long-press popup
- App shell
- MathLabel
- Template tray
- Solution panel
- Graph card
- History controller/panel

## Acceptance

Q90 is accepted only if Flutter analyze/test pass user-side and the static verifier reports no hard failures. Real-device MathLive cursor success remains unclaimed until the Q87 court is backed by real runtime evidence.
