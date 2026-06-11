import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_selected_runtime_dependency_trial.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_selected_runtime_dependency_trial_policy.dart';

void main() {
  group('V172-Q279 selected runtime dependency trial behind default-off flag', () {
    const approvedInput = GaussSelectedRuntimeDependencyTrialInput(
      q278EvidenceLockPresent: true,
      officialDependencyCoordinatesDocumented: true,
      pinnedRuntimeDependencyVersionDocumented: true,
      dependencyLicenseCompatible: true,
      transitiveDependencyAuditComplete: true,
      gradleCompatibilityDocumented: true,
      abiPackagingImpactDocumented: true,
      nativeAbiCount: 4,
      apkSizeIncreaseBudgetMb: 24,
      defaultOffFeatureFlagRequired: true,
      featureFlagEnabledByDefault: false,
      runtimeInstantiationBlockedWhenFlagOff: true,
      rollbackPlanDocumented: true,
      editableMathLiveReviewRequired: true,
      explicitUserApprovalRequiredBeforeWorkspaceImport: true,
      directSolveGraphSolutionHistoryBlocked: true,
      noRuntimeDependencyAddedToPubspec: true,
      noGradleNativeRuntimeDependencyAdded: true,
      noNativeBridgeImplementationAdded: true,
      noJniBindingAdded: true,
      noMethodChannelRuntimeBindingAdded: true,
      noModelBinaryBundledInBaseApp: true,
      noProductionModelUrlBound: true,
      noProductionDownloadEnabled: true,
      noRealNetworkDownloadWorkerImplemented: true,
      noImageToLatexInferenceExecuted: true,
      runtimeDependencyTrialPassClaimed: false,
      runtimeIntegrationPassClaimed: false,
      ocrPassClaimed: false,
      releasePassClaimed: false,
      evidenceLabel: 'Q279 static dependency trial gate ready for Q280 bridge planning only',
    );

    test('keeps the selected runtime dependency trial default-off without adding runtime or inference', () {
      final result = GaussSelectedRuntimeDependencyTrial.evaluate(approvedInput);

      expect(result.decision, GaussSelectedRuntimeDependencyTrialDecision.readyForQ280BridgeImplementationGateOnly);
      expect(result.dependencyTrialStaticReady, isTrue);
      expect(result.readyForQ280BridgeImplementationGateOnly, isTrue);
      expect(result.phase, GaussSelectedRuntimeDependencyTrialPolicy.phase);
      expect(result.sourcePhase, GaussSelectedRuntimeDependencyTrialPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.fallbackEngineLabel, 'PP-FormulaNet_plus-L only');
      expect(result.dependencyTrialMode, 'selected-runtime-dependency-trial-default-off-gate-only-no-runtime-no-inference');
      expect(result.requiredDependencyTrialGates, contains('officialDependencyCoordinatesEvidence'));
      expect(result.requiredDependencyTrialGates, contains('defaultOffFeatureFlagRequired'));
      expect(result.requiredDependencyTrialGates, contains('editableMathLiveReviewRequired'));
      expect(result.blockedUntilRealEvidence, contains('officialRuntimeDependencyCoordinates'));
      expect(result.blockedUntilRealEvidence, contains('runtimeInstantiationBlockedWhenFlagOffEvidence'));
      expect(result.forbiddenActions, contains('enableRuntimeFeatureFlagByDefaultInQ279'));
      expect(result.forbiddenActions, contains('runImageToLatexInferenceInQ279'));
      expect(result.runtimeDependencyAddedToPubspec, isFalse);
      expect(result.gradleNativeRuntimeDependencyAdded, isFalse);
      expect(result.featureFlagEnabledByDefault, isFalse);
      expect(result.productionRuntimeInstantiationAllowed, isFalse);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.nativeBridgeImplementationAdded, isFalse);
      expect(result.jniBindingAdded, isFalse);
      expect(result.methodChannelRuntimeBindingAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.productionModelUrlBound, isFalse);
      expect(result.productionDownloadEnabled, isFalse);
      expect(result.realNetworkDownloadWorkerImplemented, isFalse);
      expect(result.realImageToLatexInferenceExecuted, isFalse);
      expect(result.runtimeDependencyTrialPassClaimed, isFalse);
      expect(result.runtimeIntegrationPassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
      expect(result.canEnableRuntimeFlagByDefaultInQ279, isFalse);
      expect(result.canInstantiateRuntimeInQ279, isFalse);
      expect(result.canBindNativeBridgeInQ279, isFalse);
      expect(result.canRunImageToLatexInferenceInQ279, isFalse);
      expect(result.canClaimRuntimeDependencyTrialPassInQ279, isFalse);
      expect(result.canClaimOcrPassInQ279, isFalse);
      expect(result.canImportCameraOutputWithoutReview, isFalse);
    });

    test('blocks missing Q278 evidence, unsafe default-on flags, review bypass, and fake pass claims', () {
      expect(
        GaussSelectedRuntimeDependencyTrial.evaluate(const GaussSelectedRuntimeDependencyTrialInput(
          q278EvidenceLockPresent: false,
          officialDependencyCoordinatesDocumented: true,
          pinnedRuntimeDependencyVersionDocumented: true,
          dependencyLicenseCompatible: true,
          transitiveDependencyAuditComplete: true,
          gradleCompatibilityDocumented: true,
          abiPackagingImpactDocumented: true,
          nativeAbiCount: 4,
          apkSizeIncreaseBudgetMb: 24,
          defaultOffFeatureFlagRequired: true,
          featureFlagEnabledByDefault: false,
          runtimeInstantiationBlockedWhenFlagOff: true,
          rollbackPlanDocumented: true,
          editableMathLiveReviewRequired: true,
          explicitUserApprovalRequiredBeforeWorkspaceImport: true,
          directSolveGraphSolutionHistoryBlocked: true,
          noRuntimeDependencyAddedToPubspec: true,
          noGradleNativeRuntimeDependencyAdded: true,
          noNativeBridgeImplementationAdded: true,
          noJniBindingAdded: true,
          noMethodChannelRuntimeBindingAdded: true,
          noModelBinaryBundledInBaseApp: true,
          noProductionModelUrlBound: true,
          noProductionDownloadEnabled: true,
          noRealNetworkDownloadWorkerImplemented: true,
          noImageToLatexInferenceExecuted: true,
          runtimeDependencyTrialPassClaimed: false,
          runtimeIntegrationPassClaimed: false,
          ocrPassClaimed: false,
          releasePassClaimed: false,
          evidenceLabel: 'missing Q278',
        )).decision,
        GaussSelectedRuntimeDependencyTrialDecision.blockedMissingQ278EvidenceLock,
      );

      expect(
        GaussSelectedRuntimeDependencyTrial.evaluate(approvedInput.copyWithForTest(featureFlagEnabledByDefault: true)).decision,
        GaussSelectedRuntimeDependencyTrialDecision.blockedMissingDefaultOffFlagOrRollback,
      );
      expect(
        GaussSelectedRuntimeDependencyTrial.evaluate(approvedInput.copyWithForTest(editableMathLiveReviewRequired: false)).decision,
        GaussSelectedRuntimeDependencyTrialDecision.blockedMissingReviewApprovalBoundary,
      );
      expect(
        GaussSelectedRuntimeDependencyTrial.evaluate(approvedInput.copyWithForTest(runtimeDependencyTrialPassClaimed: true)).decision,
        GaussSelectedRuntimeDependencyTrialDecision.blockedUnsafeRuntimeMutationOrPassClaim,
      );
    });

    test('package metadata records Q279 without dependency, model, runtime, or download artifacts', () {
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      final readme = File('README.md').readAsStringSync();
      final audit = File('docs/audit/V172_Q279_SELECTED_RUNTIME_DEPENDENCY_TRIAL_AUDIT.md').readAsStringSync();
      final changed = File('docs/audit/V172_Q279_CHANGED_FILES.md').readAsStringSync();
      final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();

      expect(manifest, contains('V172-Q279-SELECTED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG'));
      expect(manifest, contains('selected-runtime-dependency-trial-default-off-gate-only-no-runtime-no-inference'));
      expect(readme, contains('V172-Q279'));
      expect(audit, contains('no Paddle runtime'));
      expect(changed, contains('gauss_selected_runtime_dependency_trial.dart'));
      expect(pubspec, isNot(contains('paddleocr')));
      expect(pubspec, isNot(contains('onnxruntime')));
      expect(pubspec, isNot(contains('flutter_downloader')));
    });
  });
}

extension _Q279InputCopyForTest on GaussSelectedRuntimeDependencyTrialInput {
  GaussSelectedRuntimeDependencyTrialInput copyWithForTest({
    bool? featureFlagEnabledByDefault,
    bool? editableMathLiveReviewRequired,
    bool? runtimeDependencyTrialPassClaimed,
  }) {
    return GaussSelectedRuntimeDependencyTrialInput(
      q278EvidenceLockPresent: q278EvidenceLockPresent,
      officialDependencyCoordinatesDocumented: officialDependencyCoordinatesDocumented,
      pinnedRuntimeDependencyVersionDocumented: pinnedRuntimeDependencyVersionDocumented,
      dependencyLicenseCompatible: dependencyLicenseCompatible,
      transitiveDependencyAuditComplete: transitiveDependencyAuditComplete,
      gradleCompatibilityDocumented: gradleCompatibilityDocumented,
      abiPackagingImpactDocumented: abiPackagingImpactDocumented,
      nativeAbiCount: nativeAbiCount,
      apkSizeIncreaseBudgetMb: apkSizeIncreaseBudgetMb,
      defaultOffFeatureFlagRequired: defaultOffFeatureFlagRequired,
      featureFlagEnabledByDefault: featureFlagEnabledByDefault ?? this.featureFlagEnabledByDefault,
      runtimeInstantiationBlockedWhenFlagOff: runtimeInstantiationBlockedWhenFlagOff,
      rollbackPlanDocumented: rollbackPlanDocumented,
      editableMathLiveReviewRequired: editableMathLiveReviewRequired ?? this.editableMathLiveReviewRequired,
      explicitUserApprovalRequiredBeforeWorkspaceImport: explicitUserApprovalRequiredBeforeWorkspaceImport,
      directSolveGraphSolutionHistoryBlocked: directSolveGraphSolutionHistoryBlocked,
      noRuntimeDependencyAddedToPubspec: noRuntimeDependencyAddedToPubspec,
      noGradleNativeRuntimeDependencyAdded: noGradleNativeRuntimeDependencyAdded,
      noNativeBridgeImplementationAdded: noNativeBridgeImplementationAdded,
      noJniBindingAdded: noJniBindingAdded,
      noMethodChannelRuntimeBindingAdded: noMethodChannelRuntimeBindingAdded,
      noModelBinaryBundledInBaseApp: noModelBinaryBundledInBaseApp,
      noProductionModelUrlBound: noProductionModelUrlBound,
      noProductionDownloadEnabled: noProductionDownloadEnabled,
      noRealNetworkDownloadWorkerImplemented: noRealNetworkDownloadWorkerImplemented,
      noImageToLatexInferenceExecuted: noImageToLatexInferenceExecuted,
      runtimeDependencyTrialPassClaimed: runtimeDependencyTrialPassClaimed ?? this.runtimeDependencyTrialPassClaimed,
      runtimeIntegrationPassClaimed: runtimeIntegrationPassClaimed,
      ocrPassClaimed: ocrPassClaimed,
      releasePassClaimed: releasePassClaimed,
      evidenceLabel: evidenceLabel,
    );
  }
}
