import 'gauss_ocr_benchmark_external_lab_intake_validation_gate_policy.dart';
import 'gauss_ocr_benchmark_external_lab_result_schema.dart';
import 'gauss_ocr_benchmark_external_lab_result_schema_policy.dart';

/// Final intake decision for a future external math OCR benchmark report.
enum GaussOcrExternalLabIntakeDecision {
  eligibleForWinnerAdapterReview,
  blocked,
  invalidSchema,
  unsafeActionBlocked,
  insufficientCoverage,
  licenseBlocked,
  offlineBlocked,
}

/// Issue severity emitted by the static intake validator.
enum GaussOcrExternalLabIntakeIssueSeverity {
  info,
  warning,
  blocking,
}

class GaussOcrExternalLabIntakeIssue {
  const GaussOcrExternalLabIntakeIssue({
    required this.code,
    required this.message,
    required this.severity,
  });

  final String code;
  final String message;
  final GaussOcrExternalLabIntakeIssueSeverity severity;

  bool get isBlocking => severity == GaussOcrExternalLabIntakeIssueSeverity.blocking;
}

class GaussOcrExternalLabIntakeValidationResult {
  const GaussOcrExternalLabIntakeValidationResult({
    required this.phase,
    required this.decision,
    required this.issues,
    required this.sampleCount,
    required this.mathLiveReviewRequired,
    required this.directSolveAllowed,
    required this.productionRuntimeBindingAllowed,
  });

  final String phase;
  final GaussOcrExternalLabIntakeDecision decision;
  final List<GaussOcrExternalLabIntakeIssue> issues;
  final int sampleCount;
  final bool mathLiveReviewRequired;
  final bool directSolveAllowed;
  final bool productionRuntimeBindingAllowed;

  bool get hasBlockingIssues => issues.any((issue) => issue.isBlocking);
  bool get mayEnterWinnerAdapterReview =>
      decision == GaussOcrExternalLabIntakeDecision.eligibleForWinnerAdapterReview &&
      !hasBlockingIssues &&
      mathLiveReviewRequired &&
      directSolveAllowed == false &&
      productionRuntimeBindingAllowed == false;
}

/// V172-Q240R3 intake gate for future external benchmark evidence.
///
/// It validates report shape and safety flags only. It intentionally cannot run
/// OCR engines, download models, call MathLive production bridge, choose a
/// winner, or send a camera result to solver/graph/history.
class GaussOcrBenchmarkExternalLabIntakeValidationGate {
  const GaussOcrBenchmarkExternalLabIntakeValidationGate._();

  static const String phase = GaussOcrBenchmarkExternalLabIntakeValidationGatePolicy.fullPhase;
  static const String schemaVersion = GaussOcrBenchmarkExternalLabResultSchema.schemaVersion;
  static const bool realEngineInvocationAllowed = false;
  static const bool productionRuntimeBindingAllowed = false;
  static const bool winnerSelectionAllowed = false;
  static const bool directSolveAllowed = false;
  static const bool mathLiveReviewRequired = true;

  static const List<String> requiredTopLevelKeys = <String>[
    ...GaussOcrBenchmarkExternalLabResultSchema.externalLabReportRequiredKeys,
    'reportSha256',
    'fixtureManifestSha256',
    'createdAtUtc',
  ];

  static const List<String> requiredSafetyFlags = <String>[
    'mathLiveReviewRequired',
    'directSolveAllowed',
    'offlineAfterInstall',
    'licenseClearedForDistribution',
  ];

  static const List<String> blockingUnsafeKeys = <String>[
    ...GaussOcrBenchmarkExternalLabResultSchema.forbiddenReportKeys,
    'evaluateFromCamera',
    'solveFromCamera',
    'graphFromCamera',
    'historyFromCamera',
    'workspaceImportWithoutReview',
  ];

  static const List<String> requiredPerSampleKeys = <String>[
    ...GaussOcrBenchmarkExternalLabResultSchema.sampleResultRequiredKeys,
    'fixtureSha256',
  ];

  static const List<String> validationStages = <String>[
    'schemaVersionGate',
    'requiredKeyGate',
    'forbiddenUnsafeActionGate',
    'mathLiveReviewGate',
    'directSolveBlockGate',
    'coverageGate',
    'licenseGate',
    'offlineInstallGate',
    'sampleShapeGate',
    'winnerAdapterReviewOnlyGate',
  ];

  static GaussOcrExternalLabIntakeValidationResult validateReport(Map<String, Object?> report) {
    final issues = <GaussOcrExternalLabIntakeIssue>[];
    void block(String code, String message) {
      issues.add(
        GaussOcrExternalLabIntakeIssue(
          code: code,
          message: message,
          severity: GaussOcrExternalLabIntakeIssueSeverity.blocking,
        ),
      );
    }

    if (report['schemaVersion'] != schemaVersion) {
      block('schemaVersion', 'External lab report schemaVersion must match $schemaVersion.');
    }
    if (report['phase'] != GaussOcrBenchmarkExternalLabResultSchemaPolicy.phase) {
      block('sourcePhase', 'External lab report must be produced against the Q240R2 schema phase.');
    }

    for (final key in requiredTopLevelKeys) {
      if (!report.containsKey(key)) {
        block('missing:$key', 'External lab report missing required top-level key: $key.');
      }
    }
    for (final key in blockingUnsafeKeys) {
      if (report.containsKey(key)) {
        block('unsafe:$key', 'External lab report contains forbidden unsafe key: $key.');
      }
    }

    final sampleResults = report['sampleResults'];
    final sampleCount = sampleResults is List<Object?> ? sampleResults.length : 0;
    if (sampleCount < GaussOcrBenchmarkExternalLabResultSchema.minimumSampleCount) {
      block('coverage', 'External lab report must include at least 30 sample results.');
    }

    final mathLiveReview = report['mathLiveReviewRequired'] == true;
    final directSolve = report['directSolveAllowed'] == true;
    if (!mathLiveReview) {
      block('mathLiveReviewRequired', 'MathLive editable review must be required for every OCR candidate.');
    }
    if (directSolve) {
      block('directSolveAllowed', 'Camera OCR result must not be allowed to solve/evaluate directly.');
    }
    if (report['offlineAfterInstall'] != true) {
      block('offlineAfterInstall', 'Candidate engine must prove offline operation after model install.');
    }
    if (report['licenseClearedForDistribution'] != true) {
      block('licenseClearedForDistribution', 'Candidate engine license must be cleared for distribution.');
    }
    if ((report['modelSizeBytes'] as num?) == null || (report['modelSizeBytes'] as num?)! <= 0) {
      block('modelSizeBytes', 'Candidate report must provide positive modelSizeBytes.');
    }
    if ((report['peakMemoryMb'] as num?) == null || (report['peakMemoryMb'] as num?)! <= 0) {
      block('peakMemoryMb', 'Candidate report must provide positive peakMemoryMb.');
    }

    if (sampleResults is List<Object?>) {
      for (var i = 0; i < sampleResults.length; i += 1) {
        final sample = sampleResults[i];
        if (sample is! Map<String, Object?>) {
          block('sample:$i:shape', 'Sample result $i must be a JSON object.');
          continue;
        }
        for (final key in requiredPerSampleKeys) {
          if (!sample.containsKey(key)) {
            block('sample:$i:missing:$key', 'Sample result $i missing required key: $key.');
          }
        }
        if (sample['mathLiveReviewRequired'] != true) {
          block('sample:$i:review', 'Sample result $i must require editable MathLive review.');
        }
        if (sample['directSolveAllowed'] == true) {
          block('sample:$i:directSolve', 'Sample result $i must block direct solve.');
        }
      }
    } else {
      block('sampleResults', 'sampleResults must be a JSON list.');
    }

    final decision = _decisionFor(report, issues, sampleCount);
    return GaussOcrExternalLabIntakeValidationResult(
      phase: phase,
      decision: decision,
      issues: List<GaussOcrExternalLabIntakeIssue>.unmodifiable(issues),
      sampleCount: sampleCount,
      mathLiveReviewRequired: mathLiveReview,
      directSolveAllowed: directSolve,
      productionRuntimeBindingAllowed: false,
    );
  }

  static GaussOcrExternalLabIntakeDecision _decisionFor(
    Map<String, Object?> report,
    List<GaussOcrExternalLabIntakeIssue> issues,
    int sampleCount,
  ) {
    if (issues.any((issue) => issue.code.startsWith('unsafe:'))) {
      return GaussOcrExternalLabIntakeDecision.unsafeActionBlocked;
    }
    if (report['licenseClearedForDistribution'] != true) {
      return GaussOcrExternalLabIntakeDecision.licenseBlocked;
    }
    if (report['offlineAfterInstall'] != true) {
      return GaussOcrExternalLabIntakeDecision.offlineBlocked;
    }
    if (sampleCount < GaussOcrBenchmarkExternalLabResultSchema.minimumSampleCount) {
      return GaussOcrExternalLabIntakeDecision.insufficientCoverage;
    }
    if (issues.any((issue) => issue.isBlocking)) {
      return GaussOcrExternalLabIntakeDecision.invalidSchema;
    }
    return GaussOcrExternalLabIntakeDecision.eligibleForWinnerAdapterReview;
  }

  static bool get hasRequiredSafetyFlags =>
      requiredSafetyFlags.contains('mathLiveReviewRequired') &&
      requiredSafetyFlags.contains('directSolveAllowed') &&
      requiredSafetyFlags.contains('offlineAfterInstall') &&
      requiredSafetyFlags.contains('licenseClearedForDistribution');

  static bool get blocksUnsafeActions =>
      blockingUnsafeKeys.contains('autoSolve') &&
      blockingUnsafeKeys.contains('workspaceImportWithoutReview') &&
      directSolveAllowed == false &&
      productionRuntimeBindingAllowed == false;
}
