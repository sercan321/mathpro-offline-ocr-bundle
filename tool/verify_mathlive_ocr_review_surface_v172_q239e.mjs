#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const errors = [];
const fail = (message) => errors.push(message);

for (const required of [
  'lib/features/camera/gauss_mathlive_ocr_review_surface_policy.dart',
  'lib/features/camera/gauss_mathlive_ocr_review_surface.dart',
  'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart',
  'lib/features/camera/gauss_camera_capture_shell.dart',
  'test/v172_q239e_mathlive_ocr_review_surface_test.dart',
  'docs/audit/V172_Q239E_MATHLIVE_OCR_REVIEW_SURFACE_AUDIT.md',
  'docs/audit/V172_Q239E_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml'
]) if (!exists(required)) fail(`missing Q239E required file: ${required}`);

const policy = read('lib/features/camera/gauss_mathlive_ocr_review_surface_policy.dart');
const review = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const shell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const readme = read('README.md');
const successorActive = manager.includes('installProductionModelQ384R1') && pubspec.includes('http:');

for (const marker of [
  "phase = 'V172-Q239E'",
  'mathLiveOcrReviewSurfaceImplemented = true',
  'ocrCandidateContractPrepared = true',
  'editableReviewRequiredBeforeWorkspaceImport = true',
  'reviewSurfaceReceivesCaptureMetadata = true',
  'reviewSurfaceShowsModelStatus = true',
  'reviewSurfaceCanQueueDeferredModel = true',
  'workspaceImportDeferredUntilRealCandidate = true',
  'realOcrEngineAdded = false',
  'onnxRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionMathLiveBridgeCalled = false',
  'directWorkspaceImportImplemented = false',
  'directSolveFromCameraAllowed = false',
]) if (!policy.includes(marker)) fail(`Q239E policy missing marker: ${marker}`);

for (const marker of [
  'class GaussMathLiveOcrReviewSheet',
  'class GaussMathLiveOcrReviewDraft',
  'class _DeferredModelStatusCard extends StatelessWidget',
  'PP-FormulaNet-S modeli',
  'Modeli indir',
  'OCR candidate pending',
  'Workspace aktarımı',
  'LinearProgressIndicator',
]) if (!review.includes(marker)) fail(`review surface missing marker: ${marker}`);

if (successorActive) {
  for (const marker of [
    'GaussDeferredModelInstallCallback',
    'onQueueModel((progressSnapshot)',
    'Ana model SHA256 ile doğrulandı',
    'yan dosyalar varlık/boyut kontrolünden geçti',
  ]) if (!review.includes(marker) && !shell.includes(marker)) fail(`Q239E successor-aware review marker missing: ${marker}`);
} else if (!review.includes('Wi‑Fi kuyruğu')) {
  fail('Q239E historical mode must either keep Wi-Fi queue text or expose Q384/Q385 successor download copy');
}

for (const forbidden of ['google_mlkit_text_recognition', 'onnxruntime', 'MathLiveProductionEditorSurface', 'setLatex', 'evaluateFromCamera', 'solveFromCamera']) {
  if (review.toLowerCase().includes(forbidden.toLowerCase()) || shell.toLowerCase().includes(forbidden.toLowerCase())) fail(`Q239E blocks unsafe review/runtime marker: ${forbidden}`);
}

if (!/^\s*camera\s*:\s*(?:0\.10\.6|\^?0\.11\.0)\s*$/m.test(pubspec)) fail('pubspec must keep a locked camera package compatible with the active Q244 successor');
if (!/^\s*shared_preferences\s*:\s*\^2\.5\.5\s*$/m.test(pubspec)) fail('pubspec must keep shared_preferences: ^2.5.5');
for (const regex of [/^\s*google_mlkit_text_recognition\s*:/m, /^\s*google_mlkit_commons\s*:/m, /^\s*onnxruntime/m, /^\s*pix2text/m, /^\s*workmanager\s*:/m, /^\s*flutter_downloader\s*:/m]) if (regex.test(pubspec)) fail(`Q239E must not add unsafe OCR/download/runtime dependency matching ${regex}`);
if (successorActive && !/^\s*http\s*:/m.test(pubspec)) fail('Q384/Q385 successor review mode requires http dependency for real user-approved download');
if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission from Q239B missing');
if (successorActive && !androidManifest.includes('<uses-permission android:name="android.permission.INTERNET" />')) fail('Q384/Q385 successor download mode requires INTERNET permission');
if (androidManifest.includes('READ_MEDIA_IMAGES') || androidManifest.includes('READ_EXTERNAL_STORAGE')) fail('Q239E must not add gallery/storage permission');

const env = manifest.v172Q239EMathLiveOcrReviewSurface;
if (!env) fail('manifest missing v172Q239EMathLiveOcrReviewSurface envelope');
if (!readme.includes('## V172-Q239E — MathLive OCR Review Surface Foundation')) fail('README missing Q239E section');

const report = {
  phase: 'V172-Q239E',
  status: errors.length === 0 ? 'MATHLIVE_OCR_REVIEW_SURFACE_Q239E_SUCCESSOR_AWARE_STATIC_READY_BUT_REAL_FLUTTER_AND_ANDROID_RETEST_REQUIRED' : 'MATHLIVE_OCR_REVIEW_SURFACE_Q239E_BLOCKED',
  successorActive,
  errors,
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/mathlive_ocr_review_surface_q239e_report.json'), JSON.stringify(report, null, 2) + '\n');
if (errors.length) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}
console.log(report.status);
