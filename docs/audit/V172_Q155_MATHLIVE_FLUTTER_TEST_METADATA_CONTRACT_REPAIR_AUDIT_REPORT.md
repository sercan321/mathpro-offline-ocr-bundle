# V172-Q155 MathLive Flutter Test Metadata Contract Repair Audit

## Scope

Q155 is a targeted package/test-contract repair after the user-side Q154 log showed remaining Flutter test failures caused by:

- `MathProPackageContract.staleVersionMarkers` listing the active `version: 0.172.112+172`;
- Q140 static tests requiring the pre-Q145 exact sigma template instead of accepting the later compact `\textstyle\sum` payload.

## Repairs

- Removed the active package version from the stale-version marker set while preserving the legacy pubspec version required by `verify_mathpro_contract.py`.
- Updated the Q140 sigma assertion to validate semantic `\sum_{n=#?}^{#?} #0` and compact `\textstyle`, without accepting raw `Σ` text.
- Added Q155 policy, test, verifier, manifest entry, and audit records.

## Protected surfaces

Q155 does not alter keyboard layout/source, key order, MORE inventory/order, long-press order, Graph UI, History UI, Solution UI, or solver behavior.

## Claims

No Flutter analyze/test/run PASS, real-device PASS, cursor PASS, or Photomath-level PASS is claimed by this package.
