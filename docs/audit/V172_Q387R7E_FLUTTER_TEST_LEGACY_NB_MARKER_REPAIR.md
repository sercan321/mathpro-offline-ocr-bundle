# V172 Q387R7E — Flutter Test Legacy .NB Marker Repair

## Scope

Repairs stale Q348-Q350 Flutter tests after the user-side log showed the next failure was caused by legacy tests forbidding every `.nb` source-code marker. Q387+ legitimately mentions `.nb` in guarded Paddle Lite artifact-format code, but base APK/AAB model bundling remains forbidden.

## Guardrails

- No OCR PASS claim.
- No Android real-device PASS claim.
- No model binary is bundled in the project ZIP.
- No ONNX Runtime is reintroduced.
- Q382 keyboard ordering is not touched.
- Graph/History/Solution/Solver surfaces are not touched.

## Verification

Run:

```bash
node tool/verify_paddle_lite_nb_flutter_test_legacy_nb_marker_repair_v172_q387r7e.mjs
```
