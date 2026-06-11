import 'gauss_ocr_engine_benchmark_court.dart';
import 'gauss_ocr_engine_real_benchmark_package_policy.dart';

class GaussOcrRealBenchmarkEngineProbe {
  const GaussOcrRealBenchmarkEngineProbe({
    required this.family,
    required this.label,
    required this.primaryRole,
    required this.requiredLabBinding,
    required this.requiredEvidence,
    required this.rejectionTriggers,
    required this.baseAppRuntimeBundled,
    required this.productionBindingAllowedInQ246,
    required this.canWinWithoutRealImages,
  });

  final GaussOcrBenchmarkEngineFamily family;
  final String label;
  final String primaryRole;
  final String requiredLabBinding;
  final List<String> requiredEvidence;
  final List<String> rejectionTriggers;
  final bool baseAppRuntimeBundled;
  final bool productionBindingAllowedInQ246;
  final bool canWinWithoutRealImages;

  bool get requiresMathLiveEditableReview => true;
}

class GaussOcrRealBenchmarkImageCase {
  const GaussOcrRealBenchmarkImageCase({
    required this.id,
    required this.kind,
    required this.expectedLatex,
    required this.captureCondition,
    required this.structuralFocus,
  });

  final String id;
  final GaussOcrBenchmarkCaseKind kind;
  final String expectedLatex;
  final String captureCondition;
  final String structuralFocus;
}

class GaussOcrRealBenchmarkMetric {
  const GaussOcrRealBenchmarkMetric({
    required this.key,
    required this.label,
    required this.minimumEvidenceRequired,
    required this.hardGate,
  });

  final String key;
  final String label;
  final String minimumEvidenceRequired;
  final bool hardGate;
}

class GaussOcrEngineRealBenchmarkPackage {
  const GaussOcrEngineRealBenchmarkPackage._();

  static const phase = GaussOcrEngineRealBenchmarkPackagePolicy.phase;
  static const closesOverPhase = GaussOcrEngineRealBenchmarkPackagePolicy.closesOverPhase;
  static const packageIsBenchmarkProtocolOnly = true;
  static const appRuntimeIsolationRequired = true;
  static const benchmarkWinnerSelected = false;
  static const productionInferenceAllowed = false;
  static const directSolveFromCameraAllowed = false;
  static const mathLiveEditableReviewRequiredBeforeImport = true;

  static const candidateProbes = <GaussOcrRealBenchmarkEngineProbe>[
    GaussOcrRealBenchmarkEngineProbe(
      family: GaussOcrBenchmarkEngineFamily.ppFormulaNetS,
      label: 'PP-FormulaNet-S',
      primaryRole: 'compact primary mathematical expression recognition candidate',
      requiredLabBinding: 'external or desktop lab runner before any Android runtime binding',
      requiredEvidence: <String>[
        'image-to-LaTeX exactness report',
        'integral and fraction structural report',
        'Android model size estimate',
        'license/distribution note',
      ],
      rejectionTriggers: <String>[
        'cannot preserve fraction numerator denominator structure',
        'cannot report offline packaging path',
        'requires cloud-only inference',
      ],
      baseAppRuntimeBundled: false,
      productionBindingAllowedInQ246: false,
      canWinWithoutRealImages: false,
    ),
    GaussOcrRealBenchmarkEngineProbe(
      family: GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusS,
      label: 'PP-FormulaNet_plus-S',
      primaryRole: 'quality challenger for complex formula cases',
      requiredLabBinding: 'external or desktop lab runner with size and latency report',
      requiredEvidence: <String>[
        'complex expression exactness report',
        'model size and RAM report',
        'mobile deployment risk report',
      ],
      rejectionTriggers: <String>[
        'model too large for deferred mobile download',
        'latency unacceptable on Android test device',
        'cannot run offline after install',
      ],
      baseAppRuntimeBundled: false,
      productionBindingAllowedInQ246: false,
      canWinWithoutRealImages: false,
    ),
    GaussOcrRealBenchmarkEngineProbe(
      family: GaussOcrBenchmarkEngineFamily.pix2TextMfrOnnx,
      label: 'Pix2Text MFR ONNX',
      primaryRole: 'ONNX-style mobile binding candidate for formula image to LaTeX',
      requiredLabBinding: 'external ONNX/prototype runner before app integration',
      requiredEvidence: <String>[
        'ONNX runtime feasibility report',
        'LaTeX candidate quality report',
        'Android package size report',
      ],
      rejectionTriggers: <String>[
        'ONNX runtime cannot be packaged safely',
        'native dependency breaks Flutter Android build',
        'outputs plain text instead of structural LaTeX',
      ],
      baseAppRuntimeBundled: false,
      productionBindingAllowedInQ246: false,
      canWinWithoutRealImages: false,
    ),
    GaussOcrRealBenchmarkEngineProbe(
      family: GaussOcrBenchmarkEngineFamily.uniMerNetTiny,
      label: 'UniMERNet tiny',
      primaryRole: 'research-quality comparison candidate for hard math layout cases',
      requiredLabBinding: 'external lab comparison only until mobile cost is proven',
      requiredEvidence: <String>[
        'hard expression quality report',
        'memory pressure report',
        'license/distribution note',
      ],
      rejectionTriggers: <String>[
        'mobile memory budget exceeded',
        'inference requires unsupported runtime',
        'no practical deferred download path',
      ],
      baseAppRuntimeBundled: false,
      productionBindingAllowedInQ246: false,
      canWinWithoutRealImages: false,
    ),
    GaussOcrRealBenchmarkEngineProbe(
      family: GaussOcrBenchmarkEngineFamily.texTeller,
      label: 'TexTeller',
      primaryRole: 'research comparison candidate for end-to-end formula recognition',
      requiredLabBinding: 'external lab only, no production runtime in Q246',
      requiredEvidence: <String>[
        'formula recognition accuracy report',
        'model and runtime footprint report',
        'offline viability report',
      ],
      rejectionTriggers: <String>[
        'requires server inference',
        'model footprint unsuitable for mobile',
        'cannot produce editable LaTeX candidate',
      ],
      baseAppRuntimeBundled: false,
      productionBindingAllowedInQ246: false,
      canWinWithoutRealImages: false,
    ),
    GaussOcrRealBenchmarkEngineProbe(
      family: GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusL,
      label: 'PP-FormulaNet_plus-L',
      primaryRole: 'simple text fallback candidate only, not primary math OCR',
      requiredLabBinding: 'fallback text-only comparison gate',
      requiredEvidence: <String>[
        'plain text fallback report',
        'failure report for integral fraction radical cases',
        'review-only parser handoff note',
      ],
      rejectionTriggers: <String>[
        'claimed as primary formula recognizer',
        'bypasses MathLive editable review',
        'direct solve attempted from text fallback',
      ],
      baseAppRuntimeBundled: false,
      productionBindingAllowedInQ246: false,
      canWinWithoutRealImages: false,
    ),
  ];

  static const requiredImageCases = <GaussOcrRealBenchmarkImageCase>[
    GaussOcrRealBenchmarkImageCase(id: 'Q246-ARITH-001', kind: GaussOcrBenchmarkCaseKind.simpleArithmetic, expectedLatex: r'2+3', captureCondition: 'printed clean', structuralFocus: 'baseline token order'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-LINEAR-001', kind: GaussOcrBenchmarkCaseKind.linearEquation, expectedLatex: r'3x+5=11', captureCondition: 'printed clean', structuralFocus: 'equals relation'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-POWER-001', kind: GaussOcrBenchmarkCaseKind.powersAndSubscripts, expectedLatex: r'x^2+a_n', captureCondition: 'printed clean', structuralFocus: 'superscript and subscript separation'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-FRAC-001', kind: GaussOcrBenchmarkCaseKind.fraction, expectedLatex: r'\frac{x+1}{x-1}', captureCondition: 'printed clean', structuralFocus: 'numerator denominator ownership'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-RAD-001', kind: GaussOcrBenchmarkCaseKind.squareRoot, expectedLatex: r'\sqrt{x+1}', captureCondition: 'printed clean', structuralFocus: 'radical scope'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-INT-001', kind: GaussOcrBenchmarkCaseKind.indefiniteIntegral, expectedLatex: r'\int x^2\,dx', captureCondition: 'printed clean', structuralFocus: 'integral body and differential'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-INT-002', kind: GaussOcrBenchmarkCaseKind.definiteIntegral, expectedLatex: r'\int_0^1 x^2\,dx', captureCondition: 'printed clean', structuralFocus: 'upper and lower limit placement'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-DER-001', kind: GaussOcrBenchmarkCaseKind.derivativePrimeNotation, expectedLatex: r"y''+3y'+2y=0", captureCondition: 'printed clean', structuralFocus: 'prime notation count'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-DER-002', kind: GaussOcrBenchmarkCaseKind.derivativeLeibnizNotation, expectedLatex: r'\frac{d}{dx}\sin x', captureCondition: 'printed clean', structuralFocus: 'Leibniz fraction operator'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-LIM-001', kind: GaussOcrBenchmarkCaseKind.limit, expectedLatex: r'\lim_{x\to0}\frac{\sin x}{x}', captureCondition: 'printed clean', structuralFocus: 'limit target and fraction'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-SIG-001', kind: GaussOcrBenchmarkCaseKind.sigma, expectedLatex: r'\sum_{n=1}^{10}n^2', captureCondition: 'printed clean', structuralFocus: 'sigma bound placement'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-MAT-001', kind: GaussOcrBenchmarkCaseKind.matrix, expectedLatex: r'\begin{bmatrix}1&2\\3&4\end{bmatrix}', captureCondition: 'printed clean', structuralFocus: 'matrix rows and columns'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-COMP-001', kind: GaussOcrBenchmarkCaseKind.printedComplexExpression, expectedLatex: r'\frac{\int_0^1 x^2\,dx}{\sqrt{x+1}}', captureCondition: 'printed clean', structuralFocus: 'nested integral fraction radical'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-HAND-001', kind: GaussOcrBenchmarkCaseKind.simpleHandwriting, expectedLatex: r'x^2+1', captureCondition: 'simple handwriting', structuralFocus: 'handwritten power expression'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-LOW-001', kind: GaussOcrBenchmarkCaseKind.lowLightCapture, expectedLatex: r'\frac{1}{2}', captureCondition: 'low light', structuralFocus: 'fraction under poor lighting'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-SKEW-001', kind: GaussOcrBenchmarkCaseKind.skewedCapture, expectedLatex: r'\sqrt{x}', captureCondition: 'skewed camera angle', structuralFocus: 'radical under perspective skew'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-BLUR-001', kind: GaussOcrBenchmarkCaseKind.blurredCapture, expectedLatex: r'\int_0^1 x\,dx', captureCondition: 'mild blur', structuralFocus: 'integral bounds under blur'),
    GaussOcrRealBenchmarkImageCase(id: 'Q246-TRIG-001', kind: GaussOcrBenchmarkCaseKind.trigonometry, expectedLatex: r'\sin x+\cos x', captureCondition: 'printed clean', structuralFocus: 'function token recognition'),
  ];

  static const metrics = <GaussOcrRealBenchmarkMetric>[
    GaussOcrRealBenchmarkMetric(key: 'latexExactness', label: 'LaTeX exactness', minimumEvidenceRequired: 'case-level expected vs actual LaTeX diff', hardGate: true),
    GaussOcrRealBenchmarkMetric(key: 'structurePreservation', label: 'Structure preservation', minimumEvidenceRequired: 'fraction/radical/integral ownership report', hardGate: true),
    GaussOcrRealBenchmarkMetric(key: 'candidateAlternatives', label: 'Alternative candidates', minimumEvidenceRequired: 'ranked alternatives and confidence report', hardGate: false),
    GaussOcrRealBenchmarkMetric(key: 'latencyMs', label: 'Latency in milliseconds', minimumEvidenceRequired: 'median and p95 timing report', hardGate: true),
    GaussOcrRealBenchmarkMetric(key: 'modelSizeBytes', label: 'Model size bytes', minimumEvidenceRequired: 'download size and unpacked size report', hardGate: true),
    GaussOcrRealBenchmarkMetric(key: 'peakMemoryMb', label: 'Peak memory megabytes', minimumEvidenceRequired: 'Android memory pressure report', hardGate: true),
    GaussOcrRealBenchmarkMetric(key: 'offlineAfterInstall', label: 'Offline after install', minimumEvidenceRequired: 'network-off recognition proof after verified model install', hardGate: true),
    GaussOcrRealBenchmarkMetric(key: 'licenseDistribution', label: 'License and distribution', minimumEvidenceRequired: 'redistribution note before selection', hardGate: true),
    GaussOcrRealBenchmarkMetric(key: 'mathLiveReviewCompatibility', label: 'MathLive review compatibility', minimumEvidenceRequired: 'editable LaTeX candidate can be reviewed before import', hardGate: true),
  ];

  static const rejectionRules = <String>[
    'reject any engine that requires cloud-only recognition for production camera OCR',
    'reject any engine that cannot output editable LaTeX candidate text',
    'reject any engine that bypasses MathLive editable review',
    'reject any engine that requires bundling heavy model bytes in the base APK',
    'reject any engine that writes directly to solve, Graph, Solution, or History',
    'reject any engine whose license cannot be distributed with the chosen product path',
  ];

  static bool get hasAllCandidateFamilies => candidateProbes.length == 6;
  static bool get hasEnoughRealImageCases => requiredImageCases.length >= 18;
  static bool get hasHardGatesForMobileSelection => metrics.where((metric) => metric.hardGate).length >= 6;
  static bool get canSelectWinnerInQ246 => false;
}
