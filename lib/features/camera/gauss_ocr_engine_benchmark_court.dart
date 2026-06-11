import 'gauss_ocr_engine_benchmark_court_policy.dart';

/// Candidate family identifier for the future camera math OCR benchmark court.
///
/// These are registry entries only. Q240 does not ship their runtimes, model
/// files, native libraries, Python packages, or download URLs.
enum GaussOcrBenchmarkEngineFamily {
  ppFormulaNetS,
  ppFormulaNetPlusS,
  pix2TextMfrOnnx,
  uniMerNetTiny,
  texTeller,
  ppFormulaNetPlusL,
}

/// Benchmark categories that must be represented before choosing a production
/// math OCR engine.
enum GaussOcrBenchmarkCaseKind {
  simpleArithmetic,
  linearEquation,
  powersAndSubscripts,
  squareRoot,
  fraction,
  trigonometry,
  indefiniteIntegral,
  definiteIntegral,
  derivativePrimeNotation,
  derivativeLeibnizNotation,
  limit,
  sigma,
  matrix,
  printedComplexExpression,
  simpleHandwriting,
  lowLightCapture,
  skewedCapture,
  blurredCapture,
}

class GaussOcrBenchmarkEngineDescriptor {
  const GaussOcrBenchmarkEngineDescriptor({
    required this.family,
    required this.label,
    required this.role,
    required this.expectedOutput,
    required this.mobileBindingRisk,
    required this.baseAppRuntimeBundled,
    required this.productionReadyInQ240,
    required this.directSolveAllowed,
  });

  final GaussOcrBenchmarkEngineFamily family;
  final String label;
  final String role;
  final String expectedOutput;
  final String mobileBindingRisk;
  final bool baseAppRuntimeBundled;
  final bool productionReadyInQ240;
  final bool directSolveAllowed;

  bool get requiresMathLiveReview => true;
}

class GaussOcrBenchmarkCaseDescriptor {
  const GaussOcrBenchmarkCaseDescriptor({
    required this.kind,
    required this.label,
    required this.expectedLatexFocus,
  });

  final GaussOcrBenchmarkCaseKind kind;
  final String label;
  final String expectedLatexFocus;
}

/// V172-Q240 benchmark registry for future lab evaluation.
///
/// This contract intentionally stays runtime-free. It lets tests/verifiers lock
/// the engine comparison surface without adding Paddle, ONNX, Pix2Text,
/// TexTeller, Text OCR fallback, network workers, or model bytes to the calculator app.
class GaussOcrEngineBenchmarkCourt {
  const GaussOcrEngineBenchmarkCourt._();

  static const String phase = GaussOcrEngineBenchmarkCourtPolicy.fullPhase;
  static const bool appRuntimeIsolationRequired = true;
  static const bool winnerSelectionRequiredBeforeRuntimeBinding = true;
  static const bool mathLiveReviewRequiredAfterRecognition = true;
  static const bool directSolveAllowed = false;

  static const List<GaussOcrBenchmarkEngineDescriptor> candidateEngines = <GaussOcrBenchmarkEngineDescriptor>[
    GaussOcrBenchmarkEngineDescriptor(
      family: GaussOcrBenchmarkEngineFamily.ppFormulaNetS,
      label: 'PP-FormulaNet-S',
      role: 'primary math OCR candidate for formula image to LaTeX benchmark',
      expectedOutput: 'LaTeX candidate list',
      mobileBindingRisk: 'medium-high: runtime/model delivery must be proven outside production first',
      baseAppRuntimeBundled: false,
      productionReadyInQ240: false,
      directSolveAllowed: false,
    ),
    GaussOcrBenchmarkEngineDescriptor(
      family: GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusS,
      label: 'PP-FormulaNet_plus-S',
      role: 'quality comparison candidate against the smaller PP-FormulaNet-S track',
      expectedOutput: 'LaTeX candidate list',
      mobileBindingRisk: 'high: larger model/runtime cost must be justified by benchmark evidence',
      baseAppRuntimeBundled: false,
      productionReadyInQ240: false,
      directSolveAllowed: false,
    ),
    GaussOcrBenchmarkEngineDescriptor(
      family: GaussOcrBenchmarkEngineFamily.pix2TextMfrOnnx,
      label: 'Pix2Text MFR ONNX',
      role: 'mobile-binding comparison candidate for image-to-LaTeX via ONNX-style packaging',
      expectedOutput: 'LaTeX candidate list',
      mobileBindingRisk: 'medium: ONNX mobile binding still requires real device proof',
      baseAppRuntimeBundled: false,
      productionReadyInQ240: false,
      directSolveAllowed: false,
    ),
    GaussOcrBenchmarkEngineDescriptor(
      family: GaussOcrBenchmarkEngineFamily.uniMerNetTiny,
      label: 'UniMERNet tiny',
      role: 'quality reference candidate for real-world mathematical expression recognition',
      expectedOutput: 'LaTeX candidate list',
      mobileBindingRisk: 'high: size/performance likely unsuitable without strong evidence',
      baseAppRuntimeBundled: false,
      productionReadyInQ240: false,
      directSolveAllowed: false,
    ),
    GaussOcrBenchmarkEngineDescriptor(
      family: GaussOcrBenchmarkEngineFamily.texTeller,
      label: 'TexTeller',
      role: 'research comparison candidate for end-to-end formula image to LaTeX recognition',
      expectedOutput: 'LaTeX candidate list',
      mobileBindingRisk: 'high: model scale and mobile runtime must be proven before binding',
      baseAppRuntimeBundled: false,
      productionReadyInQ240: false,
      directSolveAllowed: false,
    ),
    GaussOcrBenchmarkEngineDescriptor(
      family: GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusL,
      label: 'PP-FormulaNet_plus-L',
      role: 'premium structural formula recognizer for complex layout image-to-LaTeX',
      expectedOutput: 'LaTeX candidate list',
      mobileBindingRisk: 'high: larger model/runtime path must be proven before product binding',
      baseAppRuntimeBundled: false,
      productionReadyInQ240: false,
      directSolveAllowed: false,
    ),
  ];

  static const List<GaussOcrBenchmarkCaseDescriptor> requiredCases = <GaussOcrBenchmarkCaseDescriptor>[
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.simpleArithmetic, label: 'simple arithmetic', expectedLatexFocus: r'2+2'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.linearEquation, label: 'linear equation', expectedLatexFocus: r'3x+5=11'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.powersAndSubscripts, label: 'powers and subscripts', expectedLatexFocus: r'x^2, a_n'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.squareRoot, label: 'square root', expectedLatexFocus: r'\sqrt{x+1}'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.fraction, label: 'fraction', expectedLatexFocus: r'\frac{x+1}{x-1}'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.trigonometry, label: 'trigonometry', expectedLatexFocus: r'\sin(x)+\cos(x)'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.indefiniteIntegral, label: 'indefinite integral', expectedLatexFocus: r'\int x^2\,dx'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.definiteIntegral, label: 'definite integral', expectedLatexFocus: r'\int_0^1 x^2\,dx'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.derivativePrimeNotation, label: 'prime derivative', expectedLatexFocus: r"y''+3y'+2y=0"),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.derivativeLeibnizNotation, label: 'Leibniz derivative', expectedLatexFocus: r'\frac{d}{dx}\sin(x)'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.limit, label: 'limit', expectedLatexFocus: r'\lim_{x\to 0}\frac{\sin x}{x}'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.sigma, label: 'sigma', expectedLatexFocus: r'\sum_{n=1}^{10}n^2'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.matrix, label: 'matrix', expectedLatexFocus: r'\begin{bmatrix}1&2\\3&4\end{bmatrix}'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.printedComplexExpression, label: 'printed complex expression', expectedLatexFocus: r'\frac{\int_0^1 x^2\,dx}{\sqrt{x+1}}'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.simpleHandwriting, label: 'simple handwriting', expectedLatexFocus: r'x^2+1'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.lowLightCapture, label: 'low-light capture', expectedLatexFocus: 'robustness case'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.skewedCapture, label: 'skewed capture', expectedLatexFocus: 'robustness case'),
    GaussOcrBenchmarkCaseDescriptor(kind: GaussOcrBenchmarkCaseKind.blurredCapture, label: 'blurred capture', expectedLatexFocus: 'robustness case'),
  ];

  static const List<String> scoringDimensions = <String>[
    'latexExactness',
    'integralLimitPlacement',
    'derivativeNotationFidelity',
    'fractionNumeratorDenominatorStructure',
    'radicalScopeStructure',
    'powerAndSubscriptStructure',
    'candidateConfidenceAvailability',
    'processingTimeMs',
    'modelSizeBytes',
    'peakMemoryMb',
    'offlineAfterInstallViability',
    'androidRuntimeBindingRisk',
    'licenseAndDistributionRisk',
  ];

  static bool get hasEnoughCaseCoverage => requiredCases.length >= 18;
  static bool get hasPrimaryAndFallbackCandidates => candidateEngines.length >= 6;
}
