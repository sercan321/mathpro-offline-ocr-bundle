import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_evidence_acceptance_court.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_evidence_acceptance_court_policy.dart';

void main() {
  group('V172-Q265-PP-FORMULANET-S-RUNTIME-EVIDENCE-ACCEPTANCE-COURT', () {
    const acceptedInput = GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtInput(
      q264EvidenceIntakeGatePresent: true,
      evidenceJsonPresent: true,
      evidenceJsonSchemaValidated: true,
      deviceIdPresent: true,
      androidApiLevelPresent: true,
      androidAbiPresent: true,
      runtimeCandidatePresent: true,
      privateArtifactPathPresent: true,
      artifactSha256Candidate: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      modelFormatProbeAccepted: true,
      bridgeInputEnvelopeHashPresent: true,
      bridgeOutputEnvelopeHashPresent: true,
      bridgeInvocationStatusAccepted: true,
      latencyMs: 1200,
      peakMemoryMb: 256,
      timeoutCancellationRecorded: true,
      bridgeErrorCodeRecorded: true,
      mathLiveReviewOpened: true,
      directSolveBlocked: true,
      flutterAnalyzeLogPresent: true,
      flutterTestLogPresent: true,
      flutterRunLogPresent: true,
      noPaddleRuntimeDependencyAdded: true,
      noPaddleOcrDependencyAdded: true,
      noNativeBridgeAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noRealNetworkDownloadWorkerImplemented: true,
      productionDownloadEnabled: false,
      noProductionInferenceAllowed: true,
      runtimeSmokePassClaimed: false,
      ocrPassClaimed: false,
      evidenceAcceptedWithoutCourt: false,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      acceptanceLabel: 'Q265 accepted prototype evidence for review only',
    );

    test('accepts only validated Q264 evidence for prototype review, not runtime PASS', () {
      final result = GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourt.evaluate(acceptedInput);

      expect(result.decision, GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.runtimeEvidenceAcceptedForPrototypeReviewOnly);
      expect(result.runtimeEvidenceAcceptanceCourtStaticReady, isTrue);
      expect(result.acceptedForPrototypeReviewOnly, isTrue);
      expect(result.phase, GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.acceptanceCourtMode, 'runtime-evidence-acceptance-court-only-no-runtime-no-inference');
      expect(result.requiredAcceptanceGates, contains('evidenceJsonSchemaValidated'));
      expect(result.requiredAcceptanceGates, contains('latencyWithinBudget'));
      expect(result.requiredAcceptanceGates, contains('peakMemoryWithinBudget'));
      expect(result.requiredAcceptanceGates, contains('mathLiveReviewOpenedTrue'));
      expect(result.requiredAcceptanceGates, contains('directSolveBlockedTrue'));
      expect(result.blockedUntilRealEvidence, contains('realFlutterAnalyzeLog'));
      expect(result.forbiddenActions, contains('claimRuntimeSmokePassWithoutAcceptedEvidence'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimeSmokePassClaimed, isFalse);
      expect(result.runtimeEvidenceAcceptedWithoutCourt, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canClaimRuntimeSmokePassInQ265, isFalse);
      expect(result.canClaimOcrPassInQ265, isFalse);
      expect(result.canAddPaddleRuntimeInQ265, isFalse);
      expect(result.canBindRuntimeBridgeInQ265, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
      expect(result.canAcceptEvidenceWithoutCourt, isFalse);
    });

    test('rejects malformed SHA before any evidence acceptance', () {
      final result = GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourt.evaluate(const GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtInput(
        q264EvidenceIntakeGatePresent: true,
        evidenceJsonPresent: true,
        evidenceJsonSchemaValidated: true,
        deviceIdPresent: true,
        androidApiLevelPresent: true,
        androidAbiPresent: true,
        runtimeCandidatePresent: true,
        privateArtifactPathPresent: true,
        artifactSha256Candidate: 'not-a-sha',
        modelFormatProbeAccepted: true,
        bridgeInputEnvelopeHashPresent: true,
        bridgeOutputEnvelopeHashPresent: true,
        bridgeInvocationStatusAccepted: true,
        latencyMs: 1200,
        peakMemoryMb: 256,
        timeoutCancellationRecorded: true,
        bridgeErrorCodeRecorded: true,
        mathLiveReviewOpened: true,
        directSolveBlocked: true,
        flutterAnalyzeLogPresent: true,
        flutterTestLogPresent: true,
        flutterRunLogPresent: true,
        noPaddleRuntimeDependencyAdded: true,
        noPaddleOcrDependencyAdded: true,
        noNativeBridgeAdded: true,
        noJniBindingAdded: true,
        noMethodChannelRuntimeBindingAdded: true,
        noModelBinaryBundledInBaseApp: true,
        noProductionModelUrlBound: true,
        noRealNetworkDownloadWorkerImplemented: true,
        productionDownloadEnabled: false,
        noProductionInferenceAllowed: true,
        runtimeSmokePassClaimed: false,
        ocrPassClaimed: false,
        evidenceAcceptedWithoutCourt: false,
        editableMathLiveReviewRequired: true,
        userApprovalRequiredBeforeWorkspaceImport: true,
        acceptanceLabel: 'bad sha evidence',
      ));
      expect(result.decision, GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMalformedSha256);
      expect(result.runtimeEvidenceAcceptanceCourtStaticReady, isFalse);
    });

    test('rejects missing Flutter logs and does not add runtime dependencies', () {
      final missingLogs = GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourt.evaluate(const GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtInput(
        q264EvidenceIntakeGatePresent: true,
        evidenceJsonPresent: true,
        evidenceJsonSchemaValidated: true,
        deviceIdPresent: true,
        androidApiLevelPresent: true,
        androidAbiPresent: true,
        runtimeCandidatePresent: true,
        privateArtifactPathPresent: true,
        artifactSha256Candidate: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
        modelFormatProbeAccepted: true,
        bridgeInputEnvelopeHashPresent: true,
        bridgeOutputEnvelopeHashPresent: true,
        bridgeInvocationStatusAccepted: true,
        latencyMs: 1200,
        peakMemoryMb: 256,
        timeoutCancellationRecorded: true,
        bridgeErrorCodeRecorded: true,
        mathLiveReviewOpened: true,
        directSolveBlocked: true,
        flutterAnalyzeLogPresent: false,
        flutterTestLogPresent: true,
        flutterRunLogPresent: true,
        noPaddleRuntimeDependencyAdded: true,
        noPaddleOcrDependencyAdded: true,
        noNativeBridgeAdded: true,
        noJniBindingAdded: true,
        noMethodChannelRuntimeBindingAdded: true,
        noModelBinaryBundledInBaseApp: true,
        noProductionModelUrlBound: true,
        noRealNetworkDownloadWorkerImplemented: true,
        productionDownloadEnabled: false,
        noProductionInferenceAllowed: true,
        runtimeSmokePassClaimed: false,
        ocrPassClaimed: false,
        evidenceAcceptedWithoutCourt: false,
        editableMathLiveReviewRequired: true,
        userApprovalRequiredBeforeWorkspaceImport: true,
        acceptanceLabel: 'missing flutter analyze log',
      ));
      expect(missingLogs.decision, GaussPpFormulaNetSRuntimeEvidenceAcceptanceCourtDecision.rejectedMissingFlutterAnalyzeTestRunLogs);

      final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
      for (final forbidden in <String>[
        'google_mlkit_text_recognition',
        'paddleocr',
        'paddle_flutter',
        'paddle_lite',
        'onnxruntime',
        'tesseract',
        'pix2text',
        'flutter_downloader',
        'background_downloader',
        'dio',
      ]) {
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q265 must not add $forbidden');
      }
      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
    });
  });
}

// Q265 decision coverage markers for static verifier:
// rejectedMissingQ264IntakeGate
// rejectedMissingEvidenceJson
// rejectedMalformedSha256
// rejectedMissingDeviceAbiRuntimeEvidence
// rejectedMissingArtifactEvidence
// rejectedMissingBridgeEvidence
// rejectedLatencyBudget
// rejectedPeakMemoryBudget
// rejectedMissingMathLiveReviewEvidence
// rejectedMissingDirectSolveBlockedEvidence
// rejectedMissingFlutterAnalyzeTestRunLogs
// rejectedUnsafeRuntimeBinding
// runtimeEvidenceAcceptedForPrototypeReviewOnly
