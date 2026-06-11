import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_runtime_premium_regression.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_runtime_premium_regression_policy.dart';

void main() {
  group('V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION', () {
    const validInput = GaussCameraOcrRuntimePremiumRegressionInput(
      q276CameraOcrRealEndToEndDeviceCourtPresent: true,
      keyboardLayoutStable: true,
      moreTemplateTrayStable: true,
      longPressListsStable: true,
      mathLiveProductionRouteStable: true,
      legacyFlutterCursorRouteAbsent: true,
      graphSurfaceStable: true,
      solutionSurfaceStable: true,
      historySurfaceStable: true,
      cameraShellRuntimeStable: true,
      editableMathLiveReviewRequired: true,
      explicitUserApprovalRequiredBeforeWorkspaceImport: true,
      autoEvaluateAfterImport: false,
      autoSolveAfterImport: false,
      autoGraphAfterImport: false,
      autoSolutionAfterImport: false,
      autoHistoryAfterImport: false,
      directCameraSolveBlocked: true,
      directCameraGraphSolutionHistoryBlocked: true,
      realOcrRuntimeAdded: false,
      paddleRuntimeAdded: false,
      paddleOcrDependencyAdded: false,
      nativeBridgeImplementationAdded: false,
      jniBindingAdded: false,
      methodChannelRuntimeBindingAdded: false,
      modelBinaryBundledInBaseApp: false,
      productionModelUrlBound: false,
      realNetworkDownloadWorkerImplemented: false,
      productionDownloadEnabled: false,
      productionInferenceAllowed: false,
      realImageToLatexInferenceExecuted: false,
      cameraPassClaimed: false,
      cameraOcrRuntimePassClaimed: false,
      ocrPassClaimed: false,
      premiumFinalPassClaimed: false,
      releasePassClaimed: false,
    );

    test('keeps Q277 as a premium regression guard without real OCR runtime claims', () {
      final result = GaussCameraOcrRuntimePremiumRegression.evaluate(validInput);
      expect(result.decision, GaussCameraOcrRuntimePremiumRegressionDecision.readyForFutureRuntimePremiumRegressionOnly);
      expect(result.staticReadyForFutureRegressionOnly, isTrue);
      expect(result.phase, GaussCameraOcrRuntimePremiumRegressionPolicy.phase);
      expect(result.sourcePhase, GaussCameraOcrRuntimePremiumRegressionPolicy.sourcePhase);
      expect(result.selectedEngineLabel, 'PP-FormulaNet-S');
      expect(result.regressionMode, contains('guard-only'));
      expect(result.protectedRuntimeSurfaces, contains('lib/features/keyboard/key_config.dart'));
      expect(result.protectedRuntimeSurfaces, contains('assets/mathlive/mathlive_prod_bridge.js'));
      expect(result.protectedRuntimeSurfaces, contains('lib/features/graph/graph_card.dart'));
      expect(result.requiredRegressionGates, contains('legacyFlutterCursorRouteNotReintroduced'));
      expect(result.requiredRegressionGates, contains('noRealImageToLatexInferenceInQ277'));
      expect(result.blockedUntilRealEvidence, contains('realFlutterRunLog'));
      expect(result.forbiddenActions, contains('claimOcrPassWithoutRealInferenceEvidence'));
      expect(result.realOcrRuntimeAdded, isFalse);
      expect(result.paddleRuntimeAdded, isFalse);
      expect(result.paddleOcrDependencyAdded, isFalse);
      expect(result.productionInferenceAllowed, isFalse);
      expect(result.cameraOcrRuntimePassClaimed, isFalse);
      expect(result.ocrPassClaimed, isFalse);
      expect(result.premiumFinalPassClaimed, isFalse);
      expect(result.releasePassClaimed, isFalse);
    });

    test('blocks regressions that would bypass review or auto-solve camera output', () {
      final result = GaussCameraOcrRuntimePremiumRegression.evaluate(const GaussCameraOcrRuntimePremiumRegressionInput(
        q276CameraOcrRealEndToEndDeviceCourtPresent: true,
        keyboardLayoutStable: true,
        moreTemplateTrayStable: true,
        longPressListsStable: true,
        mathLiveProductionRouteStable: true,
        legacyFlutterCursorRouteAbsent: true,
        graphSurfaceStable: true,
        solutionSurfaceStable: true,
        historySurfaceStable: true,
        cameraShellRuntimeStable: true,
        editableMathLiveReviewRequired: true,
        explicitUserApprovalRequiredBeforeWorkspaceImport: true,
        autoEvaluateAfterImport: false,
        autoSolveAfterImport: true,
        autoGraphAfterImport: false,
        autoSolutionAfterImport: false,
        autoHistoryAfterImport: false,
        directCameraSolveBlocked: true,
        directCameraGraphSolutionHistoryBlocked: true,
        realOcrRuntimeAdded: false,
        paddleRuntimeAdded: false,
        paddleOcrDependencyAdded: false,
        nativeBridgeImplementationAdded: false,
        jniBindingAdded: false,
        methodChannelRuntimeBindingAdded: false,
        modelBinaryBundledInBaseApp: false,
        productionModelUrlBound: false,
        realNetworkDownloadWorkerImplemented: false,
        productionDownloadEnabled: false,
        productionInferenceAllowed: false,
        realImageToLatexInferenceExecuted: false,
        cameraPassClaimed: false,
        cameraOcrRuntimePassClaimed: false,
        ocrPassClaimed: false,
        premiumFinalPassClaimed: false,
        releasePassClaimed: false,
      ));
      expect(result.decision, GaussCameraOcrRuntimePremiumRegressionDecision.blockedDirectAutoActionRisk);
    });

    test('does not add runtime dependencies, bundled models, or fake PASS markers', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      expect(pubspec, isNot(contains(RegExp(r'^\s*paddle', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*onnxruntime\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*google_mlkit_text_recognition\s*:', multiLine: true))));
      expect(pubspec, isNot(contains(RegExp(r'^\s*tesseract\s*:', multiLine: true))));
      final manifest = File('assets/mathlive/manifest.json').readAsStringSync();
      expect(manifest, contains('V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION'));
      expect(manifest, contains('cameraOcrRuntimePassClaimed'));
      expect(manifest, contains('legacyFlutterCursorRouteNotReintroduced'));
    });
  });
}
