import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('V172-Q384 removes ONNX Runtime from the base APK while preserving download-only OCR contract', () {
    final buildGradle = File('android/app/build.gradle').readAsStringSync();
    final mainActivity = File('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt').readAsStringSync();
    final pubspec = File('pubspec.yaml').readAsStringSync().toLowerCase();
    final androidManifest = File('android/app/src/main/AndroidManifest.xml').readAsStringSync();

    expect(buildGradle, contains("implementation files('libs/PaddlePredictor.jar')"));
    expect(buildGradle.toLowerCase(), isNot(contains('onnxruntime-android')));
    expect(buildGradle.toLowerCase(), isNot(contains('com.microsoft.onnxruntime')));
    expect(pubspec, isNot(contains('onnxruntime')));
    expect(androidManifest, isNot(contains('ONNX')));

    expect(mainActivity, contains('V172-Q384-BASE-APK-OCR-RUNTIME-SLIMMING-DOWNLOAD-ONLY-CONTRACT'));
    expect(mainActivity, contains('ONNX_RUNTIME_REMOVED_FROM_BASE_APK_DOWNLOAD_ONLY_OCR_CONTRACT_ACTIVE'));
    expect(mainActivity, contains('q384OnnxRuntimeBundledInBaseApk = false'));
    expect(mainActivity, contains('q384-download-only-ocr-contract-onnx-runtime-not-bundled'));
    expect(mainActivity, isNot(contains('import ai.onnxruntime')));
    expect(mainActivity, isNot(contains('OrtEnvironment.getEnvironment()')));
    expect(mainActivity, isNot(contains('OrtSession.SessionOptions')));
    expect(mainActivity, isNot(contains('OnnxTensor.createTensor')));
    expect(mainActivity, isNot(contains('is OnnxValue')));

    expect(File('android/app/libs/PaddlePredictor.jar').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so').existsSync(), isTrue);
    expect(File('android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so').existsSync(), isTrue);
  });

  test('V172-Q384 keeps model artifacts out of the project tree', () {
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
