#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const readJson = (p) => JSON.parse(read(p));
const fail = (message) => {
  console.error(`CAMERA_UX_PREMIUM_POLISH_Q243_VERIFICATION_FAILED: ${message}`);
  process.exit(1);
};

for (const required of [
  'lib/features/camera/gauss_camera_ux_premium_polish_policy.dart',
  'lib/features/camera/gauss_camera_ux_premium_polish.dart',
  'lib/features/camera/gauss_camera_capture_shell.dart',
  'test/v172_q243_camera_ux_premium_polish_test.dart',
  'tool/verify_camera_ux_premium_polish_v172_q243.mjs',
  'docs/audit/V172_Q243_CAMERA_UX_PREMIUM_POLISH_AUDIT.md',
  'docs/audit/V172_Q243_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml',
]) if (!exists(required)) fail(`missing Q243 required file: ${required}`);

const policy = read('lib/features/camera/gauss_camera_ux_premium_polish_policy.dart');
const contract = read('lib/features/camera/gauss_camera_ux_premium_polish.dart');
const cameraShell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const test = read('test/v172_q243_camera_ux_premium_polish_test.dart');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

for (const marker of [
  "phase = 'V172-Q243'",
  "fullPhase = 'V172-Q243-CAMERA-UX-PREMIUM-POLISH'",
  'q242OfflineModeGuardPreserved = true',
  'q241WinnerEngineAdapterPreserved = true',
  'q239eMathLiveReviewSurfacePreserved = true',
  'q239cCropScanFramePreserved = true',
  'q239bCaptureShellPreserved = true',
  'cameraUxPremiumPolishImplemented = true',
  'premiumFocusQualityRailImplemented = true',
  'lowLightGuidanceCopyImplemented = true',
  'blurGuidanceCopyImplemented = true',
  'alignmentGuidanceCopyImplemented = true',
  'cropReviewConfidenceCopyImplemented = true',
  'captureControlHierarchyPreserved = true',
  'retakeRotateUseFrameControlsPreserved = true',
  'mathLiveReviewOnlyCopyPreserved = true',
  'noDirectCameraToMathActionPolicyPreserved = true',
  'realOcrEngineAdded = false',
  'textOcrFallbackAdded = false',
  'paddleRuntimeAdded = false',
  'pix2TextRuntimeAdded = false',
  'onnxRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'backgroundDownloadWorkerImplemented = false',
  'productionMathLiveBridgeCalled = false',
  'directWorkspaceImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'androidRealDeviceCameraUxPassClaimedByAssistant = false',
]) if (!policy.includes(marker)) fail(`Q243 policy missing marker: ${marker}`);

for (const marker of [
  'class GaussCameraUxPremiumPolishContract',
  'previewHeaderCopy',
  'previewBodyCopy',
  'cropHeaderCopy',
  'cropBodyCopy',
  'lowLightWarningCopy',
  'blurWarningCopy',
  'alignmentWarningCopy',
  'qualityRailLabels',
  'qualityRailHints',
  'exposesPremiumGuidanceOnly => true',
  'blocksDirectMathActions => true',
  'preservesMathLiveReviewOnlyFlow => true',
  'keepsCameraRuntimeCaptureOnly => true',
]) if (!contract.includes(marker)) fail(`Q243 contract missing marker: ${marker}`);

for (const marker of [
  "import 'gauss_camera_ux_premium_polish.dart';",
  'class _CameraUxQualityRail extends StatelessWidget',
  'class _CameraQualityChipRow extends StatelessWidget',
  'class _CameraQualityChip extends StatelessWidget',
  'class _CameraUxCompactQualityPill extends StatelessWidget',
  'GaussCameraUxPremiumPolishContract.previewHeaderCopy',
  'GaussCameraUxPremiumPolishContract.previewBodyCopy',
  'GaussCameraUxPremiumPolishContract.cropHeaderCopy',
  'GaussCameraUxPremiumPolishContract.cropBodyCopy',
  'qualityRailLabels',
  'qualityRailHints',
  'GaussMathLiveOcrReviewSheet',
  'takePicture()',
  'CameraPreview(readyController)',
]) if (!cameraShell.includes(marker)) fail(`camera shell missing Q243 marker: ${marker}`);


if (!cameraShell.includes('Formülü çerçeve içine al. Bu ekran sadece fotoğraf yakalar; OCR sonraki fazda.') &&
    !cameraShell.includes('Formülü çerçeve içine al. Çerçeveyi kullanınca OCR review akışı başlar.')) {
  fail('camera shell missing Q243 camera guidance copy');
}

for (const forbidden of [
  'google_mlkit_text_recognition',
  'onnxruntime',
  'pix2text',
  'PaddleOCR',
  'MathLiveProductionEditorSurface',
  'setLatex',
  'solveFromCamera',
  'evaluateFromCamera',
  'graphFromCamera',
  'writeHistoryFromCamera',
]) if (cameraShell.includes(forbidden)) fail(`camera shell must not contain forbidden runtime marker: ${forbidden}`);

for (const marker of [
  'GaussCameraUxPremiumPolishPolicy.phase',
  'cameraUxPremiumPolishImplemented',
  'premiumFocusQualityRailImplemented',
  'lowLightGuidanceCopyImplemented',
  'blurGuidanceCopyImplemented',
  'alignmentGuidanceCopyImplemented',
  'realOcrEngineAdded, isFalse',
  'directSolveFromCameraAllowed, isFalse',
  'GaussCameraUxPremiumPolishContract.previewHeaderCopy',
  'blocksDirectMathActions, isTrue',
  'class _CameraUxQualityRail extends StatelessWidget',
]) if (!test.includes(marker)) fail(`Q243 test missing marker: ${marker}`);

const env = manifest.v172Q243CameraUxPremiumPolish;
if (!env) fail('manifest missing v172Q243CameraUxPremiumPolish envelope');
else {
  for (const [key, expected] of Object.entries({
    phase: 'V172-Q243',
    fullPhase: 'V172-Q243-CAMERA-UX-PREMIUM-POLISH',
    q242OfflineModeGuardPreserved: true,
    q241WinnerEngineAdapterPreserved: true,
    q239eMathLiveReviewSurfacePreserved: true,
    q239cCropScanFramePreserved: true,
    q239bCaptureShellPreserved: true,
    cameraUxPremiumPolishImplemented: true,
    premiumFocusQualityRailImplemented: true,
    lowLightGuidanceCopyImplemented: true,
    blurGuidanceCopyImplemented: true,
    alignmentGuidanceCopyImplemented: true,
    cropReviewConfidenceCopyImplemented: true,
    captureControlHierarchyPreserved: true,
    retakeRotateUseFrameControlsPreserved: true,
    mathLiveReviewOnlyCopyPreserved: true,
    noDirectCameraToMathActionPolicyPreserved: true,
    realOcrEngineAdded: false,
    textOcrFallbackAdded: false,
    paddleRuntimeAdded: false,
    pix2TextRuntimeAdded: false,
    onnxRuntimeAdded: false,
    modelBinaryBundledInBaseApp: false,
    productionModelUrlBound: false,
    backgroundDownloadWorkerImplemented: false,
    productionMathLiveBridgeCalled: false,
    directWorkspaceImportImplemented: false,
    directSolveFromCameraAllowed: false,
    graphFromCameraAllowed: false,
    historyWriteFromCameraAllowed: false,
    solutionFromCameraAllowed: false,
    keyboardMutationAllowed: false,
    longPressMutationAllowed: false,
    moreMutationAllowed: false,
    mathLiveProductionMutationAllowed: false,
    graphRuntimeMutationAllowed: false,
    solutionMutationAllowed: false,
    historyMutationAllowed: false,
    solverMutationAllowed: false,
    splashMutationAllowed: false,
    launcherIconMutationAllowed: false,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    flutterRunPassClaimed: false,
    androidRealDeviceCameraUxPassClaimed: false,
    realEngineAccuracyPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q243 ${key} expected ${expected} got ${env[key]}`);
  for (const label of ['Netlik', 'Işık', 'Hizalama']) {
    if (!(env.qualityRailLabels || []).includes(label)) fail(`manifest Q243 quality rail label missing ${label}`);
  }
}

if (manifest.cameraUxPremiumPolishLatestPhase !== 'V172-Q243') fail('manifest latest Q243 marker missing or incorrect');
if (!['V172-Q243', 'V172-Q244', 'V172-Q263-PP-FORMULANET-S-RUNTIME-PROTOTYPE-SMOKE-EVIDENCE-TEMPLATE', 'V172-Q265-PP-FORMULANET-S-RUNTIME-EVIDENCE-ACCEPTANCE-COURT', 'V172-Q266-PP-FORMULANET-S-RUNTIME-ACTIVATION-DECISION-GATE', 'V172-Q267-PP-FORMULANET-S-RUNTIME-INTEGRATION-PREFLIGHT-PACKAGE', 'V172-Q268-PP-FORMULANET-S-ISOLATED-RUNTIME-IMPLEMENTATION-GATE', 'V172-Q269-PP-FORMULANET-S-RUNTIME-DEPENDENCY-ISOLATION', 'V172-Q270-PP-FORMULANET-S-NATIVE-RUNTIME-BRIDGE-SKELETON', 'V172-Q271-PP-FORMULANET-S-PRIVATE-ARTIFACT-LOAD-PROTOTYPE', 'V172-Q272-PP-FORMULANET-S-FIRST-RUNTIME-SMOKE-PROTOTYPE', 'V172-Q273-PP-FORMULANET-S-IMAGE-TO-LATEX-PROTOTYPE-GATE', 'V172-Q274-OCR-RESULT-MATHLIVE-REAL-REVIEW-BINDING', 'V172-Q275-APPROVED-OCR-WORKSPACE-IMPORT-GATE', 'V172-Q276-CAMERA-OCR-REAL-END-TO-END-DEVICE-COURT', 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to this phase or successor through Q277');

if (!readme.includes('# V172-Q243 — Camera UX Premium Polish')) fail('README missing Q243 section');
if (!readme.includes('Q243 does not add OCR')) fail('README must state Q243 does not add OCR');
if (!readme.includes('MathLive editable review')) fail('README must preserve MathLive editable review statement');

if (!/^\s*camera\s*:\s*(?:0\.10\.6|\^?0\.11\.0)\s*$/m.test(pubspec)) fail('pubspec must keep a locked camera package compatible with the active Q244 successor');
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
]) if (regex.test(pubspec)) fail(`Q243 must not add OCR/download/runtime dependency matching ${regex}`);

if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission from Q239B missing');
for (const forbidden of ['READ_MEDIA_IMAGES', 'READ_EXTERNAL_STORAGE', 'INTERNET']) {
  if (androidManifest.includes(forbidden)) fail(`Q243 must not add manifest permission marker: ${forbidden}`);
}

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
  if (matches.length) fail(`Q243 must not bundle model/runtime files ${ext}: ${matches.join(', ')}`);
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

console.log(manifest.cameraOcrLatestPhase === 'V172-Q244' ? 'CAMERA_UX_PREMIUM_POLISH_Q243_STATIC_READY_WITH_Q244_CAMERA_REGRESSION_SUCCESSOR_BUT_REAL_FLUTTER_AND_ANDROID_RETEST_REQUIRED' : 'CAMERA_UX_PREMIUM_POLISH_Q243_STATIC_READY_BUT_REAL_FLUTTER_AND_ANDROID_RETEST_REQUIRED');
