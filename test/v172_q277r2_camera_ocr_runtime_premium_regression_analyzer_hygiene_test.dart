import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mathpro_flutter_phase17/features/camera/gauss_camera_ocr_runtime_premium_regression_analyzer_hygiene_policy.dart';

void main() {
  group('V172-Q277R2 Camera/OCR runtime premium regression analyzer hygiene', () {
    test('records the real-log analyzer hygiene repair without adding OCR runtime', () {
      expect(
        GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.phase,
        'V172-Q277R2-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-ANALYZER-HYGIENE',
      );
      expect(
        GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.sourcePhase,
        'V172-Q277R1-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-FLUTTER-LOG-REPAIR',
      );
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.userFlutterTestPassed, isTrue);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.userFlutterTestPassingCount, 1120);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.userFlutterAnalyzeRemainingInfoCount, 1);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.analyzerUnnecessaryConstCleaned, isTrue);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.protectedRuntimeSurfacesUnchanged, isTrue);

      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.realOcrRuntimeAdded, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.paddleRuntimeAdded, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.paddleOcrDependencyAdded, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.nativeBridgeImplementationAdded, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.methodChannelRuntimeBindingAdded, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.modelBinaryBundledInBaseApp, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.realImageToLatexInferenceExecuted, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.ocrPassClaimed, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.cameraOcrRuntimePassClaimed, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.premiumFinalPassClaimed, isFalse);
      expect(GaussCameraOcrRuntimePremiumRegressionAnalyzerHygienePolicy.releasePassClaimed, isFalse);
    });

    test('removes the Q277R1 unnecessary const pattern from the deferred readiness result', () {
      final source = File('lib/features/camera/gauss_deferred_model_download_runtime.dart').readAsStringSync();

      expect(source, contains('return const GaussDeferredModelReadinessResult('));
      expect(source, contains('issues: <String>[],'));
      expect(source, isNot(contains('issues: const <String>[],')));
    });

    test('keeps red-line surfaces out of the analyzer hygiene phase', () {
      final changed = File('docs/audit/V172_Q277R2_CHANGED_FILES.md').readAsStringSync();

      for (final protectedPath in <String>[
        'lib/features/keyboard/key_config.dart',
        'lib/features/keyboard/math_keyboard.dart',
        'lib/features/keyboard/long_press_popup.dart',
        'lib/features/workspace/template_tray.dart',
        'assets/mathlive/main_editor_prod.html',
        'assets/mathlive/mathlive_prod_bridge.js',
        'lib/features/mathlive/mathlive_production_editor_surface.dart',
        'lib/features/graph/graph_card.dart',
        'lib/features/solution/solution_steps_panel.dart',
        'lib/features/history/history_panel.dart',
        'lib/app/app_shell.dart',
        'lib/main.dart',
        'android/app/src/main/AndroidManifest.xml',
      ]) {
        expect(changed, isNot(contains('- `$protectedPath`')));
      }
    });
  });
}
