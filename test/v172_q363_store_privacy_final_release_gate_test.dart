import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_store_privacy_final_release_gate_q363_policy.dart';

void main() {
  test('q363 prepares store privacy final release gate without release pass claim', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q363 = manifest['v172Q363StorePrivacyFinalReleaseGate'] as Map<String, dynamic>;

    expect(manifest['cameraOcrLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['activeProductDevelopmentLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['storePrivacyFinalReleaseGateLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(manifest['accuracyPerformanceMultideviceQaGuardLatestPhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.sourcePhase);
    expect(q363['phase'], GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(q363['sourcePhase'], GaussStorePrivacyFinalReleaseGateQ363Policy.sourcePhase);
    expect(q363['status'], GaussStorePrivacyFinalReleaseGateQ363Policy.status);
    expect(q363['storePrivacyGatePrepared'], isTrue);
    expect(q363['dataSafetyGatePrepared'], isTrue);
    expect(q363['finalReleaseGatePrepared'], isTrue);
    expect(q363['cameraPermissionDisclosureRequired'], isTrue);
    expect(q363['offlineOcrDisclosureRequired'], isTrue);
    expect(q363['privateModelStorageDisclosureRequired'], isTrue);
    expect(q363['modelStorageCleanupPolicyRequired'], isTrue);
    expect(q363['requiresRealDeviceFlutterEvidenceBeforeRelease'], isTrue);
    expect(q363['requiresOnnxRuntimeEvidenceBeforeRelease'], isTrue);
    expect(q363['requiresModelLoadEvidenceBeforeRelease'], isTrue);
    expect(q363['requiresDummyCallEvidenceBeforeRelease'], isTrue);
    expect(q363['requiresImageToLatexEvidenceBeforeRelease'], isTrue);
    expect(q363['requiresEditableMathLiveReviewEvidenceBeforeRelease'], isTrue);
    expect(q363['requiresApprovedWorkspaceImportEvidenceBeforeRelease'], isTrue);
    expect(q363['requiresAccuracyPerformanceMultideviceEvidenceBeforeRelease'], isTrue);
    expect(q363['requiresEditableMathLiveReviewBeforeImport'], isTrue);
    expect(q363['requiresExplicitUserApprovalBeforeWorkspaceImport'], isTrue);
    expect(q363['directOcrToWorkspaceImportBlocked'], isTrue);
    expect(q363['directOcrToSolveGraphSolutionHistoryBlocked'], isTrue);
    expect(q363['featureFlagDefaultEnabled'], isFalse);
    expect(q363['runtimeAutoExecutionBlocked'], isTrue);
    expect(q363['storeReadyPassClaimed'], isFalse);
    expect(q363['privacyDataSafetyPassClaimed'], isFalse);
    expect(q363['finalReleasePassClaimed'], isFalse);
    expect(q363['ocrPassClaimed'], isFalse);

    final result = GaussStorePrivacyFinalReleaseGateQ363.evaluate();
    expect(result.phase, GaussStorePrivacyFinalReleaseGateQ363Policy.phase);
    expect(result.storePrivacyGatePrepared, isTrue);
    expect(result.finalReleaseGatePrepared, isTrue);
    expect(result.requiresRealDeviceFlutterEvidenceBeforeRelease, isTrue);
    expect(result.storeReadyPassClaimed, isFalse);
    expect(result.finalReleasePassClaimed, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });
}
