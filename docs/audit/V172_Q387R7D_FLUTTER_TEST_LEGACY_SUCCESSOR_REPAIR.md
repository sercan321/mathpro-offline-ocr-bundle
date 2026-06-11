# V172 Q387R7D — Flutter Test Legacy Successor Repair

Q387R7D repairs stale Q348-Q352 Flutter tests after Q387 introduced a guarded Paddle Lite `.nb` `setModelFromFile` path. The production guard still requires `.nb` file detection, Q387R1 manifest/SHA/provenance readiness, and `supportsSetModelFromFile` before any model load attempt.

It also scopes legacy ONNX pubspec tests to runtime dependency lines rather than historical comments. ONNX Runtime is not reintroduced, no model binary is bundled, no OCR/device/build PASS is claimed, and Q382 keyboard ordering plus Graph/History/Solution/MORE/long-press surfaces remain untouched.
