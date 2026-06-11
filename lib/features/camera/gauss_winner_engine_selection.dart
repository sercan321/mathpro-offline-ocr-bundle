import 'gauss_ocr_engine_benchmark_court.dart';
import 'gauss_winner_engine_selection_policy.dart';

/// Decision produced by the Q247 selection gate.
enum GaussWinnerEngineSelectionDecision {
  blockedNoRealBenchmarkReport,
  blockedInsufficientCoverage,
  blockedUnsafeDirectSolve,
  blockedMissingMathLiveReview,
  blockedLicenseNotCleared,
  blockedOfflineNotProven,
  blockedModelTooLargeForDeferredDownload,
  blockedLatencyBudget,
  blockedPlainTextOcrFallbackPrimaryClaim,
  eligibleForQ248DeferredModelDownloadPlanning,
}

class GaussWinnerEngineSelectionCandidateRule {
  const GaussWinnerEngineSelectionCandidateRule({
    required this.family,
    required this.label,
    required this.mayBePrimaryFormulaRecognizer,
    required this.mayBeFallback,
    required this.selectionRole,
    required this.mustProve,
    required this.rejectionReasons,
  });

  final GaussOcrBenchmarkEngineFamily family;
  final String label;
  final bool mayBePrimaryFormulaRecognizer;
  final bool mayBeFallback;
  final String selectionRole;
  final List<String> mustProve;
  final List<String> rejectionReasons;

  bool get requiresEditableMathLiveReview => true;
  bool get directSolveAllowed => false;
  bool get baseApkModelBundlingAllowed => false;
}

class GaussWinnerEngineSelectionThreshold {
  const GaussWinnerEngineSelectionThreshold({
    required this.key,
    required this.description,
    required this.hardGate,
  });

  final String key;
  final String description;
  final bool hardGate;
}

class GaussWinnerEngineSelectionEvidence {
  const GaussWinnerEngineSelectionEvidence({
    required this.hasRealBenchmarkReport,
    required this.sampleCount,
    required this.mathLiveReviewRequired,
    required this.directSolveAllowed,
    required this.licenseClearedForDistribution,
    required this.offlineAfterInstallProven,
    required this.modelSizeBytes,
    required this.medianLatencyMs,
    required this.claimsPlainTextOcrFallbackAsPrimary,
  });

  final bool hasRealBenchmarkReport;
  final int sampleCount;
  final bool mathLiveReviewRequired;
  final bool directSolveAllowed;
  final bool licenseClearedForDistribution;
  final bool offlineAfterInstallProven;
  final int modelSizeBytes;
  final int medianLatencyMs;
  final bool claimsPlainTextOcrFallbackAsPrimary;
}

class GaussWinnerEngineSelectionGateResult {
  const GaussWinnerEngineSelectionGateResult({
    required this.phase,
    required this.decision,
    required this.issues,
    required this.benchmarkWinnerSelected,
    required this.productionRuntimeBindingAllowed,
    required this.mathLiveReviewRequired,
    required this.directSolveAllowed,
  });

  final String phase;
  final GaussWinnerEngineSelectionDecision decision;
  final List<String> issues;
  final bool benchmarkWinnerSelected;
  final bool productionRuntimeBindingAllowed;
  final bool mathLiveReviewRequired;
  final bool directSolveAllowed;

  bool get isBlocked => decision != GaussWinnerEngineSelectionDecision.eligibleForQ248DeferredModelDownloadPlanning;
  bool get mayProceedToQ248PlanningOnly =>
      decision == GaussWinnerEngineSelectionDecision.eligibleForQ248DeferredModelDownloadPlanning &&
      benchmarkWinnerSelected == false &&
      productionRuntimeBindingAllowed == false &&
      mathLiveReviewRequired &&
      directSolveAllowed == false;
}

/// V172-Q247 winner selection gate.
///
/// Q247 is intentionally a gate, not a hidden winner claim. Real selection can
/// only proceed when Q246/Q240R3-style evidence proves coverage, offline mode,
/// license clearance, latency, model size, and editable MathLive review safety.
class GaussWinnerEngineSelection {
  const GaussWinnerEngineSelection._();

  static const phase = GaussWinnerEngineSelectionPolicy.phase;
  static const closesOverPhase = GaussWinnerEngineSelectionPolicy.closesOverPhase;
  static const benchmarkWinnerSelected = false;
  static const productionRuntimeBindingAllowed = false;
  static const realOcrRuntimeAdded = false;
  static const modelBinaryBundledInBaseApp = false;
  static const mathLiveEditableReviewRequired = true;
  static const directSolveFromCameraAllowed = false;
  static const q248MayStartOnlyAfterEligibleEvidence = true;

  static const maxDeferredDownloadModelSizeBytes = 160 * 1024 * 1024;
  static const maxMedianLatencyMs = 1800;
  static const minimumRealSampleCount = 30;

  static const candidateRules = <GaussWinnerEngineSelectionCandidateRule>[
    GaussWinnerEngineSelectionCandidateRule(
      family: GaussOcrBenchmarkEngineFamily.ppFormulaNetS,
      label: 'PP-FormulaNet-S',
      mayBePrimaryFormulaRecognizer: true,
      mayBeFallback: false,
      selectionRole: 'leading compact math OCR candidate if real-image benchmark evidence passes',
      mustProve: <String>['integral/fraction/radical structure', 'offline after install', 'mobile size and latency budget', 'license clearance'],
      rejectionReasons: <String>['cloud-only inference', 'poor structural LaTeX', 'cannot fit deferred model budget'],
    ),
    GaussWinnerEngineSelectionCandidateRule(
      family: GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusS,
      label: 'PP-FormulaNet_plus-S',
      mayBePrimaryFormulaRecognizer: true,
      mayBeFallback: false,
      selectionRole: 'quality challenger only if size and latency remain acceptable',
      mustProve: <String>['complex formula quality advantage', 'RAM budget', 'deferred download feasibility', 'license clearance'],
      rejectionReasons: <String>['model footprint too large', 'latency too high', 'offline deployment not proven'],
    ),
    GaussWinnerEngineSelectionCandidateRule(
      family: GaussOcrBenchmarkEngineFamily.pix2TextMfrOnnx,
      label: 'Pix2Text MFR ONNX',
      mayBePrimaryFormulaRecognizer: true,
      mayBeFallback: false,
      selectionRole: 'ONNX-style mobile candidate if native runtime can be isolated safely',
      mustProve: <String>['ONNX Android runtime feasibility', 'LaTeX structural quality', 'APK isolation', 'license clearance'],
      rejectionReasons: <String>['native runtime breaks Android build', 'plain text output only', 'base APK model bundling required'],
    ),
    GaussWinnerEngineSelectionCandidateRule(
      family: GaussOcrBenchmarkEngineFamily.uniMerNetTiny,
      label: 'UniMERNet tiny',
      mayBePrimaryFormulaRecognizer: true,
      mayBeFallback: false,
      selectionRole: 'research-quality challenger if mobile cost is proven acceptable',
      mustProve: <String>['hard layout quality', 'memory pressure', 'offline runtime path', 'license clearance'],
      rejectionReasons: <String>['mobile memory budget exceeded', 'unsupported runtime', 'no practical download path'],
    ),
    GaussWinnerEngineSelectionCandidateRule(
      family: GaussOcrBenchmarkEngineFamily.texTeller,
      label: 'TexTeller',
      mayBePrimaryFormulaRecognizer: true,
      mayBeFallback: false,
      selectionRole: 'formula recognition challenger if server-free mobile path is proven',
      mustProve: <String>['server-free inference', 'model footprint', 'editable LaTeX candidate', 'license clearance'],
      rejectionReasons: <String>['server-only recognition', 'mobile footprint unsuitable', 'cannot produce editable LaTeX'],
    ),
    GaussWinnerEngineSelectionCandidateRule(
      family: GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusL,
      label: 'PP-FormulaNet_plus-L',
      mayBePrimaryFormulaRecognizer: true,
      mayBeFallback: false,
      selectionRole: 'primary premium formula OCR candidate for fraction/integral/sigma/matrix recognition if evidence passes',
      mustProve: <String>['complex structural LaTeX quality', 'offline after verified install', 'mobile size and latency budget', 'license clearance'],
      rejectionReasons: <String>['model footprint too large', 'latency too high', 'license or runtime path not cleared'],
    ),
  ];

  static const hardThresholds = <GaussWinnerEngineSelectionThreshold>[
    GaussWinnerEngineSelectionThreshold(key: 'realBenchmarkReport', description: 'Q246/Q240R3-compatible real-image benchmark report must exist', hardGate: true),
    GaussWinnerEngineSelectionThreshold(key: 'minimumSampleCount', description: 'at least 30 real sample results must be present', hardGate: true),
    GaussWinnerEngineSelectionThreshold(key: 'mathLiveReviewRequired', description: 'every candidate must enter editable MathLive review before import', hardGate: true),
    GaussWinnerEngineSelectionThreshold(key: 'directSolveBlocked', description: 'camera OCR must never solve/evaluate directly', hardGate: true),
    GaussWinnerEngineSelectionThreshold(key: 'licenseClearedForDistribution', description: 'candidate license must be cleared before product path selection', hardGate: true),
    GaussWinnerEngineSelectionThreshold(key: 'offlineAfterInstallProven', description: 'candidate must work offline after verified model installation', hardGate: true),
    GaussWinnerEngineSelectionThreshold(key: 'deferredModelSizeBudget', description: 'model must fit deferred download budget, not base APK bundling', hardGate: true),
    GaussWinnerEngineSelectionThreshold(key: 'medianLatencyBudget', description: 'median recognition latency must stay within mobile interaction budget', hardGate: true),
    GaussWinnerEngineSelectionThreshold(key: 'plainTextOcrFallbackDisabled', description: 'Plain text OCR fallback is disabled; PP-FormulaNet_plus-L is a primary formula OCR candidate', hardGate: true),
  ];

  static const requiredEvidenceArtifacts = <String>[
    'externalLabReportJson',
    'reportSha256',
    'fixtureManifestSha256',
    'caseLevelExpectedVsActualLatexDiffs',
    'structuralEquivalenceReport',
    'latencyMedianAndP95Report',
    'modelSizeAndPeakMemoryReport',
    'offlineAfterInstallProof',
    'licenseDistributionNote',
    'mathLiveEditableReviewCompatibilityProof',
  ];

  static bool get hasAllCandidateRules => candidateRules.length == 6;
  static bool get formulaOcrPrimaryEngineOnly => candidateRules
      .where((rule) => rule.family == GaussOcrBenchmarkEngineFamily.ppFormulaNetPlusL)
      .every((rule) => rule.mayBePrimaryFormulaRecognizer && rule.mayBeFallback == false);
  static bool get hasHardSelectionGates => hardThresholds.where((threshold) => threshold.hardGate).length >= 9;
  static bool get canBindRuntimeInQ247 => false;
  static bool get canBundleModelInBaseApkInQ247 => false;

  static GaussWinnerEngineSelectionGateResult evaluateEvidence(GaussWinnerEngineSelectionEvidence evidence) {
    final issues = <String>[];

    if (!evidence.hasRealBenchmarkReport) {
      issues.add('missing real Q246/Q240R3 benchmark report');
      return _blocked(GaussWinnerEngineSelectionDecision.blockedNoRealBenchmarkReport, issues);
    }
    if (evidence.sampleCount < minimumRealSampleCount) {
      issues.add('insufficient real sample coverage');
      return _blocked(GaussWinnerEngineSelectionDecision.blockedInsufficientCoverage, issues);
    }
    if (!evidence.mathLiveReviewRequired) {
      issues.add('editable MathLive review is not mandatory');
      return _blocked(GaussWinnerEngineSelectionDecision.blockedMissingMathLiveReview, issues);
    }
    if (evidence.directSolveAllowed) {
      issues.add('direct solve/evaluate from camera OCR is unsafe');
      return _blocked(GaussWinnerEngineSelectionDecision.blockedUnsafeDirectSolve, issues);
    }
    if (!evidence.licenseClearedForDistribution) {
      issues.add('license is not cleared for distribution');
      return _blocked(GaussWinnerEngineSelectionDecision.blockedLicenseNotCleared, issues);
    }
    if (!evidence.offlineAfterInstallProven) {
      issues.add('offline recognition after verified install is not proven');
      return _blocked(GaussWinnerEngineSelectionDecision.blockedOfflineNotProven, issues);
    }
    if (evidence.modelSizeBytes <= 0 || evidence.modelSizeBytes > maxDeferredDownloadModelSizeBytes) {
      issues.add('model does not fit deferred download size budget');
      return _blocked(GaussWinnerEngineSelectionDecision.blockedModelTooLargeForDeferredDownload, issues);
    }
    if (evidence.medianLatencyMs <= 0 || evidence.medianLatencyMs > maxMedianLatencyMs) {
      issues.add('median recognition latency exceeds budget');
      return _blocked(GaussWinnerEngineSelectionDecision.blockedLatencyBudget, issues);
    }
    if (evidence.claimsPlainTextOcrFallbackAsPrimary) {
      issues.add('Plain text OCR fallback is disabled for primary math formula recognition');
      return _blocked(GaussWinnerEngineSelectionDecision.blockedPlainTextOcrFallbackPrimaryClaim, issues);
    }

    return const GaussWinnerEngineSelectionGateResult(
      phase: phase,
      decision: GaussWinnerEngineSelectionDecision.eligibleForQ248DeferredModelDownloadPlanning,
      issues: <String>[],
      benchmarkWinnerSelected: false,
      productionRuntimeBindingAllowed: false,
      mathLiveReviewRequired: true,
      directSolveAllowed: false,
    );
  }

  static GaussWinnerEngineSelectionGateResult _blocked(
    GaussWinnerEngineSelectionDecision decision,
    List<String> issues,
  ) {
    return GaussWinnerEngineSelectionGateResult(
      phase: phase,
      decision: decision,
      issues: List<String>.unmodifiable(issues),
      benchmarkWinnerSelected: false,
      productionRuntimeBindingAllowed: false,
      mathLiveReviewRequired: true,
      directSolveAllowed: false,
    );
  }
}
