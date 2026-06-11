import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('V172-Q277R1 Camera/OCR runtime premium regression log repair', () {
    test('keeps Q250 review draft factory only on GaussMathLiveOcrReviewDraft', () {
      final source = File('lib/features/camera/gauss_mathlive_ocr_review_surface.dart').readAsStringSync();
      const factoryMarker = 'factory GaussMathLiveOcrReviewDraft.fromQ250Import';
      expect(RegExp(RegExp.escape(factoryMarker)).allMatches(source).length, 1);
      const statelessSheetMarker = 'class GaussMathLiveOcrReviewSheet extends StatelessWidget';
      const statefulSheetMarker = 'class GaussMathLiveOcrReviewSheet extends StatefulWidget';
      final statelessSheetPresent = source.contains(statelessSheetMarker);
      final statefulSheetPresent = source.contains(statefulSheetMarker);
      expect(statelessSheetPresent || statefulSheetPresent, isTrue);
      final sheetStart = statelessSheetPresent
          ? source.indexOf(statelessSheetMarker)
          : source.indexOf(statefulSheetMarker);
      final sheetBody = source.substring(sheetStart);
      expect(sheetBody, isNot(contains(factoryMarker)));
      expect(
        source.contains('Gerçek OCR adayı gelmeden workspace aktarımı') ||
            source.contains('OCR adayı henüz hazır değil. Workspace aktarımı, çözüm ve grafik kapalı kalır.') ||
            source.contains('OCR adayı yok: workspace aktarımı, çözüm ve grafik kapalı'),
        isTrue,
      );
    });

    test('historical PP-FormulaNet-S model scans ignore generated Flutter build outputs', () {
      const repairedTests = <String>[
        'test/v172_q252_camera_ocr_premium_final_regression_test.dart',
        'test/v172_q254_pp_formulanet_s_runtime_source_evidence_test.dart',
        'test/v172_q256_pp_formulanet_s_artifact_manifest_sha_lock_test.dart',
        'test/v172_q257_pp_formulanet_s_download_orchestrator_ui_guard_test.dart',
        'test/v172_q258_pp_formulanet_s_production_artifact_resolver_gate_test.dart',
        'test/v172_q259_pp_formulanet_s_real_download_worker_dry_run_test.dart',
        'test/v172_q260_pp_formulanet_s_real_model_download_integration_gate_test.dart',
        'test/v172_q261_pp_formulanet_s_runtime_feasibility_adapter_test.dart',
        'test/v172_q262_pp_formulanet_s_runtime_prototype_bridge_gate_test.dart',
        'test/v172_q263_pp_formulanet_s_runtime_prototype_smoke_evidence_template_test.dart',
      ];

      for (final testPath in repairedTests) {
        final source = File(testPath).readAsStringSync();
        expect(source, contains("file.path.replaceAll('\\\\', '/')"), reason: testPath);
        expect(source, contains("!normalizedPath.contains('/build/')"), reason: testPath);
        expect(source, contains("!normalizedPath.contains('/.dart_tool/')"), reason: testPath);
      }
    });

    test('does not add real OCR/runtime dependencies or bundled model artifacts', () {
      final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
      for (final forbidden in <String>[
        'paddleocr',
        'paddle_ocr',
        'paddle_flutter',
        'paddle_lite',
        'onnxruntime',
        'tesseract',
        'flutter_downloader',
        'background_downloader',
      ]) {
        expect(pubspec, isNot(contains(forbidden)), reason: forbidden);
      }
      expect(pubspec, contains('camera: 0.10.6'));
      expect(pubspec, contains('camera_android: 0.10.9+3'));
      expect(pubspec, isNot(contains('camera_android_camerax')));

      final forbiddenModelExtensions = RegExp(
        r'\.(onnx|tflite|pt|pth|pdmodel|pdiparams|pdparams|safetensors|bin)$',
        caseSensitive: false,
      );
      final modelFiles = Directory.current
          .listSync(recursive: true)
          .whereType<File>()
          .where((file) {
            final normalizedPath = file.path.replaceAll('\\', '/');
            return !normalizedPath.contains('/build/') &&
                !normalizedPath.contains('/.dart_tool/') &&
                !normalizedPath.contains('/.gradle/');
          })
          .where((file) => forbiddenModelExtensions.hasMatch(file.path))
          .toList();
      expect(modelFiles, isEmpty);
    });
  });
}
