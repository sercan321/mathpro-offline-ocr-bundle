import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'v172_q389r6w_onnx_runtime_successor_test_helper.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_review_approved_import_contract_q360.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_ocr_review_approved_import_contract_q360_policy.dart';

void main() {
  test('q360 prepares editable review and approved import contract without direct OCR import', () {
    final manifest = jsonDecode(File('assets/mathlive/manifest.json').readAsStringSync()) as Map<String, dynamic>;
    final q360 = manifest['v172Q360OcrReviewApprovedImportContract'] as Map<String, dynamic>;

    expect(<String>[GaussOcrReviewApprovedImportContractQ360Policy.phase, 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['cameraOcrLatestPhase']));
    expect(<String>[GaussOcrReviewApprovedImportContractQ360Policy.phase, 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE', 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'], contains(manifest['activeProductDevelopmentLatestPhase']));
    expect(manifest['ocrReviewApprovedImportContractLatestPhase'], GaussOcrReviewApprovedImportContractQ360Policy.phase);
    expect(q360['phase'], GaussOcrReviewApprovedImportContractQ360Policy.phase);
    expect(q360['sourcePhase'], GaussOcrReviewApprovedImportContractQ360Policy.sourcePhase);
    expect(q360['selectedDependencyCoordinate'], GaussOcrReviewApprovedImportContractQ360Policy.selectedDependencyCoordinate);
    expect(q360['reviewContractPrepared'], isTrue);
    expect(q360['approvedImportContractPrepared'], isTrue);
    expect(q360['requiresCandidateEnvelope'], isTrue);
    expect(q360['requiresEditableMathLiveReviewBeforeImport'], isTrue);
    expect(q360['requiresExplicitUserApprovalBeforeWorkspaceImport'], isTrue);
    expect(q360['directOcrToWorkspaceImportBlocked'], isTrue);
    expect(q360['directOcrToSolveBlocked'], isTrue);
    expect(q360['directOcrToGraphBlocked'], isTrue);
    expect(q360['directOcrToSolutionBlocked'], isTrue);
    expect(q360['directOcrToHistoryBlocked'], isTrue);
    expect(q360['rejectsEmptyCandidateLatex'], isTrue);
    expect(q360['rejectsUnreviewedCandidateLatex'], isTrue);
    expect(q360['rejectsUnapprovedImport'], isTrue);
    expect(q360['reviewUiAutoOpened'], isFalse);
    expect(q360['workspaceImportExecuted'], isFalse);
    expect(q360['solveGraphSolutionHistoryTouched'], isFalse);
    expect(q360['ocrReviewPassClaimedByPackage'], isFalse);
    expect(q360['workspaceImportPassClaimedByPackage'], isFalse);
    expect(q360['ocrPassClaimed'], isFalse);

    final result = GaussOcrReviewApprovedImportContractQ360.evaluate();
    expect(result.phase, GaussOcrReviewApprovedImportContractQ360Policy.phase);
    expect(result.reviewContractPrepared, isTrue);
    expect(result.approvedImportContractPrepared, isTrue);
    expect(result.requiresEditableMathLiveReviewBeforeImport, isTrue);
    expect(result.requiresExplicitUserApprovalBeforeWorkspaceImport, isTrue);
    expect(result.directOcrToWorkspaceImportBlocked, isTrue);
    expect(result.directOcrToSolveBlocked, isTrue);
    expect(result.directOcrToGraphBlocked, isTrue);
    expect(result.directOcrToSolutionBlocked, isTrue);
    expect(result.directOcrToHistoryBlocked, isTrue);
    expect(result.reviewUiAutoOpened, isFalse);
    expect(result.workspaceImportExecuted, isFalse);
    expect(result.ocrPassClaimed, isFalse);
  });

  test('q360 does not touch native runtime, UI, model artifacts, or build files', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expectQ389R6WOnnxRuntimeDependencySurface(buildGradle);
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(androidManifest, isNot(contains('ONNX')));
    expect(mainActivity, contains('private val q359FeatureEnabled = false'));
    expect(mainActivity, contains('private val q361FeatureEnabled = false'));
    expect(mainActivity, contains('cameraOcrRuntimeExecutionBridge'));
    expect(mainActivity, isNot(contains('ocrReviewApprovedImport')));

    final modelArtifacts = Directory.current
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .map((file) => file.path.replaceAll('\\', '/'))
        .where((path) => !path.startsWith('build/') && !path.contains('/build/'))
        .where((path) => !path.startsWith('.dart_tool/') && !path.contains('/.dart_tool/'))
        .where((path) => !path.startsWith('docs/evidence/'))
        .where((path) => RegExp(r'\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$', caseSensitive: false).hasMatch(path))
        .toList();
    expect(modelArtifacts, isEmpty);
  });
}
