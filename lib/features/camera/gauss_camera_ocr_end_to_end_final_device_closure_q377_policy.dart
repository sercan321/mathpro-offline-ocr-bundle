class GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy {
  const GaussCameraOcrEndToEndFinalDeviceClosureQ377Policy._();

  static const String phase = 'V172-Q377-CAMERA-OCR-END-TO-END-FINAL-DEVICE-CLOSURE';
  static const String sourcePhase = 'V172-Q376-REAL-EDITABLE-REVIEW-APPROVED-WORKSPACE-IMPORT-BINDING';
  static const String activeProductGatePreservedPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
  static const String status = 'CAMERA_OCR_END_TO_END_FINAL_DEVICE_CLOSURE_EVIDENCE_REQUIRED_NO_STATIC_PASS';
  static const String closureVersion = 'q377-camera-ocr-end-to-end-final-device-closure-v1';
  static const String evidenceChain = 'Q364->Q365->Q366->Q367->Q368->Q369->Q376';

  static const List<String> requiredEvidence = <String>[
    'flutter-analyze-pass',
    'flutter-test-pass',
    'flutter-run-real-device-pass',
    'q364-private-storage-model-ready',
    'q365-onnx-model-load-smoke-pass',
    'q366-dummy-runtime-call-pass',
    'q367-image-to-latex-candidate-pass',
    'q368-editable-mathlive-review-handoff-pass',
    'q369-approved-workspace-import-envelope-pass',
    'q376-review-first-approved-import-binding-pass',
    'no-direct-ocr-to-workspace-solve-graph-solution-history',
  ];

  static const List<String> redLineRules = <String>[
    'OCR candidate must never directly import to workspace without editable MathLive review.',
    'Explicit user approval is mandatory before any workspace import command can be accepted.',
    'Solve, Graph, Solution, and History must not be auto-triggered by OCR.',
    'Keyboard, MORE/template tray, long-press, MathLive production route, workspace UI, Graph, Solution, History, splash/icon, and solver/evaluator surfaces must remain protected.',
    'The 308 MB ONNX model must not be bundled into the project ZIP.',
  ];
}
