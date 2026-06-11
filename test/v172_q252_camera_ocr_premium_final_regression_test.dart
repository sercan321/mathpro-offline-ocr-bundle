import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_math_ocr_end_to_end_court_policy.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_premium_final_regression.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_premium_final_regression_policy.dart';

// Q252 dependency sentinels: camera: 0.10.6, camera_android: 0.10.9+3
void main() {
  group('V172-Q252 Camera/OCR premium final regression', () {
    const readyInput = GaussCameraOcrPremiumFinalRegressionInput(
      q251CourtPhase: GaussCameraMathOcrEndToEndCourtPolicy.phase,
      q245ThroughQ251StaticChainVerified: true,
      protectedSurfaceHashesUnchanged: true,
      cameraDependencyLinePreserved: true,
      noModelBinaryBundledInBaseApp: true,
      noPaddleRuntimeDependency: true,
      noProductionModelUrl: true,
      noDirectWorkspaceImportFromCamera: true,
      noDirectSolveGraphSolutionHistoryFromCamera: true,
      mathLiveReviewAndUserApprovalRequired: true,
      noRealOcrPassClaimed: true,
      androidToolchainDeferredToQ253: true,
      evidenceLabel: 'q252-static-premium-final-regression',
    );

    test('records Q252 as premium final regression closure, not real OCR PASS', () {
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.phase, 'V172-Q252-CAMERA-OCR-PREMIUM-FINAL-REGRESSION');
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.closesOverPhase, 'V172-Q251-CAMERA-MATH-OCR-END-TO-END-COURT');
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.q245RealDeviceEvidenceClosureRequired, isTrue);
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.q251EndToEndCourtRequired, isTrue);
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.editableMathLiveReviewRequired, isTrue);
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.userApprovalRequiredBeforeWorkspaceImport, isTrue);
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.directWorkspaceImportAllowed, isFalse);
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.directSolveFromCameraAllowed, isFalse);
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussCameraOcrPremiumFinalRegressionPolicy.premiumFinalPassClaimedByAssistant, isFalse);
      expect(GaussCameraOcrPremiumFinalRegression.realInferenceEnabledInQ252, isFalse);
      expect(GaussCameraOcrPremiumFinalRegression.callsProductionMathLiveBridge, isFalse);
    });

    test('passes final static regression only when the full Q245-Q251 safety chain is intact', () {
      final result = GaussCameraOcrPremiumFinalRegression.evaluate(readyInput);

      expect(result.decision, GaussCameraOcrPremiumFinalRegressionDecision.premiumFinalRegressionStaticReady);
      expect(result.premiumFinalRegressionStaticReady, isTrue);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.directWorkspaceImportAllowed, isFalse);
      expect(result.directSolveAllowed, isFalse);
      expect(result.directGraphAllowed, isFalse);
      expect(result.directSolutionAllowed, isFalse);
      expect(result.directHistoryAllowed, isFalse);
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.modelBinaryBundledInBaseApp, isFalse);
      expect(result.canClaimRealOcrPass, isFalse);
      expect(result.canImportCameraOutputWithoutUserApproval, isFalse);
      expect(result.canEvaluateCameraOutputBeforeReviewApproval, isFalse);
      expect(result.canGraphCameraOutputBeforeReviewApproval, isFalse);
      expect(result.canWriteSolutionOrHistoryBeforeReviewApproval, isFalse);
    });

    test('blocks protected-surface, model-bundle, direct-action, and fake-pass regressions', () {
      final protectedBlocked = GaussCameraOcrPremiumFinalRegression.evaluate(
        const GaussCameraOcrPremiumFinalRegressionInput(
          q251CourtPhase: GaussCameraMathOcrEndToEndCourtPolicy.phase,
          q245ThroughQ251StaticChainVerified: true,
          protectedSurfaceHashesUnchanged: false,
          cameraDependencyLinePreserved: true,
          noModelBinaryBundledInBaseApp: true,
          noPaddleRuntimeDependency: true,
          noProductionModelUrl: true,
          noDirectWorkspaceImportFromCamera: true,
          noDirectSolveGraphSolutionHistoryFromCamera: true,
          mathLiveReviewAndUserApprovalRequired: true,
          noRealOcrPassClaimed: true,
          androidToolchainDeferredToQ253: true,
          evidenceLabel: 'q252-protected-block',
        ),
      );
      expect(protectedBlocked.decision, GaussCameraOcrPremiumFinalRegressionDecision.blockedProtectedSurfaceRegression);

      final modelBlocked = GaussCameraOcrPremiumFinalRegression.evaluate(
        const GaussCameraOcrPremiumFinalRegressionInput(
          q251CourtPhase: GaussCameraMathOcrEndToEndCourtPolicy.phase,
          q245ThroughQ251StaticChainVerified: true,
          protectedSurfaceHashesUnchanged: true,
          cameraDependencyLinePreserved: true,
          noModelBinaryBundledInBaseApp: false,
          noPaddleRuntimeDependency: true,
          noProductionModelUrl: true,
          noDirectWorkspaceImportFromCamera: true,
          noDirectSolveGraphSolutionHistoryFromCamera: true,
          mathLiveReviewAndUserApprovalRequired: true,
          noRealOcrPassClaimed: true,
          androidToolchainDeferredToQ253: true,
          evidenceLabel: 'q252-model-block',
        ),
      );
      expect(modelBlocked.decision, GaussCameraOcrPremiumFinalRegressionDecision.blockedModelBundlingRegression);

      final directActionBlocked = GaussCameraOcrPremiumFinalRegression.evaluate(
        const GaussCameraOcrPremiumFinalRegressionInput(
          q251CourtPhase: GaussCameraMathOcrEndToEndCourtPolicy.phase,
          q245ThroughQ251StaticChainVerified: true,
          protectedSurfaceHashesUnchanged: true,
          cameraDependencyLinePreserved: true,
          noModelBinaryBundledInBaseApp: true,
          noPaddleRuntimeDependency: true,
          noProductionModelUrl: true,
          noDirectWorkspaceImportFromCamera: false,
          noDirectSolveGraphSolutionHistoryFromCamera: true,
          mathLiveReviewAndUserApprovalRequired: true,
          noRealOcrPassClaimed: true,
          androidToolchainDeferredToQ253: true,
          evidenceLabel: 'q252-direct-block',
        ),
      );
      expect(directActionBlocked.decision, GaussCameraOcrPremiumFinalRegressionDecision.blockedDirectCameraActionRegression);

      final fakePassBlocked = GaussCameraOcrPremiumFinalRegression.evaluate(
        const GaussCameraOcrPremiumFinalRegressionInput(
          q251CourtPhase: GaussCameraMathOcrEndToEndCourtPolicy.phase,
          q245ThroughQ251StaticChainVerified: true,
          protectedSurfaceHashesUnchanged: true,
          cameraDependencyLinePreserved: true,
          noModelBinaryBundledInBaseApp: true,
          noPaddleRuntimeDependency: true,
          noProductionModelUrl: true,
          noDirectWorkspaceImportFromCamera: true,
          noDirectSolveGraphSolutionHistoryFromCamera: true,
          mathLiveReviewAndUserApprovalRequired: true,
          noRealOcrPassClaimed: false,
          androidToolchainDeferredToQ253: true,
          evidenceLabel: 'q252-fake-pass-block',
        ),
      );
      expect(fakePassBlocked.decision, GaussCameraOcrPremiumFinalRegressionDecision.blockedFakePassClaimRegression);
    });

    test('keeps dependencies, Android toolchain, model bundle, and active runtime surfaces untouched', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final settings = File('android/settings.gradle').readAsStringSync();
      final manifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();
      final bridge = File('assets/mathlive/mathlive_prod_bridge.js').readAsStringSync();
      final workspace = File('lib/features/workspace/workspace_panel.dart').readAsStringSync();
      final appShell = File('lib/app/app_shell.dart').readAsStringSync();

      expect(pubspec, contains(RegExp(r'^\s*camera\s*:\s*0\.10\.6\s*$', multiLine: true)));
      expect(pubspec, contains(RegExp(r'^\s*camera_android\s*:\s*0\.10\.9\+3\s*$', multiLine: true)));
      expect(pubspec, isNot(contains('camera_android_camerax')));
      expect(pubspec, isNot(contains('google_mlkit_text_recognition')));
      expect(pubspec, isNot(contains('paddleocr')));
      expect(pubspec, isNot(contains('onnxruntime')));
      expect(pubspec, isNot(contains('flutter_downloader')));
      expect(settings, contains("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false"));
      expect(
        settings.contains("id 'com.android.application' version '8.3.2' apply false") ||
            settings.contains("id 'com.android.application' version '8.6.1' apply false"),
        isTrue,
      );
      expect(manifest, contains('android.permission.CAMERA'));
      expect(manifest, isNot(contains('READ_MEDIA_IMAGES')));
      expect(bridge, isNot(contains('runPpFormulaNetSInference')));
      expect(bridge, isNot(contains('FormulaRecognition(')));
      expect(workspace, isNot(contains('setWorkspaceLatexWithoutUserApproval')));
      expect(appShell, isNot(contains('evaluateFromCamera')));

      final forbiddenModelExtensions = RegExp(r'\.(onnx|tflite|pt|pth|pdmodel|pdiparams|bin)$', caseSensitive: false);
      final modelFiles = Directory.current
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) {
            final normalizedPath = file.path.replaceAll('\\', '/');
            return !normalizedPath.contains('/build/') && !normalizedPath.contains('/.dart_tool/');
          })
          .where((file) => forbiddenModelExtensions.hasMatch(file.path))
          .toList();
      expect(modelFiles, isEmpty);
    });
  });
}
