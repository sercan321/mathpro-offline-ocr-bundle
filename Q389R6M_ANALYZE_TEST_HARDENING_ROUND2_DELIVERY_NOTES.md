# Q389R6M — Analyze/Test Hardening Round 2

This package responds to the user-side Q389R6L logs.

## User-side issues targeted

- `flutter analyze` still reported two `unnecessary_brace_in_string_interps` infos in `graph_interaction_overlay.dart`.
- `q389r6b_graph_critical_points_interaction_contract_test.dart` missed the quadratic minimum for `x^2 - 4` because the extrema flat tolerance was too high for fine sampling.
- `graph_history_regression_test.dart` tapped the visible `Apply` text center, which became unreliable after the settings sheet grew; the test now targets the keyed Apply button.
- `graph_history_v14_static_contract_test.dart` found fake PASS wording in a stale audit markdown note; exact fake PASS wording was removed.
- `v172_q208_graph_2d_3d_elite_toggle_architecture_test.dart` still required the old oversized MathLive font clamp; it now accepts the Q389R6G compact scale.
- `v172_q387r7d_paddle_lite_nb_flutter_test_legacy_successor_repair_test.dart` expected historical ONNX audit wording; a harmless comment was restored without adding an ONNX Runtime dependency.

## Protected surfaces not changed

- Keyboard layout / key ordering
- Dart keyboard dispatch
- MathLive production command queue behavior
- OCR runtime implementation
- Android native files
- Solver/CAS
- Graph runtime UI behavior except the critical-point detector tolerance used by the existing Q389R6B marker contract

## Evidence boundary

Node/static verifiers can be run in this environment. Flutter analyze/test/build/run still require the user's Flutter-capable Windows environment.
