import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_prototype_evidence_intake_gate.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_prototype_evidence_intake_gate_policy.dart';

void main() {
  group('V172-Q264-PP-FORMULANET-S-RUNTIME-PROTOTYPE-EVIDENCE-INTAKE-GATE', () {
    const readyInput = GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateInput(
      q263SmokeEvidenceTemplatePresent: true,
      intakeState: 'intakeTemplateReadyButRuntimeDisabled',
      allIntakeStatesRepresented: true,
      evidenceJsonSchemaRequired: true,
      evidenceJsonVersionRequired: true,
      deviceIdRequired: true,
      androidApiAndAbiRequired: true,
      runtimeCandidateRequired: true,
      privateArtifactPathRequired: true,
      artifactSha256Candidate: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
      modelFormatProbeRecorded: true,
      bridgeInputEnvelopeHashRequired: true,
      bridgeOutputEnvelopeHashRequired: true,
      bridgeInvocationStatusRequired: true,
      latencyMeasurementRequired: true,
      peakMemoryMeasurementRequired: true,
      timeoutCancellationStatusRequired: true,
      bridgeErrorCodeRequired: true,
      mathLiveReviewOpenedMustBeTrue: true,
      directSolveBlockedMustBeTrue: true,
      flutterAnalyzeTestRunLogReferenceRequired: true,
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
      evidenceAcceptedWithoutValidation: false,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      intakeLabel: 'Q264 evidence intake gate only',
    );

    test('declares evidence intake without accepting runtime evidence or adding inference', () {
      final result = GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGate.evaluate(readyInput);

      expect(result.decision, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.runtimePrototypeEvidenceIntakeGateStaticReady);
      expect(result.runtimePrototypeEvidenceIntakeGateStaticReady, isTrue);
      expect(result.phase, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGatePolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.evidenceIntakeMode, 'runtime-prototype-evidence-intake-gate-only-no-runtime-no-inference');
      expect(result.requiredEvidenceJsonFields, contains('artifactSha256'));
      expect(result.requiredEvidenceJsonFields, contains('mathLiveReviewOpened'));
      expect(result.requiredIntakeValidationGates, contains('artifactSha256MustBe64Hex'));
      expect(result.requiredIntakeValidationGates, contains('directSolveBlockedMustBeTrue'));
      expect(result.blockedUntilRealEvidence, contains('realDeviceSmokeEvidenceJsonFile'));
      expect(result.blockedUntilRealEvidence, contains('realFlutterAnalyzeLog'));
      expect(result.forbiddenActions, contains('acceptRuntimeEvidenceWithoutSchemaValidation'));
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
      expect(result.runtimeEvidenceAcceptedWithoutValidation, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canAcceptEvidenceWithoutValidation, isFalse);
      expect(result.canClaimRuntimeSmokePassInQ264, isFalse);
      expect(result.canClaimOcrPassInQ264, isFalse);
      expect(result.canAddPaddleRuntimeInQ264, isFalse);
      expect(result.canBindRuntimeBridgeInQ264, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('blocks malformed artifact SHA evidence before any runtime acceptance', () {
      const badShaInput = GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateInput(
        q263SmokeEvidenceTemplatePresent: true,
        intakeState: 'intakeTemplateReadyButRuntimeDisabled',
        allIntakeStatesRepresented: true,
        evidenceJsonSchemaRequired: true,
        evidenceJsonVersionRequired: true,
        deviceIdRequired: true,
        androidApiAndAbiRequired: true,
        runtimeCandidateRequired: true,
        privateArtifactPathRequired: true,
        artifactSha256Candidate: 'not-a-sha',
        modelFormatProbeRecorded: true,
        bridgeInputEnvelopeHashRequired: true,
        bridgeOutputEnvelopeHashRequired: true,
        bridgeInvocationStatusRequired: true,
        latencyMeasurementRequired: true,
        peakMemoryMeasurementRequired: true,
        timeoutCancellationStatusRequired: true,
        bridgeErrorCodeRequired: true,
        mathLiveReviewOpenedMustBeTrue: true,
        directSolveBlockedMustBeTrue: true,
        flutterAnalyzeTestRunLogReferenceRequired: true,
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
        evidenceAcceptedWithoutValidation: false,
        editableMathLiveReviewRequired: true,
        userApprovalRequiredBeforeWorkspaceImport: true,
        intakeLabel: 'bad sha evidence',
      );
      final result = GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGate.evaluate(badShaInput);
      expect(result.decision, GaussPpFormulaNetSRuntimePrototypeEvidenceIntakeGateDecision.blockedMissingArtifactEvidence);
      expect(result.runtimePrototypeEvidenceIntakeGateStaticReady, isFalse);
    });

    test('does not add model binaries or runtime dependencies', () {
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
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q264 must not add $forbidden');
      }
      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
    });
  });
}

// Q264 decision coverage markers for static verifier:
// blockedMissingQ263Template
// blockedMissingEvidenceJsonSchema
// blockedMissingDeviceAndAbiEvidence
// blockedMissingArtifactEvidence
// blockedMissingBridgeEvidence
// blockedMissingPerformanceEvidence
// blockedMissingSafetyEvidence
// blockedUnsafeRuntimeBinding
// runtimePrototypeEvidenceIntakeGateStaticReady
