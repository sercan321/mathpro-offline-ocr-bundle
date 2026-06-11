#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const errors = [];
const fail = (message) => errors.push(message);
const fullPhase = 'V172-Q239C-FORMULA-CROP-SCAN-FRAME-SHELL';

for (const required of [
  'lib/features/camera/gauss_formula_crop_scan_frame_policy.dart',
  'lib/features/camera/gauss_camera_capture_shell.dart',
  'lib/features/workspace/workspace_panel.dart',
  'test/v172_q239c_formula_crop_scan_frame_test.dart',
  'docs/audit/V172_Q239C_FORMULA_CROP_SCAN_FRAME_AUDIT.md',
  'docs/audit/V172_Q239C_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml'
]) if (!exists(required)) fail(`missing Q239C required file: ${required}`);

const policy = read('lib/features/camera/gauss_formula_crop_scan_frame_policy.dart');
const cameraShell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const reviewSurface = exists('lib/features/camera/gauss_mathlive_ocr_review_surface.dart') ? read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart') : '';
const cameraReviewFlow = `${cameraShell}
${reviewSurface}`;
const workspace = read('lib/features/workspace/workspace_panel.dart');
const test = read('test/v172_q239c_formula_crop_scan_frame_test.dart');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');

for (const marker of [
  "phase = 'V172-Q239C'",
  "fullPhase = 'V172-Q239C-FORMULA-CROP-SCAN-FRAME-SHELL'",
  'q239bCaptureShellPreserved = true',
  'premiumFormulaCropReviewImplemented = true',
  'capturedPhotoPreviewImplemented = true',
  'boundedFormulaScanFrameImplemented = true',
  'retakeControlImplemented = true',
  'rotateControlImplemented = true',
  'useFrameControlImplemented = true',
  'cropMetadataPreparedForFuturePreprocess = true',
  'actualImageCropFileWritten = false',
  'galleryImportImplemented = false',
  'normalizedFrameWidth = 0.78',
  'normalizedFrameHeight = 0.34',
  'ocrEngineAdded = false',
  'textOcrFallbackAdded = false',
  'paddleOcrAdded = false',
  'pix2TextAdded = false',
  'onnxRuntimeAdded = false',
  'deferredModelDownloadImplemented = false',
  'mathLiveImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'keyboardMutationAllowed = false',
  'longPressMutationAllowed = false',
  'moreMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'graphRuntimeMutationAllowed = false',
  'resultPanelMutationAllowed = false',
  'solutionMutationAllowed = false',
  'historyMutationAllowed = false',
  'solverMutationAllowed = false',
  'splashMutationAllowed = false',
  'launcherIconMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
  'flutterRunPassClaimedByAssistant = false',
  'androidRealDeviceCropPassClaimedByAssistant = false'
]) if (!policy.includes(marker)) fail(`Q239C policy missing marker: ${marker}`);

for (const marker of [
  "import 'dart:io';",
  "import 'gauss_formula_crop_scan_frame_policy.dart';",
  'class GaussCameraCaptureShell extends StatefulWidget',
  'availableCameras()',
  'CameraController(',
  'CameraPreview(readyController)',
  'takePicture()',
  '_cropReviewOpen = true',
  '_cropRotationQuarterTurns = 0',
  "ValueKey('mathpro-formula-crop-review-card')",
  'class _FormulaCropReviewCard extends StatelessWidget',
  'Image.file(',
  'File(capturePath)',
  'class _FormulaCropFrameOverlay extends StatelessWidget',
  'GaussFormulaCropScanFramePolicy.normalizedFrameWidth',
  'GaussFormulaCropScanFramePolicy.normalizedFrameHeight',
  'class _FormulaCropReviewControls extends StatelessWidget',
  "tooltip: 'Tekrar çek'",
  "tooltip: 'Döndür'",
  "label: 'Kırpma çerçevesini kullan'",
  'GaussMathLiveOcrReviewSheet'
]) if (!cameraReviewFlow.includes(marker)) fail(`camera/review flow missing Q239C marker: ${marker}`);

if (!cameraReviewFlow.includes('MathLive review hazırlandı') && !cameraReviewFlow.includes('MathLive OCR review')) {
  fail('camera/review flow missing Q239C MathLive review copy');
}
if (!cameraReviewFlow.includes('Fotoğraf doğrudan çözüme gönderilmedi') && !cameraReviewFlow.includes('OCR review akışı başlar')) {
  fail('camera/review flow missing Q239C camera review copy');
}
if (!cameraReviewFlow.includes('OCR sonraki fazda') && !cameraReviewFlow.includes('OCR review akışı başlar') && !cameraReviewFlow.includes('OCR adayı henüz hazır değil')) {
  fail('camera/review flow missing Q239C OCR pending/review copy');
}
if (!cameraReviewFlow.includes('MathLive düzenleme adayı') && !cameraReviewFlow.includes('Düzenlenebilir OCR adayı')) {
  fail('camera/review flow missing Q239C editable review copy');
}

for (const marker of [
  "ValueKey('mathpro-workspace-camera-entry-button')",
  'Icons.photo_camera_outlined',
  "tooltip: 'Kamera'",
  "semanticLabel: 'Kamera ile ifade tara'",
  '_openCameraCaptureShell(context)',
  'GaussCameraCaptureShell'
]) if (!workspace.includes(marker)) fail(`workspace camera entry lost after Q239C: ${marker}`);

for (const forbidden of [
  'google_mlkit_text_recognition',
  'paddle',
  'pix2text',
  'onnxruntime',
  'MathLiveProductionEditorSurface',
  'SolutionStepsPanel',
  'setLatex',
  'evaluateFromCamera',
  'solveFromCamera'
]) if (cameraReviewFlow.toLowerCase().includes(forbidden.toLowerCase())) fail(`camera/review flow contains forbidden OCR/solver/MathLive marker: ${forbidden}`);

if (!/^\s*camera\s*:\s*(?:0\.10\.6|\^?0\.11\.0)\s*$/m.test(pubspec)) fail('pubspec must keep a locked camera package compatible with the active Q244 successor');
for (const regex of [
  /^\s*google_mlkit_text_recognition\s*:/m,
  /^\s*google_mlkit_commons\s*:/m,
  /^\s*paddle/m,
  /^\s*onnxruntime/m,
  /^\s*pix2text/m,
  /^\s*image_cropper\s*:/m,
]) if (regex.test(pubspec)) fail(`Q239C must not add OCR/model/crop dependency matching ${regex}`);

for (const marker of [
  '<uses-permission android:name="android.permission.CAMERA" />',
  '<uses-feature android:name="android.hardware.camera.any" android:required="false" />'
]) if (!androidManifest.includes(marker)) fail(`AndroidManifest missing existing Q239B marker: ${marker}`);
for (const forbidden of [
  'android.permission.READ_MEDIA_IMAGES',
  'android.permission.READ_EXTERNAL_STORAGE',
  'android.permission.WRITE_EXTERNAL_STORAGE',
  'android.permission.RECORD_AUDIO'
]) if (androidManifest.includes(forbidden)) fail(`Q239C must not add non-camera permission: ${forbidden}`);

if (manifest.formulaCropScanFrameLatestPhase !== fullPhase) fail('manifest latest Q239C phase mismatch');
const env = manifest.v172Q239CFormulaCropScanFrame;
if (!env || env.phase !== fullPhase) fail('manifest Q239C envelope missing');
else {
  for (const [key, expected] of Object.entries({
    q239bCaptureShellPreserved: true,
    premiumFormulaCropReviewImplemented: true,
    capturedPhotoPreviewImplemented: true,
    boundedFormulaScanFrameImplemented: true,
    retakeControlImplemented: true,
    rotateControlImplemented: true,
    useFrameControlImplemented: true,
    cropMetadataPreparedForFuturePreprocess: true,
    actualImageCropFileWritten: false,
    galleryImportImplemented: false,
    normalizedFrameWidth: 0.78,
    normalizedFrameHeight: 0.34,
    ocrEngineAdded: false,
    textOcrFallbackAdded: false,
    paddleOcrAdded: false,
    pix2TextAdded: false,
    onnxRuntimeAdded: false,
    deferredModelDownloadImplemented: false,
    mathLiveImportImplemented: false,
    directSolveFromCameraAllowed: false,
    keyboardMutationAllowed: false,
    longPressMutationAllowed: false,
    moreMutationAllowed: false,
    mathLiveProductionMutationAllowed: false,
    graphRuntimeMutationAllowed: false,
    resultPanelMutationAllowed: false,
    solutionMutationAllowed: false,
    historyMutationAllowed: false,
    solverMutationAllowed: false,
    splashMutationAllowed: false,
    launcherIconMutationAllowed: false,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    flutterRunPassClaimed: false,
    androidRealDeviceCropPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q239C ${key} expected ${expected} got ${env[key]}`);
}

if (!test.includes('GaussFormulaCropScanFramePolicy')) fail('Q239C test is not bound to policy');
if (!readme.includes('## V172-Q239C — Formula Crop / Scan Frame Shell')) fail('README missing Q239C section');

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/keyboard/math_keyboard.dart': 'fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c',
  'lib/features/keyboard/bottom_dock.dart': 'a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354',
  'lib/features/keyboard/long_press_popup.dart': '4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369',
  'lib/features/keyboard/premium_key.dart': '4311a54f0f4e21b3b134552af2613d2ff30fed2078ebd6279a222d877fa21b43',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9',
  'lib/features/solution/solution_steps_panel.dart': '558c0f232dd4bb81bbf92ffa7687ff8d77fb450daf95f5e04a98f277f1625f2b',
  'lib/features/solution/solution_step_models.dart': 'faab66d941f841911989bee8fae44d0d1edc546fabb6f65fd7dab777405cc248',
  'lib/features/history/history_panel.dart': 'fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b',
  'lib/features/history/history_controller.dart': '331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51',
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt': 'c27aa8777ba2a3b33bc15d839b2b05bb35f9f6a09f4c5c8de0e39365f65dacf1',
  'android/app/src/main/AndroidManifest.xml': '4fe91898ddf5ff94af1527314c8977806f23b051b7de078f25604dfa4731c1a6',
  'lib/features/graph/graph_card.dart': '124accae8499c2dbc8cb6e1dde3a2317dfaafad576363aecebd5f78c94f22b6f',
  'lib/app/gauss_splash_screen.dart': '465c3b70662673dbed283ef15cd7bbc22cba0402668e670da136aedfeb54ee81'
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected/red-line file missing: ${file}`);
  else {
    const actual = sha(file);
    if (actual !== expected) fail(`protected/red-line hash mismatch for ${file}: ${actual} expected ${expected}`);
  }
}

const report = {
  phase: 'V172-Q239C',
  status: errors.length === 0
    ? 'FORMULA_CROP_SCAN_FRAME_Q239C_STATIC_READY_BUT_REAL_FLUTTER_AND_ANDROID_RETEST_REQUIRED'
    : 'FORMULA_CROP_SCAN_FRAME_Q239C_BLOCKED',
  errors,
  cropReviewImplemented: true,
  actualImageCropFileWritten: false,
  ocrEngineAdded: false,
  modelDownloadImplemented: false,
  mathLiveImportImplemented: false,
  directSolveFromCameraAllowed: false,
  flutterAnalyzePassClaimed: false,
  flutterTestPassClaimed: false,
  flutterRunPassClaimed: false,
  androidRealDeviceCropPassClaimed: false
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/formula_crop_scan_frame_q239c_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/formula_crop_scan_frame_q239c_report.md'), `# V172-Q239C Formula Crop / Scan Frame Shell\n\nStatus: ${report.status}\n\nCrop review implemented: true\n\nActual crop file written: false\n\nOCR / model download / MathLive import / direct solve added: false\n\nFlutter/Android PASS claimed: false\n`);

if (errors.length) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}

console.log(report.status);
