#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const readJson = (p) => JSON.parse(read(p));
const fail = (message) => {
  console.error(`CAMERA_REGRESSION_COURT_Q244_VERIFICATION_FAILED: ${message}`);
  process.exit(1);
};

for (const required of [
  'lib/features/camera/gauss_camera_regression_court_policy.dart',
  'lib/features/camera/gauss_camera_regression_court.dart',
  'test/v172_q244_camera_regression_court_test.dart',
  'tool/verify_camera_regression_court_v172_q244.mjs',
  'docs/audit/V172_Q244_CAMERA_REGRESSION_COURT_AUDIT.md',
  'docs/audit/V172_Q244_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml',
]) if (!exists(required)) fail(`missing Q244 required file: ${required}`);

const policy = read('lib/features/camera/gauss_camera_regression_court_policy.dart');
const court = read('lib/features/camera/gauss_camera_regression_court.dart');
const test = read('test/v172_q244_camera_regression_court_test.dart');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

for (const marker of [
  "phase = 'V172-Q244'",
  "fullPhase = 'V172-Q244-CAMERA-REGRESSION-COURT'",
  'q243CameraUxPremiumPolishPreserved = true',
  'q242OfflineModeGuardPreserved = true',
  'q241WinnerEngineAdapterPreserved = true',
  'q240r3ExternalLabIntakeGatePreserved = true',
  'q240r2ExternalLabSchemaPreserved = true',
  'q240r1DatasetLabRunnerPreserved = true',
  'q240BenchmarkCourtPreserved = true',
  'q239eMathLiveReviewSurfacePreserved = true',
  'q239dDeferredModelManagerPreserved = true',
  'q239cCropScanFramePreserved = true',
  'q239bCaptureShellPreserved = true',
  'q239aWorkspaceCameraButtonPreserved = true',
  'regressionCourtImplemented = true',
  'cameraPipelineBoundaryLocked = true',
  'noDirectCameraMathActionCourtImplemented = true',
  'redLineSurfaceCourtImplemented = true',
  'dependencyAndAssetCourtImplemented = true',
  'manifestMetadataCourtImplemented = true',
  'commandCourtDocumented = true',
  'realOcrEngineAdded = false',
  'textOcrFallbackAdded = false',
  'paddleRuntimeAdded = false',
  'pix2TextRuntimeAdded = false',
  'texTellerRuntimeAdded = false',
  'uniMerNetRuntimeAdded = false',
  'onnxRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'realBenchmarkImageAssetsBundled = false',
  'productionModelUrlBound = false',
  'backgroundDownloadWorkerImplemented = false',
  'productionMathLiveBridgeCalled = false',
  'directWorkspaceImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'graphFromCameraAllowed = false',
  'historyWriteFromCameraAllowed = false',
  'solutionFromCameraAllowed = false',
  'cameraRuntimeMutationAllowed = false',
  'cropReviewRuntimeMutationAllowed = false',
  'workspaceActionRowMutationAllowed = false',
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
  'androidRealDeviceCameraRegressionPassClaimedByAssistant = false',
  'realEngineAccuracyPassClaimedByAssistant = false',
  'preservedCameraFoundationPhases',
  'lockedRedLineSurfaces',
  'forbiddenCameraRegressionActions',
]) if (!policy.includes(marker)) fail(`Q244 policy missing marker: ${marker}`);

for (const marker of [
  'class GaussCameraRegressionCourtCheckpoint',
  'class GaussCameraRegressionCourtVerdict',
  'class GaussCameraRegressionCourt',
  'runStaticCourt()',
  'q239aWorkspaceCameraEntryPreserved',
  'q239bCameraCaptureShellPreserved',
  'q239cCropScanFramePreserved',
  'q239dDeferredModelManagerPreserved',
  'q239eMathLiveReviewSurfacePreserved',
  'q240BenchmarkCourtPreserved',
  'q240r1DatasetLabRunnerPreserved',
  'q240r2ExternalLabSchemaPreserved',
  'q240r3IntakeGatePreserved',
  'q241WinnerAdapterPreserved',
  'q242OfflineModeGuardPreserved',
  'q243PremiumUxPreserved',
  'redLineSurfacesLocked',
  'noRuntimeEngineOrModelAdded',
  'realDeviceRetestRequired',
]) if (!court.includes(marker)) fail(`Q244 court missing marker: ${marker}`);

for (const marker of [
  'GaussCameraRegressionCourtPolicy.phase',
  'GaussCameraRegressionCourt.runStaticCourt()',
  'staticCourtPassed, isTrue',
  'hasBlockingFailure, isFalse',
  'realFlutterAndAndroidRetestRequired, isTrue',
  'realOcrEngineRuntimeBound, isFalse',
  'directCameraMathActionAllowed, isFalse',
  'google_mlkit_text_recognition',
  'onnxruntime',
  'flutter_downloader',
]) if (!test.includes(marker)) fail(`Q244 test missing marker: ${marker}`);

const env = manifest.v172Q244CameraRegressionCourt;
if (!env) fail('manifest missing v172Q244CameraRegressionCourt envelope');
for (const [key, expected] of Object.entries({
  phase: 'V172-Q244',
  fullPhase: 'V172-Q244-CAMERA-REGRESSION-COURT',
  q243CameraUxPremiumPolishPreserved: true,
  q242OfflineModeGuardPreserved: true,
  q241WinnerEngineAdapterPreserved: true,
  q240r3ExternalLabIntakeGatePreserved: true,
  q240r2ExternalLabSchemaPreserved: true,
  q240r1DatasetLabRunnerPreserved: true,
  q240BenchmarkCourtPreserved: true,
  q239eMathLiveReviewSurfacePreserved: true,
  q239dDeferredModelManagerPreserved: true,
  q239cCropScanFramePreserved: true,
  q239bCaptureShellPreserved: true,
  q239aWorkspaceCameraButtonPreserved: true,
  regressionCourtImplemented: true,
  cameraPipelineBoundaryLocked: true,
  noDirectCameraMathActionCourtImplemented: true,
  redLineSurfaceCourtImplemented: true,
  dependencyAndAssetCourtImplemented: true,
  manifestMetadataCourtImplemented: true,
  realOcrEngineAdded: false,
  textOcrFallbackAdded: false,
  paddleRuntimeAdded: false,
  pix2TextRuntimeAdded: false,
  texTellerRuntimeAdded: false,
  uniMerNetRuntimeAdded: false,
  onnxRuntimeAdded: false,
  modelBinaryBundledInBaseApp: false,
  realBenchmarkImageAssetsBundled: false,
  productionModelUrlBound: false,
  backgroundDownloadWorkerImplemented: false,
  productionMathLiveBridgeCalled: false,
  directWorkspaceImportImplemented: false,
  directSolveFromCameraAllowed: false,
  graphFromCameraAllowed: false,
  historyWriteFromCameraAllowed: false,
  solutionFromCameraAllowed: false,
  cameraRuntimeMutationAllowed: false,
  cropReviewRuntimeMutationAllowed: false,
  workspaceActionRowMutationAllowed: false,
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
  androidRealDeviceCameraRegressionPassClaimed: false,
  realEngineAccuracyPassClaimed: false,
})) if (env[key] !== expected) fail(`manifest Q244 ${key} expected ${expected} got ${env[key]}`);

for (const key of ['auditFiles', 'sourceFiles', 'testFiles', 'toolFiles', 'preservedCameraFoundationPhases', 'lockedRedLineSurfaces', 'forbiddenCameraRegressionActions']) {
  if (!Array.isArray(env[key]) || env[key].length === 0) fail(`manifest Q244 ${key} must be a non-empty list`);
}
if (manifest.cameraRegressionCourtLatestPhase !== 'V172-Q244') fail('manifest cameraRegressionCourtLatestPhase must be V172-Q244');
if (manifest.cameraOcrLatestPhase !== 'V172-Q244') fail('manifest cameraOcrLatestPhase must be V172-Q244');

if (!readme.includes('# V172-Q244 — Camera Regression Court')) fail('README missing Q244 section');
if (!readme.includes('Q244 does not add OCR')) fail('README must state Q244 does not add OCR');
if (!readme.includes('MathLive editable review')) fail('README must preserve MathLive editable review statement');
if (!readme.includes('Q244 is a regression court')) fail('README missing regression court statement');

if (!/^\s*camera\s*:\s*(?:0\.10\.6|\^?0\.11\.0)\s*$/m.test(pubspec)) fail('pubspec must keep a locked camera package compatible with the active Q244 successor');
if (pubspec.includes('camera_android_camerax')) fail('Q244R4 successor must not use CameraX implementation because user-side Kotlin metadata failed');
if (!/^\s*shared_preferences\s*:\s*\^2\.5\.5\s*$/m.test(pubspec)) fail('pubspec must keep shared_preferences: ^2.5.5');
for (const regex of [
  /^\s*google_mlkit_text_recognition\s*:/m,
  /^\s*google_mlkit_commons\s*:/m,
  /^\s*paddle/m,
  /^\s*onnxruntime/m,
  /^\s*pix2text/m,
  /^\s*workmanager\s*:/m,
  /^\s*flutter_downloader\s*:/m,
  /^\s*http\s*:/m,
]) if (regex.test(pubspec)) fail(`Q244 must not add OCR/download/runtime dependency matching ${regex}`);

if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission from Q239B missing');
for (const forbidden of ['READ_MEDIA_IMAGES', 'READ_EXTERNAL_STORAGE', 'INTERNET']) {
  if (androidManifest.includes(forbidden)) fail(`Q244 must not add manifest permission marker: ${forbidden}`);
}

const cameraShell = read('lib/features/camera/gauss_camera_capture_shell.dart');
for (const marker of [
  'GaussCameraUxPremiumPolishContract.previewHeaderCopy',
  'GaussMathLiveOcrReviewSheet',
  'CameraPreview(readyController)',
  'takePicture()',
]) if (!cameraShell.includes(marker)) fail(`camera runtime shell missing expected preserved marker: ${marker}`);
for (const forbidden of [
  'google_mlkit_text_recognition',
  'onnxruntime',
  'pix2text',
  'PaddleOCR',
  'solveFromCamera',
  'evaluateFromCamera',
  'graphFromCamera',
  'writeHistoryFromCamera',
]) if (cameraShell.includes(forbidden)) fail(`camera shell must not contain forbidden marker: ${forbidden}`);

for (const ext of ['.onnx', '.tflite', '.pt', '.pth', '.pdmodel', '.pdiparams', '.bin']) {
  const matches = [];
  const walk = (dir) => {
    for (const name of fs.readdirSync(dir)) {
      const p = `${dir}/${name}`;
      const st = fs.statSync(p);
      if (st.isDirectory()) walk(p);
      else if (p.toLowerCase().endsWith(ext)) matches.push(path.relative(root, p));
    }
  };
  for (const dir of ['assets', 'lib', 'android', 'docs']) if (exists(dir)) walk(path.join(root, dir));
  if (matches.length) fail(`Q244 must not bundle model/runtime files ${ext}: ${matches.join(', ')}`);
}

const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/workspace/template_tray.dart',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/history/history_controller.dart',
  'lib/app/app_shell.dart',
  'lib/main.dart',
  'android/app/src/main/AndroidManifest.xml',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
];
for (const file of protectedFiles) if (!exists(file)) fail(`protected file missing: ${file}`);

console.log('CAMERA_REGRESSION_COURT_Q244_STATIC_READY_BUT_REAL_FLUTTER_ANDROID_AND_CAMERA_RETEST_REQUIRED');
