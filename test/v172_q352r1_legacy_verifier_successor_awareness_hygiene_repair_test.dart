import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'v172_q389r6w_onnx_runtime_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_legacy_verifier_successor_awareness_hygiene_repair_q352r1.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_legacy_verifier_successor_awareness_hygiene_repair_q352r1_policy.dart';

import 'v172_q344_binary_bundle_successor_test_helper.dart';

void main() {
  test('q352r1 records verifier hygiene repair without advancing Q352 runtime state', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q352r1 = manifest['v172Q352R1LegacyVerifierSuccessorAwarenessHygieneRepair'] as Map<String, dynamic>;

    expect(manifest['legacyVerifierSuccessorAwarenessHygieneRepairLatestPhase'],
        GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy.phase);
    expect(<String>[GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy.sourcePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, q356OnnxRealModelLoadSmokeEvidenceBlockedPhase, q356R1OnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardPhase, q356R2OnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardPhase, q357OnnxRealModelLoadSmokeBridgePreflightExecutionPhase, q358OnnxDummyInputRuntimeCallGuardPreflightPhase, q359FirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightPhase, q360OcrReviewApprovedImportContractPhase, q361CameraOcrRuntimeExecutionBridgePhase, q362AccuracyPerformanceMultideviceQaGuardPhase, q363StorePrivacyFinalReleaseGatePhase], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy.sourcePhase, q353OnnxRuntimeMobileDependencyFeasibilityGatePhase, q354OnnxRuntimeAndroidDependencyAbiBuildTrialPhase, q355OnnxModelPrivateStorageShaVerificationPhase, q356OnnxRealModelLoadSmokeEvidenceBlockedPhase, q356R1OnnxRuntimeAndroidBuildEvidenceIntakeModelLoadUnlockGuardPhase, q356R2OnnxRuntimeAndroidMissingBuildEvidenceQ357LockGuardPhase, q357OnnxRealModelLoadSmokeBridgePreflightExecutionPhase, q358OnnxDummyInputRuntimeCallGuardPreflightPhase, q359FirstRealImageToLatexInferenceGuardCandidateEnvelopePreflightPhase, q360OcrReviewApprovedImportContractPhase, q361CameraOcrRuntimeExecutionBridgePhase, q362AccuracyPerformanceMultideviceQaGuardPhase, q363StorePrivacyFinalReleaseGatePhase], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(q352r1['phase'], GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy.phase);
    expect(q352r1['sourcePhase'], GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy.sourcePhase);
    expect(q352r1['legacyQ336ToQ343VerifiersAcceptQ352'], isTrue);
    expect(q352r1['cameraOcrLatestPhaseAdvanced'], isFalse);
    expect(q352r1['activeProductDevelopmentLatestPhaseAdvanced'], isFalse);
    expect(q352r1['onnxRuntimeDependencyAdded'], isFalse);
    expect(q352r1['onnxModelBundledIntoFlutterProject'], isFalse);
    expect(q352r1['onnxModelLoadAttempted'], isFalse);
    expect(q352r1['realImageToLatexInferenceExecuted'], isFalse);
    expect(q352r1['editableMathLiveReviewOpened'], isFalse);
    expect(q352r1['workspaceImportExecuted'], isFalse);
    expect(q352r1['ocrPassClaimed'], isFalse);
  });

  test('q352r1 Dart contract remains hygiene-only', () {
    final result = GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1.evaluate();

    expect(result.phase, GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy.phase);
    expect(result.sourcePhase, GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy.sourcePhase);
    expect(result.legacyQ336ToQ343VerifiersAcceptQ352, isTrue);
    expect(result.q344ApprovedBinaryAllowancePreserved, isTrue);
    expect(result.onnxRuntimeDependencyAdded, isFalse);
    expect(result.onnxModelBundledIntoFlutterProject, isFalse);
    expect(result.onnxModelLoadAttempted, isFalse);
    expect(result.realImageToLatexInferenceExecuted, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.uiRuntimeChanged, isFalse);
    expect(result.mainActivityChanged, isFalse);
    expect(result.gradleChanged, isFalse);
    expect(result.pubspecChanged, isFalse);
    expect(result.androidManifestChanged, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q352r1 patched legacy verifier files explicitly accept Q352', () {
    for (final rel in GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy.repairedVerifierFiles) {
      final text = File(rel).readAsStringSync();
      expect(text, contains(GaussLegacyVerifierSuccessorAwarenessHygieneRepairQ352R1Policy.sourcePhase), reason: rel);
    }

    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    if (<String>{'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL', 'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION', 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED', 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD', 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD', 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION', 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT', 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT', 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'}.contains(manifest['cameraOcrLatestPhase'])) {
      expectQ389R6WOnnxRuntimeDependencySurface(buildGradle);
    } else {
      expect(buildGradle.toLowerCase(), isNot(contains('onnxruntime')));
    }
    final pubspecRuntimeSection = pubspec
        .split('\n')
        .where((line) => !line.trimLeft().startsWith('#'))
        .join('\n')
        .toLowerCase();
    expect(pubspecRuntimeSection, isNot(contains('onnxruntime')));
    expect(pubspecRuntimeSection, isNot(contains('onnxruntime-android')));
    expect(pubspecRuntimeSection, isNot(contains('onnx:')));
    expect(androidManifest, isNot(contains('ONNX')));
  });
}
