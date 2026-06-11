class GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy {
  const GaussOcrRuntimeReadinessAdaptiveInputDecoderCompletionQ380Policy._();

  static const String phase = 'V172-Q380-OCR-RUNTIME-READINESS-ADAPTIVE-INPUT-DECODER-COMPLETION';
  static const String sourcePhase = 'V172-Q379-REAL-ONNX-OUTPUT-DECODER-CANDIDATE-EXTRACTION-BINDING';
  static const String bridgeChannel = 'mathpro/ocr_runtime_bridge';
  static const String bridgeMethod = 'ocrRuntimeReadinessAdaptiveInputDecoderCompletion';
  static const String decoderVersion = 'q380-adaptive-input-metadata-logit-token-vocabulary-decoder-v1';
  static const String expectedModelFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';

  static const List<String> completionGoals = <String>[
    'Preflight the private ONNX model before camera OCR inference.',
    'Optionally activate private storage from an explicit source path only.',
    'Read ONNX input metadata and avoid hard-coded 224x224 when model shape is available.',
    'Support NCHW, NHWC, and CHW float32 image tensor layouts.',
    'Decode readable strings, integer token IDs, and float logits with private vocabulary argmax.',
    'Return an explicit blocked reason instead of inventing fake LaTeX.',
    'Keep editable MathLive review and explicit user approval mandatory before workspace import.',
  ];

  static const List<String> protectedSurfaces = <String>[
    'keyboard',
    'MORE/template tray',
    'long-press',
    'MathLive production route',
    'workspace UI auto-import',
    'Graph',
    'Solution',
    'History',
    'splash/icon',
    'solver/evaluator',
  ];
}
