#!/usr/bin/env node
import fs from 'fs';

const fail = (message) => { console.error(`FAIL verify_q389r5f_offline_stale_flutter_test_sweep_closure: ${message}`); process.exit(1); };
const check = (condition, message) => { if (!condition) fail(message); };
const read = (path) => fs.readFileSync(path, 'utf8');
const json = (path) => JSON.parse(read(path));
const exists = (path) => fs.existsSync(path);

const pubspec = read('pubspec.yaml');
check(pubspec.includes('version: 0.172.112+172'), 'pubspec metadata version must match legacy package metadata tests');
check(!pubspec.includes('version: 0.172.113+172'), 'stale 0.172.113 pubspec version must be removed');
check(/^\s*http:\s*\^1\.2\.2\s*$/m.test(pubspec), 'http dependency must remain for Q384R1 user-tapped model download');
check(!/^\s*onnxruntime\s*:/m.test(pubspec), 'onnxruntime dependency must not be present');
check(!/^\s*google_mlkit_text_recognition\s*:/m.test(pubspec), 'ML Kit text OCR dependency must not be present');
check(!/^\s*dio\s*:/m.test(pubspec), 'dio dependency must not be present');
check(!/^\s*flutter_downloader\s*:/m.test(pubspec), 'flutter_downloader dependency must not be present');

const reviewSurface = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
check(reviewSurface.includes('Gelişmiş model yöneticisi'), 'Q239D/Q239E legacy review-surface marker must be present');
check(!reviewSurface.includes('MathLiveProductionEditorSurface'), 'review surface must not mount production editor directly');
check(!reviewSurface.includes('evaluateFromCamera'), 'review surface must not evaluate camera output');
check(!reviewSurface.includes('solveFromCamera'), 'review surface must not solve camera output');

for (const file of [
  'test/v172_q240r1_ocr_benchmark_dataset_lab_runner_test.dart',
  'test/v172_q240r2_ocr_benchmark_external_lab_result_schema_test.dart',
  'test/v172_q240r3_ocr_benchmark_external_lab_intake_validation_gate_test.dart',
  'test/v172_q244_camera_regression_court_test.dart',
  'test/v172_q246_ocr_engine_real_benchmark_package_test.dart',
  'test/v172_q247_winner_engine_selection_test.dart',
]) {
  const text = read(file);
  check(!text.includes("isNot(contains('INTERNET'))"), `${file} must not keep stale pre-Q384 INTERNET rejection`);
  check(text.includes("contains('android.permission.INTERNET')"), `${file} must explicitly accept Q384R1 download-only INTERNET permission`);
  check(text.includes('Q384R1 download-only model installer requires user-tapped network access'), `${file} must document successor-aware INTERNET reason`);
}

for (const file of [
  'test/v172_q276_camera_ocr_real_end_to_end_device_court_test.dart',
  'test/v172_q277_camera_ocr_runtime_premium_regression_test.dart',
]) {
  const text = read(file);
  check(!text.includes("pubspec.contains('onnx')"), `${file} must not broad-scan historical ONNX comments`);
  check(!text.includes("pubspec.contains('paddle')"), `${file} must not broad-scan historical Paddle comments`);
  check(text.includes("RegExp(r'^\\s*onnxruntime\\s*:'"), `${file} must scan dependency declarations for onnxruntime`);
}

const q291Policy = read('lib/features/camera/gauss_private_model_download_sha_verification_runtime_policy.dart');
check(!q291Policy.includes("'http:',"), 'Q291 blockedDependencyFamilies must not reject intentional Q384R1 http package');
check(q291Policy.includes("'dio',"), 'Q291 must still block dio downloader family');
check(q291Policy.includes("'flutter_downloader',"), 'Q291 must still block flutter_downloader family');

const q382Audit = read('docs/audit/V172_Q382R24R1_STALE_TEST_EXPECTATION_REPAIR.md');
check(!q382Audit.includes('flutter analyze PASS'), 'Q382 audit doc must not contain exact fake analyze PASS phrase');
check(!q382Audit.includes('flutter test PASS'), 'Q382 audit doc must not contain exact fake test PASS phrase');
check(!q382Audit.includes('flutter run PASS'), 'Q382 audit doc must not contain exact fake run PASS phrase');

const androidManifest = read('android/app/src/main/AndroidManifest.xml');
check(androidManifest.includes('android.permission.INTERNET'), 'AndroidManifest must keep INTERNET for user-tapped model download');
check(!androidManifest.includes('READ_MEDIA_IMAGES'), 'AndroidManifest must not add READ_MEDIA_IMAGES');
check(!androidManifest.includes('usesCleartextTraffic="true"'), 'cleartext traffic must stay disabled');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(mainActivity.includes('q386RealPaddleOcrInferenceBridge'), 'Paddle bridge evidence path must remain present');
check(mainActivity.includes('q387R1NbArtifactReady'), '.nb readiness gate must remain present');
check(!mainActivity.includes('PaddleOCR('), 'MainActivity must not add PaddleOCR executable constructor');
check(!mainActivity.includes('OnnxRuntime('), 'MainActivity must not add OnnxRuntime executable constructor');
check(!mainActivity.includes('MobileConfig('), 'MainActivity must not add unguarded MobileConfig constructor');
check(!mainActivity.includes('loadModel('), 'MainActivity must not add direct loadModel call');
check(!mainActivity.includes('runInference('), 'MainActivity must not add direct runInference call');

const manifest = json('assets/mathlive/manifest.json');
const entry = manifest.v172Q389R5FOfflineStaleFlutterTestSweepClosure;
check(Boolean(entry), 'manifest Q389R5F entry missing');
check(entry.phase === 'V172-Q389R5F_OFFLINE', 'manifest Q389R5F phase mismatch');
check(entry.sourcePhase === 'V172-Q389R5E_OFFLINE', 'manifest Q389R5F source phase mismatch');
for (const key of ['backendAllowed', 'mlKitAllowed', 'textOcrFallbackAllowed', 'modelBundledInBaseApp', 'fakeLatexCandidateAllowed', 'ocrPassClaimedByPackage', 'androidRealDevicePassClaimedByPackage', 'flutterAnalyzePassClaimedByPackage', 'flutterTestPassClaimedByPackage']) {
  check(entry[key] === false, `manifest ${key} must be false`);
}
check(entry.legacyMetadataVersionRestoredInPubspec === true, 'manifest must record metadata version repair');
check(entry.q240ToQ247InternetPermissionGuardsMadeSuccessorAware === true, 'manifest must record INTERNET guard repair');
check(entry.q276Q277DependencyScansMadeLineAware === true, 'manifest must record Q276/Q277 dependency scan repair');
check(entry.q291HttpDependencyGuardMadeSuccessorAware === true, 'manifest must record Q291 http guard repair');
check(entry.graphHistoryAuditFakePassExactPhraseRemoved === true, 'manifest must record fake PASS exact phrase repair');
check(entry.q382KeyboardOrderingTouched === false, 'Q382 key ordering must remain untouched');
check(entry.graphHistorySolutionSolverTouched === false, 'Graph/History/Solution/Solver must remain untouched');

check(exists('docs/audit/V172_Q389R5F_OFFLINE_STALE_FLUTTER_TEST_SWEEP_CLOSURE.md'), 'Q389R5F audit doc missing');
check(exists('docs/audit/V172_Q389R5F_CHANGED_FILES.md'), 'Q389R5F changed files doc missing');
check(read('README.md').includes('V172-Q389R5F'), 'README Q389R5F section missing');

console.log('PASS verify_q389r5f_offline_stale_flutter_test_sweep_closure');
