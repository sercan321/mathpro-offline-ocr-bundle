import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_dependency_isolation.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_pp_formulanet_s_runtime_dependency_isolation_policy.dart';

void main() {
  group('V172-Q269-PP-FORMULANET-S-RUNTIME-DEPENDENCY-ISOLATION', () {
    const approvedInput = GaussPpFormulaNetSRuntimeDependencyIsolationInput(
      q268IsolatedRuntimeImplementationGatePresent: true,
      q268StillNoRuntimeNoInference: true,
      runtimeDependencyCandidateDocumented: true,
      dependencyIsolationPlanDocumented: true,
      gradleImpactReviewDocumented: true,
      androidAbiSplitPlanDocumented: true,
      transitiveDependencyAuditDocumented: true,
      apkAabSizeBudgetMb: 45,
      dependencyLicenseReviewDocumented: true,
      buildRollbackPlanDocumented: true,
      featureFlagDefaultOffDocumented: true,
      noDefaultRuntimeEnablement: true,
      runtimeClasspathIsolationDocumented: true,
      fallbackPlanDocumented: true,
      formulaOcrPrimaryOnly: true,
      editableMathLiveReviewRequired: true,
      userApprovalRequiredBeforeWorkspaceImport: true,
      directSolveBlocked: true,
      directGraphSolutionHistoryBlocked: true,
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
      dependencyIsolationPassClaimed: false,
      ocrPassClaimed: false,
      dependencyIsolationLabel: 'Q269 ready for future runtime dependency implementation only',
    );

    test('gates runtime dependency isolation without adding dependency in Q269', () {
      final result = GaussPpFormulaNetSRuntimeDependencyIsolation.evaluate(approvedInput);

      expect(result.decision, GaussPpFormulaNetSRuntimeDependencyIsolationDecision.readyForFutureRuntimeDependencyImplementationOnly);
      expect(result.runtimeDependencyIsolationStaticReady, isTrue);
      expect(result.readyForFutureRuntimeDependencyImplementationOnly, isTrue);
      expect(result.phase, GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.phase);
      expect(result.sourcePhase, GaussPpFormulaNetSRuntimeDependencyIsolationPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.dependencyIsolationMode, 'runtime-dependency-isolation-gate-only-no-runtime-dependency-no-inference');
      expect(result.requiredDependencyIsolationGates, contains('q268IsolatedRuntimeImplementationGatePresent'));
      expect(result.requiredDependencyIsolationGates, contains('gradleImpactReviewDocumented'));
      expect(result.requiredDependencyIsolationGates, contains('transitiveDependencyAuditDocumented'));
      expect(result.requiredDependencyIsolationGates, contains('apkAabSizeBudgetDocumented'));
      expect(result.requiredDependencyIsolationGates, contains('editableMathLiveReviewRequired'));
      expect(result.blockedUntilRealEvidence, contains('realGradleSyncLog'));
      expect(result.blockedUntilRealEvidence, contains('realApkAabSizeReport'));
      expect(result.runtimeDependencyCandidates, contains('paddleNativeRuntimeDependencyCandidate'));
      expect(result.dependencyIsolationStrategies, contains('dependencyBehindDisabledFeatureFlag'));
      expect(result.dependencyIsolationStrategies, contains('abiScopedRuntimeDependencyBoundary'));
      expect(result.forbiddenActions, contains('addPaddleRuntimeDependencyInQ269'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.runtimeFeatureFlagDefaultOff, isTrue);
      expect(result.dependencyIsolationPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.canAddRuntimeDependencyInQ269, isFalse);
      expect(result.canClaimDependencyIsolationPassInQ269, isFalse);
      expect(result.canClaimOcrPassInQ269, isFalse);
      expect(result.canBindNativeBridgeInQ269, isFalse);
      expect(result.canEnableRuntimeDependencyByDefaultInQ269, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
    });

    test('rejects missing Q268 gate, missing Gradle impact review, and direct solve risk', () {
      expect(GaussPpFormulaNetSRuntimeDependencyIsolation.evaluate(approvedInput.copyWith(q268IsolatedRuntimeImplementationGatePresent: false)).decision, GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingQ268IsolationGate);
      expect(GaussPpFormulaNetSRuntimeDependencyIsolation.evaluate(approvedInput.copyWith(gradleImpactReviewDocumented: false)).decision, GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedMissingGradleImpactReview);
      expect(GaussPpFormulaNetSRuntimeDependencyIsolation.evaluate(approvedInput.copyWith(directSolveBlocked: false)).decision, GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedDirectSolveOrImportRisk);
      expect(GaussPpFormulaNetSRuntimeDependencyIsolation.evaluate(approvedInput.copyWith(noPaddleRuntimeDependencyAdded: false)).decision, GaussPpFormulaNetSRuntimeDependencyIsolationDecision.blockedUnsafeDependencyAddedInQ269);
    });

    test('keeps runtime dependencies absent from pubspec during Q269', () {
      final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
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
        expect(pubspec.contains(forbidden), isFalse, reason: 'Q269 must not add $forbidden');
      }
    });
  });
}

extension _Q269Copy on GaussPpFormulaNetSRuntimeDependencyIsolationInput {
  GaussPpFormulaNetSRuntimeDependencyIsolationInput copyWith({
    bool? q268IsolatedRuntimeImplementationGatePresent,
    bool? q268StillNoRuntimeNoInference,
    bool? runtimeDependencyCandidateDocumented,
    bool? dependencyIsolationPlanDocumented,
    bool? gradleImpactReviewDocumented,
    bool? androidAbiSplitPlanDocumented,
    bool? transitiveDependencyAuditDocumented,
    int? apkAabSizeBudgetMb,
    bool? dependencyLicenseReviewDocumented,
    bool? buildRollbackPlanDocumented,
    bool? featureFlagDefaultOffDocumented,
    bool? noDefaultRuntimeEnablement,
    bool? runtimeClasspathIsolationDocumented,
    bool? fallbackPlanDocumented,
    bool? formulaOcrPrimaryOnly,
    bool? editableMathLiveReviewRequired,
    bool? userApprovalRequiredBeforeWorkspaceImport,
    bool? directSolveBlocked,
    bool? directGraphSolutionHistoryBlocked,
    bool? noPaddleRuntimeDependencyAdded,
    bool? noPaddleOcrDependencyAdded,
    bool? noNativeBridgeAdded,
    bool? noJniBindingAdded,
    bool? noMethodChannelRuntimeBindingAdded,
    bool? noModelBinaryBundledInBaseApp,
    bool? noProductionModelUrlBound,
    bool? noRealNetworkDownloadWorkerImplemented,
    bool? productionDownloadEnabled,
    bool? noProductionInferenceAllowed,
    bool? dependencyIsolationPassClaimed,
    bool? ocrPassClaimed,
    String? dependencyIsolationLabel,
  }) {
    return GaussPpFormulaNetSRuntimeDependencyIsolationInput(
      q268IsolatedRuntimeImplementationGatePresent: q268IsolatedRuntimeImplementationGatePresent ?? this.q268IsolatedRuntimeImplementationGatePresent,
      q268StillNoRuntimeNoInference: q268StillNoRuntimeNoInference ?? this.q268StillNoRuntimeNoInference,
      runtimeDependencyCandidateDocumented: runtimeDependencyCandidateDocumented ?? this.runtimeDependencyCandidateDocumented,
      dependencyIsolationPlanDocumented: dependencyIsolationPlanDocumented ?? this.dependencyIsolationPlanDocumented,
      gradleImpactReviewDocumented: gradleImpactReviewDocumented ?? this.gradleImpactReviewDocumented,
      androidAbiSplitPlanDocumented: androidAbiSplitPlanDocumented ?? this.androidAbiSplitPlanDocumented,
      transitiveDependencyAuditDocumented: transitiveDependencyAuditDocumented ?? this.transitiveDependencyAuditDocumented,
      apkAabSizeBudgetMb: apkAabSizeBudgetMb ?? this.apkAabSizeBudgetMb,
      dependencyLicenseReviewDocumented: dependencyLicenseReviewDocumented ?? this.dependencyLicenseReviewDocumented,
      buildRollbackPlanDocumented: buildRollbackPlanDocumented ?? this.buildRollbackPlanDocumented,
      featureFlagDefaultOffDocumented: featureFlagDefaultOffDocumented ?? this.featureFlagDefaultOffDocumented,
      noDefaultRuntimeEnablement: noDefaultRuntimeEnablement ?? this.noDefaultRuntimeEnablement,
      runtimeClasspathIsolationDocumented: runtimeClasspathIsolationDocumented ?? this.runtimeClasspathIsolationDocumented,
      fallbackPlanDocumented: fallbackPlanDocumented ?? this.fallbackPlanDocumented,
      formulaOcrPrimaryOnly: formulaOcrPrimaryOnly ?? this.formulaOcrPrimaryOnly,
      editableMathLiveReviewRequired: editableMathLiveReviewRequired ?? this.editableMathLiveReviewRequired,
      userApprovalRequiredBeforeWorkspaceImport: userApprovalRequiredBeforeWorkspaceImport ?? this.userApprovalRequiredBeforeWorkspaceImport,
      directSolveBlocked: directSolveBlocked ?? this.directSolveBlocked,
      directGraphSolutionHistoryBlocked: directGraphSolutionHistoryBlocked ?? this.directGraphSolutionHistoryBlocked,
      noPaddleRuntimeDependencyAdded: noPaddleRuntimeDependencyAdded ?? this.noPaddleRuntimeDependencyAdded,
      noPaddleOcrDependencyAdded: noPaddleOcrDependencyAdded ?? this.noPaddleOcrDependencyAdded,
      noNativeBridgeAdded: noNativeBridgeAdded ?? this.noNativeBridgeAdded,
      noJniBindingAdded: noJniBindingAdded ?? this.noJniBindingAdded,
      noMethodChannelRuntimeBindingAdded: noMethodChannelRuntimeBindingAdded ?? this.noMethodChannelRuntimeBindingAdded,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp ?? this.noModelBinaryBundledInBaseApp,
      noProductionModelUrlBound: noProductionModelUrlBound ?? this.noProductionModelUrlBound,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented ?? this.noRealNetworkDownloadWorkerImplemented,
      productionDownloadEnabled: productionDownloadEnabled ?? this.productionDownloadEnabled,
      noProductionInferenceAllowed: noProductionInferenceAllowed ?? this.noProductionInferenceAllowed,
      dependencyIsolationPassClaimed: dependencyIsolationPassClaimed ?? this.dependencyIsolationPassClaimed,
      ocrPassClaimed: ocrPassClaimed ?? this.ocrPassClaimed,
      dependencyIsolationLabel: dependencyIsolationLabel ?? this.dependencyIsolationLabel,
    );
  }
}
