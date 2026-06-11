# V172-Q198 — Legacy Marker / Policy / Verifier Cleanup

Q198 removes historical lab/diagnostic/court policy dependencies from the active production MathLive source path without changing protected keyboard, MORE, long-press, Graph, History, or Solution files.

## Static closure

- Active production source no longer imports `mathlive_lab_screen_policy.dart`.
- Active production source no longer imports historical diagnostic/court policy classes.
- Runtime controller queue helpers use production names instead of Q169 private identifiers.
- `MathLiveProductionPlatformViewPolicy` owns production WebView availability.
- `MathLiveProductionCommandTracePolicy` replaces active-source command-court terminology.
- The compatibility `MathLiveMainEditorSurface` forwards directly to `MathLiveProductionEditorSurface` and cannot render a fallback overlay.
- Official MathLive font bundle from Q196 remains present.
- Q182-Q198 verifier chain was updated for the separated Q197 production surface and Q198 successor phase.

## Protected files

See `docs/audit/V172_Q198_PROTECTED_FILE_HASH_MANIFEST.md`.

## Verifier status

Fresh extract status must run:

```text
node tool/verify_mathlive_legacy_marker_policy_verifier_cleanup_v172_q198.mjs
python3 tool/verify_mathpro_contract.py
```

No Flutter analyze/test/run PASS and no Android real-device PASS are claimed by this package.
