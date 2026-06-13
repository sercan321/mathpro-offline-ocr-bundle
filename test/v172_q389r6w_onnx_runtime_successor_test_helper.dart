import 'package:flutter_test/flutter_test.dart';

const String q389R6WOnnxRuntimeMobileIntegrationPhase =
    'V172-Q389R6W-ONNX-RUNTIME-MOBILE-INTEGRATION-ADAPTED-FROM-UI';

bool q389R6WAllowsOnnxRuntimeDependency(String buildGradle) {
  final lower = buildGradle.toLowerCase();
  return lower.contains('v172-q389r6b') ||
      lower.contains('q389r6w') ||
      lower.contains('pp-formulanet_plus-s .onnx stays user-downloaded/app-private');
}

void expectQ389R6WOnnxRuntimeDependencySurface(String buildGradle) {
  final lower = buildGradle.toLowerCase();
  if (q389R6WAllowsOnnxRuntimeDependency(buildGradle)) {
    expect(lower, contains('onnxruntime-android'));
    expect(lower, contains('com.microsoft.onnxruntime'));
    expect(lower, contains('pp-formulanet_plus-s .onnx stays user-downloaded/app-private'));
    return;
  }
  expect(lower, isNot(contains('onnxruntime-android')));
  expect(lower, isNot(contains('com.microsoft.onnxruntime')));
}
