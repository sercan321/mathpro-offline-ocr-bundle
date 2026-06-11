import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Q387R7E keeps Q348-Q350 legacy .nb checks successor-aware', () {
    final legacyTests = <String>[
      'test/v172_q348_optimized_model_conversion_model_loader_evidence_gate_test.dart',
      'test/v172_q349_real_model_load_smoke_evidence_blocked_test.dart',
      'test/v172_q350_optimized_model_artifact_conversion_evidence_intake_test.dart',
    ].map((path) => File(path).readAsStringSync()).join('\n---\n');

    expect(
      legacyTests,
      isNot(contains("expect(mainActivity, isNot(contains('.nb')));\n    expect(gradle")),
    );
    expect(legacyTests, contains("mainActivity.contains('.nb')"));
    expect(legacyTests, contains('q387RequiredModelFileExtension'));
    expect(legacyTests, contains('q387R1NbArtifactReady'));
    expect(legacyTests, contains('q387-paddle-lite-nb-model-required'));
  });

  test('Q387R7E still forbids bundled model artifacts in the project tree', () {
    final projectRoot = Directory.current.path.replaceAll('\\', '/');
    final modelArtifacts = Directory.current
        .listSync(recursive: true, followLinks: false)
        .whereType<File>()
        .map((file) {
          final normalized = file.path.replaceAll('\\', '/');
          return normalized.startsWith('$projectRoot/') ? normalized.substring(projectRoot.length + 1) : normalized;
        })
        .where((path) => !path.startsWith('build/') && !path.contains('/build/'))
        .where((path) => !path.startsWith('.dart_tool/') && !path.contains('/.dart_tool/'))
        .where((path) => !path.startsWith('docs/evidence/'))
        .where((path) => RegExp(r'\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$', caseSensitive: false).hasMatch(path))
        .toList();

    expect(modelArtifacts, isEmpty);
  });
}

