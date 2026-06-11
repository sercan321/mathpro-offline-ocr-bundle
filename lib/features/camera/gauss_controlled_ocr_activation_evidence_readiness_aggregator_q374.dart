import 'gauss_controlled_ocr_activation_evidence_capture_entry_q373.dart';
import 'gauss_controlled_ocr_activation_evidence_readiness_aggregator_q374_policy.dart';

class GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Result {
  const GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Result({
    required this.phase,
    required this.sourcePhase,
    required this.status,
    required this.aggregatorVersion,
    required this.aggregatorPrepared,
    required this.requiresQ373EvidenceCaptureEntry,
    required this.directOcrToWorkspaceImportBlocked,
    required this.directOcrToSolveGraphSolutionHistoryBlocked,
    required this.startupAutoExecutionBlocked,
    required this.cameraAutoExecutionBlocked,
    required this.workspaceAutoExecutionBlocked,
    required this.privateStorageReady,
    required this.modelLoadReady,
    required this.dummyRuntimeCallReady,
    required this.imageToLatexReady,
    required this.reviewHandoffReady,
    required this.approvedImportEnvelopeReady,
    required this.cameraOcrUsableFlowReady,
    required this.ocrPassClaimed,
  });

  final String phase;
  final String sourcePhase;
  final String status;
  final String aggregatorVersion;
  final bool aggregatorPrepared;
  final bool requiresQ373EvidenceCaptureEntry;
  final bool directOcrToWorkspaceImportBlocked;
  final bool directOcrToSolveGraphSolutionHistoryBlocked;
  final bool startupAutoExecutionBlocked;
  final bool cameraAutoExecutionBlocked;
  final bool workspaceAutoExecutionBlocked;
  final bool privateStorageReady;
  final bool modelLoadReady;
  final bool dummyRuntimeCallReady;
  final bool imageToLatexReady;
  final bool reviewHandoffReady;
  final bool approvedImportEnvelopeReady;
  final bool cameraOcrUsableFlowReady;
  final bool ocrPassClaimed;
}

class GaussControlledOcrActivationEvidenceReadinessSnapshotQ374 {
  const GaussControlledOcrActivationEvidenceReadinessSnapshotQ374({
    required this.privateStorageReady,
    required this.modelLoadReady,
    required this.dummyRuntimeCallReady,
    required this.imageToLatexReady,
    required this.reviewHandoffReady,
    required this.approvedImportEnvelopeReady,
    required this.cameraOcrUsableFlowReady,
    required this.blockedReasons,
  });

  final bool privateStorageReady;
  final bool modelLoadReady;
  final bool dummyRuntimeCallReady;
  final bool imageToLatexReady;
  final bool reviewHandoffReady;
  final bool approvedImportEnvelopeReady;
  final bool cameraOcrUsableFlowReady;
  final List<String> blockedReasons;

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'phase': GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.phase,
      'aggregatorVersion': GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.aggregatorVersion,
      'privateStorageReady': privateStorageReady,
      'modelLoadReady': modelLoadReady,
      'dummyRuntimeCallReady': dummyRuntimeCallReady,
      'imageToLatexReady': imageToLatexReady,
      'reviewHandoffReady': reviewHandoffReady,
      'approvedImportEnvelopeReady': approvedImportEnvelopeReady,
      'cameraOcrUsableFlowReady': cameraOcrUsableFlowReady,
      'blockedReasons': blockedReasons,
      'directOcrToWorkspaceImportBlocked': true,
      'directOcrToSolveGraphSolutionHistoryBlocked': true,
      'ocrPassClaimed': false,
    };
  }
}

class GaussControlledOcrActivationEvidenceReadinessAggregatorQ374 {
  const GaussControlledOcrActivationEvidenceReadinessAggregatorQ374._();

  static GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Result evaluate() {
    return const GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Result(
      phase: GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.phase,
      sourcePhase: GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.sourcePhase,
      status: GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.status,
      aggregatorVersion: GaussControlledOcrActivationEvidenceReadinessAggregatorQ374Policy.aggregatorVersion,
      aggregatorPrepared: true,
      requiresQ373EvidenceCaptureEntry: true,
      directOcrToWorkspaceImportBlocked: true,
      directOcrToSolveGraphSolutionHistoryBlocked: true,
      startupAutoExecutionBlocked: true,
      cameraAutoExecutionBlocked: true,
      workspaceAutoExecutionBlocked: true,
      privateStorageReady: false,
      modelLoadReady: false,
      dummyRuntimeCallReady: false,
      imageToLatexReady: false,
      reviewHandoffReady: false,
      approvedImportEnvelopeReady: false,
      cameraOcrUsableFlowReady: false,
      ocrPassClaimed: false,
    );
  }

  static Future<GaussControlledOcrActivationEvidenceReadinessSnapshotQ374> captureAndClassify(
    GaussControlledOcrActivationEvidenceCaptureEntryQ373Request request,
  ) async {
    final evidence = await GaussControlledOcrActivationEvidenceCaptureEntryQ373.captureEvidence(request);
    return classifyEvidence(evidence);
  }

  static GaussControlledOcrActivationEvidenceReadinessSnapshotQ374 classifyEvidence(
    Map<String, Object?> evidence,
  ) {
    final privateStorage = _asMap(evidence['privateStorageActivationEvidence']);
    final modelLoad = _asMap(evidence['modelLoadSmokeEvidence']);
    final dummy = _asMap(evidence['dummyRuntimeCallEvidence']);
    final imageToLatex = _asMap(evidence['imageToLatexEvidence']);
    final review = _asMap(evidence['reviewHandoffEvidence']);
    final approvedImport = _asMap(evidence['approvedImportEvidence']);

    final privateStorageReady = _isReady(privateStorage, <String>['targetReady', 'privateStorageReady', 'sha256MatchesExpected']);
    final modelLoadReady = _isReady(modelLoad, <String>['modelLoaded']) && _emptyReason(modelLoad);
    final dummyRuntimeCallReady = _isReady(dummy, <String>['dummyRuntimeCallSucceeded', 'dummyRuntimeCallExecuted']) && _emptyReason(dummy);
    final imageToLatexReady = _isReady(imageToLatex, <String>['realImageToLatexInferenceSucceeded', 'imageToLatexInferenceSucceeded']) && _nonEmptyString(imageToLatex['candidateLatex']);
    final reviewHandoffReady = _isReady(review, <String>['reviewHandoffPrepared', 'editableMathLiveReviewRequired']) && _nonEmptyString(review['candidateLatex']);
    final approvedImportEnvelopeReady = _isReady(approvedImport, <String>['approvedWorkspaceImportEnvelopePrepared', 'approvedImportEnvelopePrepared']) && _nonEmptyString(approvedImport['approvedLatex']);

    final blockedReasons = <String>[];
    if (!privateStorageReady) blockedReasons.add('private-storage-not-ready');
    if (!modelLoadReady) blockedReasons.add('model-load-not-ready');
    if (!dummyRuntimeCallReady) blockedReasons.add('dummy-runtime-call-not-ready');
    if (!imageToLatexReady) blockedReasons.add('image-to-latex-candidate-not-ready');
    if (!reviewHandoffReady) blockedReasons.add('editable-mathlive-review-handoff-not-ready');
    if (!approvedImportEnvelopeReady) blockedReasons.add('approved-workspace-import-envelope-not-ready');

    final cameraOcrUsableFlowReady = privateStorageReady &&
        modelLoadReady &&
        dummyRuntimeCallReady &&
        imageToLatexReady &&
        reviewHandoffReady &&
        approvedImportEnvelopeReady;

    return GaussControlledOcrActivationEvidenceReadinessSnapshotQ374(
      privateStorageReady: privateStorageReady,
      modelLoadReady: modelLoadReady,
      dummyRuntimeCallReady: dummyRuntimeCallReady,
      imageToLatexReady: imageToLatexReady,
      reviewHandoffReady: reviewHandoffReady,
      approvedImportEnvelopeReady: approvedImportEnvelopeReady,
      cameraOcrUsableFlowReady: cameraOcrUsableFlowReady,
      blockedReasons: blockedReasons,
    );
  }

  static Map<String, Object?> _asMap(Object? value) {
    if (value is Map) {
      return value.map((key, mapValue) => MapEntry(key.toString(), mapValue));
    }
    return const <String, Object?>{};
  }

  static bool _isReady(Map<String, Object?> evidence, List<String> readinessKeys) {
    for (final key in readinessKeys) {
      if (evidence[key] == true) return true;
    }
    return false;
  }

  static bool _emptyReason(Map<String, Object?> evidence) {
    final reason = evidence['blockedReason'];
    if (reason == null) return true;
    return reason.toString().trim().isEmpty;
  }

  static bool _nonEmptyString(Object? value) {
    return value != null && value.toString().trim().isNotEmpty;
  }
}
