# V172 Q387R7B — Flutter Test Stale Regression Repair

## Scope

Q387R7B is a narrow repair for user-provided Flutter analyzer/test evidence. The analyzer log had only one info-level `prefer_const_constructors` issue left, and Flutter test output showed stale successor markers for Q380 and Q385R4.

## Repairs

- Q387R4 placeholder production-source binding test now uses a const input constructor because the placeholder fixture is const.
- MainActivity preserves `modelBindingEvidence` and restores `privateStorageActivationEvidence` as a compatibility alias for older Q380 tests.
- Deferred model manager queued product copy now contains the exact `Model doğrulanmadan OCR çalıştırılmayacak` substring expected by Q239D/Q385R4 successor tests.
- Q387 manifest/evidence gate remains intact; `.nb` evidence is still required before any real inference phase.

## Non-claims

- No Flutter analyze PASS is claimed by the package.
- No Flutter test PASS is claimed by the package.
- No Android build/run/device PASS is claimed.
- No OCR/model/inference/workspace PASS is claimed.
- No model binary is bundled in the base APK/AAB source.
