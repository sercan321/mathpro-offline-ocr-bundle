import 'gauss_ocr_benchmark_dataset_lab_runner.dart';
import 'gauss_ocr_benchmark_external_lab_result_schema_policy.dart';
import 'gauss_ocr_engine_benchmark_court.dart';

/// External report readiness state for future OCR benchmark evidence.
enum GaussOcrExternalLabReportStatus {
  draft,
  schemaReady,
  evidenceReady,
  blocked,
  invalid,
}

/// Per-case OCR outcome classification for future lab results.
enum GaussOcrExternalLabSampleOutcome {
  exactLatex,
  structurallyEquivalent,
  partial,
  failed,
  skipped,
}

class GaussOcrExternalLabDeviceProfile {
  const GaussOcrExternalLabDeviceProfile({
    required this.deviceLabel,
    required this.androidVersion,
    required this.runtimeTarget,
    required this.offlineMode,
    required this.cpuOrAccelerator,
  });

  final String deviceLabel;
  final String androidVersion;
  final String runtimeTarget;
  final bool offlineMode;
  final String cpuOrAccelerator;
}

class GaussOcrExternalLabCandidateResult {
  const GaussOcrExternalLabCandidateResult({
    required this.rank,
    required this.latex,
    required this.confidence,
    required this.warnings,
  });

  final int rank;
  final String latex;
  final double confidence;
  final List<String> warnings;

  bool get requiresEditableMathLiveReview => true;
  bool get directSolveAllowed => false;
}

class GaussOcrExternalLabSampleResult {
  const GaussOcrExternalLabSampleResult({
    required this.caseId,
    required this.fixtureName,
    required this.referenceLatex,
    required this.predictedLatex,
    required this.outcome,
    required this.confidence,
    required this.processingTimeMs,
    required this.matchedStructures,
    required this.candidates,
  });

  final String caseId;
  final String fixtureName;
  final String referenceLatex;
  final String predictedLatex;
  final GaussOcrExternalLabSampleOutcome outcome;
  final double confidence;
  final int processingTimeMs;
  final List<GaussOcrExpectedStructure> matchedStructures;
  final List<GaussOcrExternalLabCandidateResult> candidates;

  bool get requiresEditableMathLiveReview => true;
  bool get directSolveAllowed => false;
  bool get hasCandidateList => candidates.isNotEmpty;
  bool get hasValidTiming => processingTimeMs >= 0;
}

class GaussOcrExternalLabEngineRun {
  const GaussOcrExternalLabEngineRun({
    required this.schemaVersion,
    required this.engineFamily,
    required this.engineLabel,
    required this.engineVersion,
    required this.modelVersion,
    required this.modelSizeBytes,
    required this.peakMemoryMb,
    required this.offlineAfterInstall,
    required this.licenseClearedForDistribution,
    required this.deviceProfile,
    required this.sampleResults,
  });

  final String schemaVersion;
  final GaussOcrBenchmarkEngineFamily engineFamily;
  final String engineLabel;
  final String engineVersion;
  final String modelVersion;
  final int modelSizeBytes;
  final int peakMemoryMb;
  final bool offlineAfterInstall;
  final bool licenseClearedForDistribution;
  final GaussOcrExternalLabDeviceProfile deviceProfile;
  final List<GaussOcrExternalLabSampleResult> sampleResults;

  bool get requiresMathLiveReview => true;
  bool get directSolveAllowed => false;
  bool get hasEnoughSampleCoverage => sampleResults.length >= minimumExternalReportSampleCount;
  bool get allSamplesBlockDirectSolve => sampleResults.every((sample) => !sample.directSolveAllowed);
  bool get allCandidatesRequireReview => sampleResults.every((sample) => sample.requiresEditableMathLiveReview);
  bool get mayBeConsideredForWinnerSelection =>
      hasEnoughSampleCoverage &&
      offlineAfterInstall &&
      licenseClearedForDistribution &&
      allSamplesBlockDirectSolve &&
      allCandidatesRequireReview;

  static const int minimumExternalReportSampleCount = 30;
}

/// V172-Q240R2 schema contract for future fixture manifests and external lab
/// result reports. It is intentionally data-contract only and cannot run OCR.
class GaussOcrBenchmarkExternalLabResultSchema {
  const GaussOcrBenchmarkExternalLabResultSchema._();

  static const String phase = GaussOcrBenchmarkExternalLabResultSchemaPolicy.fullPhase;
  static const String schemaVersion = 'gauss-ocr-benchmark-external-lab-v1';
  static const bool realEngineInvocationAllowed = false;
  static const bool realImageFixturesBundled = false;
  static const bool productionResultWriteAllowed = false;
  static const bool directSolveAllowed = false;
  static const bool mathLiveReviewRequired = true;
  static const int minimumSampleCount = GaussOcrExternalLabEngineRun.minimumExternalReportSampleCount;

  static const List<String> fixtureManifestRequiredKeys = <String>[
    'schemaVersion',
    'datasetVersion',
    'caseId',
    'fixtureName',
    'captureCondition',
    'difficulty',
    'referenceLatex',
    'expectedStructures',
    'sourceType',
    'sha256',
  ];

  static const List<String> externalLabReportRequiredKeys = <String>[
    'schemaVersion',
    'phase',
    'engineFamily',
    'engineLabel',
    'engineVersion',
    'modelVersion',
    'modelSizeBytes',
    'peakMemoryMb',
    'offlineAfterInstall',
    'licenseClearedForDistribution',
    'deviceProfile',
    'sampleResults',
    'mathLiveReviewRequired',
    'directSolveAllowed',
  ];

  static const List<String> sampleResultRequiredKeys = <String>[
    'caseId',
    'fixtureName',
    'referenceLatex',
    'predictedLatex',
    'candidateLatex',
    'confidence',
    'processingTimeMs',
    'outcome',
    'matchedStructures',
    'mathLiveReviewRequired',
    'directSolveAllowed',
  ];

  static const List<String> requiredScoringDimensions = <String>[
    'latexExactness',
    'structuralEquivalence',
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
    'licenseAndDistributionRisk',
    'androidRuntimeBindingRisk',
  ];

  static const List<String> forbiddenReportKeys = <String>[
    'autoEvaluate',
    'autoSolve',
    'writeHistoryWithoutReview',
    'graphWithoutReview',
    'productionModelUrl',
    'cloudApiKey',
  ];

  static const List<String> evidenceTemplatePaths = <String>[
    'docs/evidence/V172_Q240R2_OCR_BENCHMARK_FIXTURE_MANIFEST_TEMPLATE.json',
    'docs/evidence/V172_Q240R2_OCR_BENCHMARK_EXTERNAL_LAB_RESULT_SCHEMA.json',
  ];

  static const Map<String, Object> emptyExternalLabReportTemplate = <String, Object>{
    'schemaVersion': schemaVersion,
    'phase': GaussOcrBenchmarkExternalLabResultSchemaPolicy.phase,
    'engineFamily': 'UNSELECTED',
    'engineLabel': 'UNSELECTED',
    'engineVersion': 'UNSET',
    'modelVersion': 'UNSET',
    'modelSizeBytes': 0,
    'peakMemoryMb': 0,
    'offlineAfterInstall': false,
    'licenseClearedForDistribution': false,
    'mathLiveReviewRequired': true,
    'directSolveAllowed': false,
    'sampleResults': <Object>[],
  };

  static bool get schemaHasCoreReportKeys =>
      externalLabReportRequiredKeys.contains('engineFamily') &&
      externalLabReportRequiredKeys.contains('sampleResults') &&
      externalLabReportRequiredKeys.contains('mathLiveReviewRequired') &&
      externalLabReportRequiredKeys.contains('directSolveAllowed');

  static bool get schemaHasFixtureKeys =>
      fixtureManifestRequiredKeys.contains('caseId') &&
      fixtureManifestRequiredKeys.contains('referenceLatex') &&
      fixtureManifestRequiredKeys.contains('expectedStructures') &&
      fixtureManifestRequiredKeys.contains('sha256');

  static bool get schemaBlocksUnsafeActions =>
      forbiddenReportKeys.contains('autoEvaluate') &&
      forbiddenReportKeys.contains('autoSolve') &&
      forbiddenReportKeys.contains('writeHistoryWithoutReview') &&
      directSolveAllowed == false;
}
