# V172-Q382R32R1 — R25–R32 Verifier Artifact Completeness Repair

This is a test/docs artifact repair only. It does not change runtime production behavior.

## Reason

The Q382R25–Q382R32 verifier chain must be self-contained: every phase in the sequence must have a matching test file and `docs/audit` record. The missing artifacts made local verification brittle even when runtime source markers were present.

## Added / completed

- Added `test/v172_q382r25_all_key_latency_court_test.dart`.
- Added `docs/audit/V172_Q382R26_CHANGED_FILES.md`.
- Added this Q382R32R1 audit note.
- Added `tool/verify_r25_r32_artifact_completeness_v172_q382r32r1.mjs`.

## Verifier hardening

- `tool/verify_all_key_latency_court_v172_q382r25.mjs` now requires the Q382R25 test file.
- `tool/verify_caret_context_bridge_v172_q382r26.mjs` now requires Q382R26 audit and changed-files documents.
- `tool/verify_safe_optimistic_linear_echo_v172_q382r27.mjs` now requires Q382R27 audit and changed-files documents.

## Protected areas

No runtime source behavior was changed. The following remain untouched by this repair:

- Keyboard layout/order/labels
- Long-press lists
- MORE/template tray inventory/order
- MathLive JS runtime behavior
- Optimistic echo scope
- OCR/camera
- Graph
- Solution semantics
- History
- AndroidManifest / Gradle / MainActivity
- Splash/icon
- Pan/drag-scroll
