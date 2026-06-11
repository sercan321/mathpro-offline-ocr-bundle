# V172 Q387R7C — Flutter Test Q379 Decoder Marker Repair

Q387R7C is a narrow stale-test compatibility repair opened from user-provided Flutter logs. The user log showed `flutter analyze` completed with `No issues found`, while `flutter test` still failed because `v172_q379_real_onnx_output_decoder_candidate_extraction_binding_test.dart` expected the legacy source markers:

- `"candidateLatex" to decodedCandidateLatex`
- `"outputDecodingImplemented" to outputDecoderImplemented`

The runtime decoder semantics are not expanded here. Q379 still does not invent LaTeX, does not claim OCR PASS, and does not bypass review/workspace approval. This phase only restores explicit alias variables so the old source-level test remains compatible with the newer Q386/Q387 Paddle Lite `.nb` gate chain.

No keyboard, MORE, Graph, History, Solution/Solver, AndroidManifest, Gradle ABI, ONNX Runtime, or base APK/AAB model-bundling behavior is changed.
