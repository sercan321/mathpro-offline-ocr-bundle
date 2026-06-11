class GaussOcrReviewApprovedImportContractQ360Policy {
  const GaussOcrReviewApprovedImportContractQ360Policy._();

  static const String phase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
  static const String sourcePhase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
  static const String status = 'OCR_REVIEW_APPROVED_IMPORT_CONTRACT_DEFAULT_OFF_NO_DIRECT_IMPORT_NO_SOLVE';
  static const String selectedDependencyCoordinate = 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0';
  static const String expectedOnnxArtifactFileName = 'pp_formulanet_s.onnx';
  static const String expectedPrivateStorageRelativePath = 'ocr_models/PP-FormulaNet-S/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactPathPolicy = '../MathProOcrArtifacts/PP-FormulaNet-S-ONNX-Exact/pp_formulanet_s.onnx';
  static const String expectedOnnxArtifactSha256 = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
  static const int expectedOnnxArtifactSizeBytes = 308743097;

  static const List<String> reviewContractRules = <String>[
    'A candidate produced by any future OCR runtime must be routed to editable MathLive review before any workspace import is prepared.',
    'Editable review is a user-visible correction step; candidateLatex may not directly become workspace expression content.',
    'Review must preserve the original candidate envelope and require explicit user approval before import.',
    'No package-side static phase may claim OCR review PASS without real Flutter/Android evidence.',
  ];

  static const List<String> approvedImportRules = <String>[
    'Workspace import is only allowed after explicit user approval from the editable MathLive review contract.',
    'Approved import prepares expression content only; it must not auto-trigger Solve, Graph, Solution, or History writes.',
    'Reject empty candidateLatex, unreviewed candidateLatex, and any candidate without explicit approval.',
    'Keep direct OCR-to-workspace, OCR-to-solve, OCR-to-graph, OCR-to-solution, and OCR-to-history blocked.',
  ];

  static const List<String> redLineRules = <String>[
    'Do not touch keyboard, MORE/template tray, long-press, MathLive production editor, workspace UI, Graph, Solution, History, splash, icon, or solver/evaluator surfaces.',
    'Do not add a new ONNX Runtime dependency, do not bundle the 308 MB ONNX model, and do not start model-load or OCR automatically.',
    'Do not claim Android, ONNX Runtime, model-load, dummy call, image-to-LaTeX, OCR review, workspace import, or OCR PASS from static checks.',
  ];
}
