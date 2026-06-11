import 'gauss_ocr_benchmark_dataset_lab_runner_policy.dart';
import 'gauss_ocr_engine_benchmark_court.dart';

/// Difficulty bucket for future camera math OCR benchmark fixtures.
enum GaussOcrBenchmarkDatasetDifficulty {
  smoke,
  core,
  advanced,
  robustness,
}

/// Capture condition bucket for future benchmark images.
enum GaussOcrBenchmarkCaptureCondition {
  cleanPrinted,
  mixedPrinted,
  handwriting,
  lowLight,
  skewed,
  blurred,
}

/// Structural math feature that must survive image-to-LaTeX recognition.
enum GaussOcrExpectedStructure {
  arithmetic,
  linearEquation,
  power,
  subscript,
  fraction,
  radical,
  trigonometry,
  indefiniteIntegral,
  definiteIntegral,
  derivativePrime,
  derivativeLeibniz,
  limit,
  sigma,
  matrix,
  handwriting,
  captureRobustness,
}

class GaussOcrBenchmarkSampleCase {
  const GaussOcrBenchmarkSampleCase({
    required this.id,
    required this.label,
    required this.kind,
    required this.referenceLatex,
    required this.difficulty,
    required this.captureCondition,
    required this.expectedStructures,
    required this.futureFixtureName,
  });

  final String id;
  final String label;
  final GaussOcrBenchmarkCaseKind kind;
  final String referenceLatex;
  final GaussOcrBenchmarkDatasetDifficulty difficulty;
  final GaussOcrBenchmarkCaptureCondition captureCondition;
  final List<GaussOcrExpectedStructure> expectedStructures;

  /// File name reserved for a future lab fixture. Q240R1 intentionally does
  /// not bundle image assets, model files, or OCR outputs in the base app.
  final String futureFixtureName;

  bool get requiresEditableMathLiveReview => true;
  bool get directSolveAllowed => false;
}

class GaussOcrBenchmarkDryRunTask {
  const GaussOcrBenchmarkDryRunTask({
    required this.engineLabel,
    required this.caseId,
    required this.referenceLatex,
    required this.requiredStructures,
  });

  final String engineLabel;
  final String caseId;
  final String referenceLatex;
  final List<GaussOcrExpectedStructure> requiredStructures;
}

class GaussOcrBenchmarkDryRunPlan {
  const GaussOcrBenchmarkDryRunPlan({
    required this.phase,
    required this.engineCount,
    required this.caseCount,
    required this.taskCount,
    required this.canInvokeRealEngines,
    required this.canWriteProductionResults,
    required this.tasks,
  });

  final String phase;
  final int engineCount;
  final int caseCount;
  final int taskCount;
  final bool canInvokeRealEngines;
  final bool canWriteProductionResults;
  final List<GaussOcrBenchmarkDryRunTask> tasks;
}

/// V172-Q240R1 canonical benchmark dataset and dry-run lab planner.
///
/// This is deliberately metadata-only. It exists so a future OCR engine can be
/// selected by evidence rather than by guesswork, while keeping the production
/// calculator route untouched.
class GaussOcrBenchmarkDatasetLabRunner {
  const GaussOcrBenchmarkDatasetLabRunner._();

  static const String phase = GaussOcrBenchmarkDatasetLabRunnerPolicy.fullPhase;
  static const bool realImagesBundled = false;
  static const bool realEngineInvocationAllowed = false;
  static const bool productionResultWriteAllowed = false;
  static const bool mathLiveReviewRequired = true;
  static const int minimumCaseCount = 30;

  static const List<GaussOcrBenchmarkSampleCase> canonicalCases = <GaussOcrBenchmarkSampleCase>[
    GaussOcrBenchmarkSampleCase(
      id: 'arith_001_clean_printed',
      label: 'simple arithmetic clean print',
      kind: GaussOcrBenchmarkCaseKind.simpleArithmetic,
      referenceLatex: r'2+2=4',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.smoke,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.arithmetic],
      futureFixtureName: 'arith_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'linear_001_clean_printed',
      label: 'linear equation clean print',
      kind: GaussOcrBenchmarkCaseKind.linearEquation,
      referenceLatex: r'3x+5=11',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.smoke,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.linearEquation],
      futureFixtureName: 'linear_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'power_001_clean_printed',
      label: 'power expression clean print',
      kind: GaussOcrBenchmarkCaseKind.powersAndSubscripts,
      referenceLatex: r'x^2+2x+1',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.power],
      futureFixtureName: 'power_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'subscript_001_clean_printed',
      label: 'subscript expression clean print',
      kind: GaussOcrBenchmarkCaseKind.powersAndSubscripts,
      referenceLatex: r'a_n+b_{n+1}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.subscript],
      futureFixtureName: 'subscript_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'fraction_001_clean_printed',
      label: 'single fraction clean print',
      kind: GaussOcrBenchmarkCaseKind.fraction,
      referenceLatex: r'\frac{x+1}{x-1}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.fraction],
      futureFixtureName: 'fraction_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'fraction_002_nested_printed',
      label: 'nested fraction mixed print',
      kind: GaussOcrBenchmarkCaseKind.fraction,
      referenceLatex: r'\frac{1}{1+\frac{x}{2}}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.advanced,
      captureCondition: GaussOcrBenchmarkCaptureCondition.mixedPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.fraction],
      futureFixtureName: 'fraction_002_nested_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'radical_001_clean_printed',
      label: 'square root clean print',
      kind: GaussOcrBenchmarkCaseKind.squareRoot,
      referenceLatex: r'\sqrt{x+1}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.radical],
      futureFixtureName: 'radical_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'radical_002_nested_printed',
      label: 'nested radical mixed print',
      kind: GaussOcrBenchmarkCaseKind.squareRoot,
      referenceLatex: r'\sqrt{x+\sqrt{x}}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.advanced,
      captureCondition: GaussOcrBenchmarkCaptureCondition.mixedPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.radical],
      futureFixtureName: 'radical_002_nested_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'trig_001_clean_printed',
      label: 'trigonometry clean print',
      kind: GaussOcrBenchmarkCaseKind.trigonometry,
      referenceLatex: r'\sin(x)+\cos(x)',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.trigonometry],
      futureFixtureName: 'trig_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'trig_002_identity_printed',
      label: 'trigonometric identity clean print',
      kind: GaussOcrBenchmarkCaseKind.trigonometry,
      referenceLatex: r'\sin^2(x)+\cos^2(x)=1',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.trigonometry, GaussOcrExpectedStructure.power],
      futureFixtureName: 'trig_002_identity_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'integral_indef_001_clean_printed',
      label: 'indefinite integral clean print',
      kind: GaussOcrBenchmarkCaseKind.indefiniteIntegral,
      referenceLatex: r'\int x^2\,dx',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.indefiniteIntegral, GaussOcrExpectedStructure.power],
      futureFixtureName: 'integral_indef_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'integral_def_001_clean_printed',
      label: 'definite integral clean print',
      kind: GaussOcrBenchmarkCaseKind.definiteIntegral,
      referenceLatex: r'\int_0^1 x^2\,dx',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.definiteIntegral, GaussOcrExpectedStructure.power],
      futureFixtureName: 'integral_def_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'integral_def_002_fraction_printed',
      label: 'definite integral with fraction',
      kind: GaussOcrBenchmarkCaseKind.definiteIntegral,
      referenceLatex: r'\int_0^\pi \frac{\sin x}{x+1}\,dx',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.advanced,
      captureCondition: GaussOcrBenchmarkCaptureCondition.mixedPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.definiteIntegral, GaussOcrExpectedStructure.fraction],
      futureFixtureName: 'integral_def_002_fraction_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'derivative_prime_001_clean_printed',
      label: 'prime derivative ODE clean print',
      kind: GaussOcrBenchmarkCaseKind.derivativePrimeNotation,
      referenceLatex: r"y''+3y'+2y=0",
      difficulty: GaussOcrBenchmarkDatasetDifficulty.advanced,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.derivativePrime],
      futureFixtureName: 'derivative_prime_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'derivative_prime_002_handwriting',
      label: 'prime derivative handwriting smoke',
      kind: GaussOcrBenchmarkCaseKind.derivativePrimeNotation,
      referenceLatex: r"y'+y=0",
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.handwriting,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.derivativePrime, GaussOcrExpectedStructure.handwriting],
      futureFixtureName: 'derivative_prime_002_handwriting.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'derivative_leibniz_001_clean_printed',
      label: 'Leibniz derivative clean print',
      kind: GaussOcrBenchmarkCaseKind.derivativeLeibnizNotation,
      referenceLatex: r'\frac{d}{dx}\sin(x)',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.advanced,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.derivativeLeibniz, GaussOcrExpectedStructure.trigonometry],
      futureFixtureName: 'derivative_leibniz_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'derivative_leibniz_002_fraction_printed',
      label: 'Leibniz derivative with fraction',
      kind: GaussOcrBenchmarkCaseKind.derivativeLeibnizNotation,
      referenceLatex: r'\frac{d}{dx}\frac{x}{x^2+1}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.advanced,
      captureCondition: GaussOcrBenchmarkCaptureCondition.mixedPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.derivativeLeibniz, GaussOcrExpectedStructure.fraction],
      futureFixtureName: 'derivative_leibniz_002_fraction_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'limit_001_clean_printed',
      label: 'limit clean print',
      kind: GaussOcrBenchmarkCaseKind.limit,
      referenceLatex: r'\lim_{x\to 0}\frac{\sin x}{x}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.limit, GaussOcrExpectedStructure.fraction],
      futureFixtureName: 'limit_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'sigma_001_clean_printed',
      label: 'sigma clean print',
      kind: GaussOcrBenchmarkCaseKind.sigma,
      referenceLatex: r'\sum_{n=1}^{10}n^2',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.core,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.sigma, GaussOcrExpectedStructure.power],
      futureFixtureName: 'sigma_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'matrix_001_clean_printed',
      label: 'matrix clean print',
      kind: GaussOcrBenchmarkCaseKind.matrix,
      referenceLatex: r'\begin{bmatrix}1&2\\3&4\end{bmatrix}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.advanced,
      captureCondition: GaussOcrBenchmarkCaptureCondition.cleanPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.matrix],
      futureFixtureName: 'matrix_001_clean_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'complex_001_mixed_printed',
      label: 'printed complex expression with integral and radical',
      kind: GaussOcrBenchmarkCaseKind.printedComplexExpression,
      referenceLatex: r'\frac{\int_0^1 x^2\,dx}{\sqrt{x+1}}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.advanced,
      captureCondition: GaussOcrBenchmarkCaptureCondition.mixedPrinted,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.fraction, GaussOcrExpectedStructure.definiteIntegral, GaussOcrExpectedStructure.radical],
      futureFixtureName: 'complex_001_mixed_printed.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'handwriting_001_simple',
      label: 'simple handwriting polynomial',
      kind: GaussOcrBenchmarkCaseKind.simpleHandwriting,
      referenceLatex: r'x^2+1',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.handwriting,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.handwriting, GaussOcrExpectedStructure.power],
      futureFixtureName: 'handwriting_001_simple.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'handwriting_002_fraction',
      label: 'handwriting fraction smoke',
      kind: GaussOcrBenchmarkCaseKind.fraction,
      referenceLatex: r'\frac{x+1}{2}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.handwriting,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.handwriting, GaussOcrExpectedStructure.fraction],
      futureFixtureName: 'handwriting_002_fraction.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'handwriting_003_integral',
      label: 'handwriting integral smoke',
      kind: GaussOcrBenchmarkCaseKind.indefiniteIntegral,
      referenceLatex: r'\int x\,dx',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.handwriting,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.handwriting, GaussOcrExpectedStructure.indefiniteIntegral],
      futureFixtureName: 'handwriting_003_integral.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'lowlight_001_fraction',
      label: 'low-light fraction robustness',
      kind: GaussOcrBenchmarkCaseKind.lowLightCapture,
      referenceLatex: r'\frac{x^2+1}{x+1}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.lowLight,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.captureRobustness, GaussOcrExpectedStructure.fraction],
      futureFixtureName: 'lowlight_001_fraction.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'lowlight_002_derivative',
      label: 'low-light derivative robustness',
      kind: GaussOcrBenchmarkCaseKind.lowLightCapture,
      referenceLatex: r'\frac{dy}{dx}=2x',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.lowLight,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.captureRobustness, GaussOcrExpectedStructure.derivativeLeibniz],
      futureFixtureName: 'lowlight_002_derivative.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'skew_001_integral',
      label: 'skewed definite integral robustness',
      kind: GaussOcrBenchmarkCaseKind.skewedCapture,
      referenceLatex: r'\int_0^1 \frac{x}{x+1}\,dx',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.skewed,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.captureRobustness, GaussOcrExpectedStructure.definiteIntegral],
      futureFixtureName: 'skew_001_integral.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'skew_002_matrix',
      label: 'skewed matrix robustness',
      kind: GaussOcrBenchmarkCaseKind.skewedCapture,
      referenceLatex: r'\begin{bmatrix}a&b\\c&d\end{bmatrix}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.skewed,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.captureRobustness, GaussOcrExpectedStructure.matrix],
      futureFixtureName: 'skew_002_matrix.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'blur_001_radical',
      label: 'blurred radical robustness',
      kind: GaussOcrBenchmarkCaseKind.blurredCapture,
      referenceLatex: r'\sqrt{x^2+1}',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.blurred,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.captureRobustness, GaussOcrExpectedStructure.radical],
      futureFixtureName: 'blur_001_radical.png',
    ),
    GaussOcrBenchmarkSampleCase(
      id: 'blur_002_sigma',
      label: 'blurred sigma robustness',
      kind: GaussOcrBenchmarkCaseKind.blurredCapture,
      referenceLatex: r'\sum_{k=0}^{n}k',
      difficulty: GaussOcrBenchmarkDatasetDifficulty.robustness,
      captureCondition: GaussOcrBenchmarkCaptureCondition.blurred,
      expectedStructures: <GaussOcrExpectedStructure>[GaussOcrExpectedStructure.captureRobustness, GaussOcrExpectedStructure.sigma],
      futureFixtureName: 'blur_002_sigma.png',
    ),
  ];

  static bool get hasMinimumCaseCoverage => canonicalCases.length >= minimumCaseCount;

  static bool get hasUniqueCaseIds =>
      canonicalCases.map((item) => item.id).toSet().length == canonicalCases.length;

  static bool get hasCalculusCoverage => _containsStructure(GaussOcrExpectedStructure.indefiniteIntegral) &&
      _containsStructure(GaussOcrExpectedStructure.definiteIntegral) &&
      _containsStructure(GaussOcrExpectedStructure.derivativePrime) &&
      _containsStructure(GaussOcrExpectedStructure.derivativeLeibniz) &&
      _containsStructure(GaussOcrExpectedStructure.limit);

  static bool get hasStructuralCoverage => _containsStructure(GaussOcrExpectedStructure.fraction) &&
      _containsStructure(GaussOcrExpectedStructure.radical) &&
      _containsStructure(GaussOcrExpectedStructure.power) &&
      _containsStructure(GaussOcrExpectedStructure.subscript) &&
      _containsStructure(GaussOcrExpectedStructure.sigma) &&
      _containsStructure(GaussOcrExpectedStructure.matrix);

  static bool get hasCaptureRobustnessCoverage => _containsCondition(GaussOcrBenchmarkCaptureCondition.lowLight) &&
      _containsCondition(GaussOcrBenchmarkCaptureCondition.skewed) &&
      _containsCondition(GaussOcrBenchmarkCaptureCondition.blurred);

  static bool get hasHandwritingSmokeCoverage => _containsCondition(GaussOcrBenchmarkCaptureCondition.handwriting);

  static GaussOcrBenchmarkDryRunPlan buildDryRunPlan() {
    final tasks = <GaussOcrBenchmarkDryRunTask>[
      for (final engine in GaussOcrEngineBenchmarkCourt.candidateEngines)
        for (final sample in canonicalCases)
          GaussOcrBenchmarkDryRunTask(
            engineLabel: engine.label,
            caseId: sample.id,
            referenceLatex: sample.referenceLatex,
            requiredStructures: sample.expectedStructures,
          ),
    ];
    return GaussOcrBenchmarkDryRunPlan(
      phase: phase,
      engineCount: GaussOcrEngineBenchmarkCourt.candidateEngines.length,
      caseCount: canonicalCases.length,
      taskCount: tasks.length,
      canInvokeRealEngines: realEngineInvocationAllowed,
      canWriteProductionResults: productionResultWriteAllowed,
      tasks: tasks,
    );
  }

  static bool _containsStructure(GaussOcrExpectedStructure structure) =>
      canonicalCases.any((item) => item.expectedStructures.contains(structure));

  static bool _containsCondition(GaussOcrBenchmarkCaptureCondition condition) =>
      canonicalCases.any((item) => item.captureCondition == condition);
}
