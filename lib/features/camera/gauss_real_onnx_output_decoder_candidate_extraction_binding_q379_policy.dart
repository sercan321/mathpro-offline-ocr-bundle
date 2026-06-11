class GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy {
  const GaussRealOnnxOutputDecoderCandidateExtractionBindingQ379Policy._();

  static const String phase = 'V172-Q379-REAL-ONNX-OUTPUT-DECODER-CANDIDATE-EXTRACTION-BINDING';
  static const String sourcePhase = 'V172-Q378-REAL-CAMERA-OCR-USER-FLOW-BINDING';
  static const String bridgeChannel = 'mathpro/ocr_runtime_bridge';
  static const String bridgeMethod = 'realOnnxOutputDecoderCandidateExtractionBinding';
  static const String decoderVersion = 'q379-generic-onnx-output-string-ascii-token-vocabulary-decoder-v1';
  static const String expectedModelFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';

  static const List<String> acceptedOutputFamilies = <String>[
    'readable-string-output',
    'ascii-or-unicode-codepoint-output',
    'token-id-output-with-private-vocabulary',
  ];

  static const List<String> decoderVocabularyFileCandidates = <String>[
    'pp_formulanet_s_vocab.txt',
    'pp_formulanet_s_tokens.txt',
    'vocab.txt',
    'tokens.txt',
    'latex_vocab.txt',
  ];

  static const List<String> invariants = <String>[
    'Do not invent LaTeX when ONNX output is unreadable.',
    'Decoded candidate must pass editable MathLive review before workspace import.',
    'Explicit user approval is required before workspace import.',
    'Solve, Graph, Solution, and History are never auto-triggered by OCR.',
    'ONNX model bytes are not bundled in the application ZIP.',
  ];
}
