#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const errors = [];
const fail = (message) => errors.push(message);
const fullPhase = 'V172-Q239D-DEFERRED-MATH-OCR-MODEL-MANAGER-FOUNDATION';

for (const required of [
  'lib/features/camera/gauss_deferred_math_ocr_model_manager_policy.dart',
  'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart',
  'lib/features/camera/gauss_camera_capture_shell.dart',
  'lib/features/camera/gauss_formula_crop_scan_frame_policy.dart',
  'test/v172_q239d_deferred_math_ocr_model_manager_test.dart',
  'docs/audit/V172_Q239D_DEFERRED_MATH_OCR_MODEL_MANAGER_AUDIT.md',
  'docs/audit/V172_Q239D_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml'
]) if (!exists(required)) fail(`missing Q239D required file: ${required}`);

const policy = read('lib/features/camera/gauss_deferred_math_ocr_model_manager_policy.dart');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const cameraShell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const reviewSurface = exists('lib/features/camera/gauss_mathlive_ocr_review_surface.dart') ? read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart') : '';
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const readme = read('README.md');
const successorActive = manager.includes('queueUserApprovedNetworkPreparation') && manager.includes('installProductionModelQ384R1') && pubspec.includes('http:');

for (const marker of [
  "phase = 'V172-Q239D'",
  "fullPhase = 'V172-Q239D-DEFERRED-MATH-OCR-MODEL-MANAGER-FOUNDATION'",
  'modelManagerStateContractImplemented = true',
  'modelManifestContractImplemented = true',
  'modelStatusPersistenceImplemented = true',
  'sha256VerificationRequiredByContract = true',
  'privateStorageInstallRequiredByContract = true',
  'optionalModelPackArchitecturePrepared = true',
  'modelBinaryBundledInBaseApp = false',
  'ocrEngineAdded = false',
  'onnxRuntimeAdded = false',
  'directSolveFromCameraAllowed = false',
  'keyboardMutationAllowed = false',
  'graphRuntimeMutationAllowed = false',
  'solutionMutationAllowed = false',
  'solverMutationAllowed = false',
]) if (!policy.includes(marker)) fail(`Q239D policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussMathOcrModelInstallStatus',
  'notInstalled',
  'queued',
  'downloading',
  'verifying',
  'ready',
  'failed',
  'updateAvailable',
  'disabledByUser',
  'class GaussDeferredMathOcrModelManifest',
  "installMode = 'deferred-after-install'",
  "storagePolicy = 'app-private-storage'",
  'requiresSha256BeforeReady = true',
  'supportsOfflineAfterInstall = true',
  'directSolveAllowed = false',
  'class GaussMathOcrModelSnapshot',
  'toJsonString()',
  'fromJsonString',
  'class GaussDeferredMathOcrModelManager',
  'SharedPreferences.getInstance()',
  'markDisabledByUser()',
  'resetForDiagnostics()'
]) if (!manager.includes(marker)) fail(`model manager missing marker: ${marker}`);

if (successorActive) {
  for (const marker of [
    "networkPolicy = GaussCameraOcrDownloadGuardRepairQ385R1Policy.networkPolicy",
    'queueUserApprovedNetworkPreparation()',
    'queueWifiOnlyPreparation()',
    'installProductionModelQ384R1',
    '_recoverStaleActiveSnapshot',
    'Q385R2 eski aktif',
  ]) if (!manager.includes(marker)) fail(`Q239D successor-aware manager marker missing: ${marker}`);
} else if (!manager.includes("networkPolicy = 'wifi-only-by-default'")) {
  fail('Q239D historical manager must either keep wifi-only-by-default or expose Q384/Q385 successor network policy');
}

const cameraReviewFlow = `${cameraShell}\n${reviewSurface}`;
for (const marker of [
  "import 'gauss_deferred_math_ocr_model_manager.dart';",
  'GaussMathOcrModelSnapshot _mathOcrModelSnapshot',
  '_loadMathOcrModelSnapshot()',
  'GaussDeferredMathOcrModelManager.load()',
  'class _DeferredModelStatusCard extends StatelessWidget',
  'PP-FormulaNet-S modeli',
]) if (!cameraReviewFlow.includes(marker)) fail(`camera/review flow missing Q239D marker: ${marker}`);

for (const forbidden of [
  'google_mlkit_text_recognition',
  'onnxruntime',
  'MathLiveProductionEditorSurface',
  'SolutionStepsPanel',
  'setLatex',
  'evaluateFromCamera',
  'solveFromCamera',
  'WorkManager'
]) if (cameraReviewFlow.toLowerCase().includes(forbidden.toLowerCase()) || manager.toLowerCase().includes(forbidden.toLowerCase())) {
  fail(`Q239D successor-aware verifier blocks unsafe OCR/solver/runtime marker: ${forbidden}`);
}

if (!/^\s*camera\s*:\s*(?:0\.10\.6|\^?0\.11\.0)\s*$/m.test(pubspec)) fail('pubspec must keep a locked camera package compatible with the active Q244 successor');
if (!/^\s*shared_preferences\s*:\s*\^2\.5\.5\s*$/m.test(pubspec)) fail('pubspec must keep existing shared_preferences: ^2.5.5');
for (const regex of [/^\s*google_mlkit_text_recognition\s*:/m, /^\s*google_mlkit_commons\s*:/m, /^\s*onnxruntime/m, /^\s*pix2text/m, /^\s*workmanager\s*:/m, /^\s*flutter_downloader\s*:/m]) {
  if (regex.test(pubspec)) fail(`Q239D must not add unsafe OCR/runtime dependency matching ${regex}`);
}
if (!successorActive && /^\s*http\s*:/m.test(pubspec)) fail('Q239D historical mode must not add http; successor mode must be detected explicitly');
if (successorActive && !/^\s*http\s*:/m.test(pubspec)) fail('Q384/Q385 successor mode must declare http dependency for real user-approved download');

for (const marker of ['<uses-permission android:name="android.permission.CAMERA" />', '<uses-feature android:name="android.hardware.camera.any" android:required="false" />']) {
  if (!androidManifest.includes(marker)) fail(`AndroidManifest missing camera marker: ${marker}`);
}
if (successorActive && !androidManifest.includes('<uses-permission android:name="android.permission.INTERNET" />')) fail('Q384/Q385 successor download mode requires documented INTERNET permission');
for (const forbidden of ['android.permission.READ_MEDIA_IMAGES', 'android.permission.READ_EXTERNAL_STORAGE', 'android.permission.WRITE_EXTERNAL_STORAGE', 'android.permission.RECORD_AUDIO', 'android.permission.POST_NOTIFICATIONS', 'android.permission.FOREGROUND_SERVICE']) {
  if (androidManifest.includes(forbidden)) fail(`Q239D successor-aware verifier blocks extra Android permission: ${forbidden}`);
}

if (manifest.deferredMathOcrModelManagerLatestPhase !== fullPhase) fail('manifest latest Q239D phase mismatch');
const env = manifest.v172Q239DDeferredMathOcrModelManager;
if (!env || env.phase !== fullPhase) fail('manifest Q239D envelope missing');
if (!readme.includes('## V172-Q239D — Deferred Math OCR Model Manager Foundation')) fail('README missing Q239D section');

const report = {
  phase: 'V172-Q239D',
  status: errors.length === 0 ? 'DEFERRED_MATH_OCR_MODEL_MANAGER_Q239D_SUCCESSOR_AWARE_STATIC_READY_BUT_REAL_FLUTTER_AND_ANDROID_RETEST_REQUIRED' : 'DEFERRED_MATH_OCR_MODEL_MANAGER_Q239D_BLOCKED',
  successorActive,
  errors,
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/deferred_math_ocr_model_manager_q239d_report.json'), JSON.stringify(report, null, 2) + '\n');
if (errors.length) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}
console.log(report.status);
