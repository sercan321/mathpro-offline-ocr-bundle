#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const exists = (rel) => fs.existsSync(p(rel));
const readJson = (rel) => JSON.parse(read(rel));
const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const fail = (message) => {
  console.error(`OCR_ENGINE_REAL_BENCHMARK_PACKAGE_Q246_FAIL: ${message}`);
  process.exit(1);
};

const phase = 'V172-Q246-OCR-ENGINE-REAL-BENCHMARK-PACKAGE';
const q245 = 'V172-Q245-CAMERA-REAL-DEVICE-EVIDENCE-CLOSURE';
const required = [
  'lib/features/camera/gauss_ocr_engine_real_benchmark_package_policy.dart',
  'lib/features/camera/gauss_ocr_engine_real_benchmark_package.dart',
  'test/v172_q246_ocr_engine_real_benchmark_package_test.dart',
  'tool/verify_ocr_engine_real_benchmark_package_v172_q246.mjs',
  'docs/audit/V172_Q246_OCR_ENGINE_REAL_BENCHMARK_PACKAGE_AUDIT.md',
  'docs/audit/V172_Q246_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/settings.gradle',
  'android/app/src/main/AndroidManifest.xml',
];
for (const rel of required) if (!exists(rel)) fail(`missing required Q246 file: ${rel}`);

const policy = read('lib/features/camera/gauss_ocr_engine_real_benchmark_package_policy.dart');
const pkg = read('lib/features/camera/gauss_ocr_engine_real_benchmark_package.dart');
const test = read('test/v172_q246_ocr_engine_real_benchmark_package_test.dart');
const verifier = read('tool/verify_ocr_engine_real_benchmark_package_v172_q246.mjs');
const audit = read('docs/audit/V172_Q246_OCR_ENGINE_REAL_BENCHMARK_PACKAGE_AUDIT.md');
const changed = read('docs/audit/V172_Q246_CHANGED_FILES.md');
const readme = read('README.md');
const manifest = readJson('assets/mathlive/manifest.json');
const q253ToolchainActive = manifest.androidToolchainModernizationLatestPhase === 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const cameraShell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const reviewSurface = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');

for (const marker of [
  phase,
  q245,
  "sourcePackageSha256 = '605d66f70049e4fb1d00c013263db238f2313492b0b62fcb52fa03a636b4ffcf'",
  'packageIsBenchmarkProtocolOnly = true',
  'benchmarkWinnerSelected = false',
  'realOcrRuntimeAdded = false',
  'textOcrFallbackRuntimeAdded = false',
  'paddleRuntimeAdded = false',
  'pix2TextRuntimeAdded = false',
  'onnxRuntimeAdded = false',
  'texTellerRuntimeAdded = false',
  'uniMerNetRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'backgroundDownloadWorkerImplemented = false',
  'productionInferenceAllowed = false',
  'cameraRuntimeShellChanged = false',
  'workspaceRuntimeChanged = false',
  'mathLiveProductionBridgeCalled = false',
  'directWorkspaceImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'directGraphFromCameraAllowed = false',
  'directSolutionFromCameraAllowed = false',
  'directHistoryFromCameraAllowed = false',
  'mathLiveEditableReviewRequiredBeforeImport = true',
  'deferredModelDownloadRequiredForWinner = true',
  'baseApkMustNotCarryModelBytes = true',
  'androidToolchainModernizationDeferredToQ253 = true',
  'cameraDependencyChanged = false',
  'androidSettingsGradleChanged = false',
  'androidManifestChanged = false',
  'mainActivityChanged = false',
  'keyboardMutationAllowed = false',
  'longPressMutationAllowed = false',
  'moreMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'graphMutationAllowed = false',
  'solutionMutationAllowed = false',
  'historyMutationAllowed = false',
  'splashLauncherMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
  'flutterRunPassClaimedByAssistant = false',
  'androidRealDeviceBenchmarkPassClaimedByAssistant = false',
  "nextPlannedPhase = 'V172-Q247-WINNER-ENGINE-SELECTION'",
]) if (!policy.includes(marker)) fail(`Q246 policy missing marker: ${marker}`);

for (const marker of [
  "import 'gauss_ocr_engine_benchmark_court.dart'",
  'class GaussOcrRealBenchmarkEngineProbe',
  'class GaussOcrRealBenchmarkImageCase',
  'class GaussOcrRealBenchmarkMetric',
  'class GaussOcrEngineRealBenchmarkPackage',
  'candidateProbes = <GaussOcrRealBenchmarkEngineProbe>',
  'PP-FormulaNet-S',
  'PP-FormulaNet_plus-S',
  'Pix2Text MFR ONNX',
  'UniMERNet tiny',
  'TexTeller',
  'PP-FormulaNet_plus-L',
  'requiredImageCases = <GaussOcrRealBenchmarkImageCase>',
  'Q246-FRAC-001',
  'Q246-RAD-001',
  'Q246-INT-001',
  'Q246-INT-002',
  'Q246-DER-001',
  'Q246-DER-002',
  'Q246-LIM-001',
  'Q246-SIG-001',
  'Q246-MAT-001',
  'Q246-HAND-001',
  'Q246-LOW-001',
  'Q246-SKEW-001',
  'Q246-BLUR-001',
  'metrics = <GaussOcrRealBenchmarkMetric>',
  'latexExactness',
  'structurePreservation',
  'latencyMs',
  'modelSizeBytes',
  'peakMemoryMb',
  'offlineAfterInstall',
  'licenseDistribution',
  'mathLiveReviewCompatibility',
  'rejectionRules = <String>',
  'reject any engine that requires cloud-only recognition for production camera OCR',
  'reject any engine that bypasses MathLive editable review',
  'hasAllCandidateFamilies => candidateProbes.length == 6',
  'hasEnoughRealImageCases => requiredImageCases.length >= 18',
  'canSelectWinnerInQ246 => false',
]) if (!pkg.includes(marker)) fail(`Q246 package missing marker: ${marker}`);

for (const marker of [
  'GaussOcrEngineRealBenchmarkPackagePolicy',
  'GaussOcrEngineRealBenchmarkPackage',
  'packageIsBenchmarkProtocolOnly, isTrue',
  'benchmarkWinnerSelected, isFalse',
  'realOcrRuntimeAdded, isFalse',
  'modelBinaryBundledInBaseApp, isFalse',
  'productionInferenceAllowed, isFalse',
  'mathLiveEditableReviewRequiredBeforeImport, isTrue',
  'canSelectWinnerInQ246, isFalse',
  'PP-FormulaNet-S',
  'PP-FormulaNet_plus-S',
  'Pix2Text MFR ONNX',
  'UniMERNet tiny',
  'TexTeller',
  'PP-FormulaNet_plus-L',
  'canWinWithoutRealImages, isFalse',
  'low light',
  'skewed camera angle',
  'mild blur',
]) if (!test.includes(marker)) fail(`Q246 test missing marker: ${marker}`);

for (const marker of [
  '## V172-Q246 OCR Engine Real Benchmark Package',
  'No OCR engine is selected in Q246',
  'Future camera OCR output must still pass through editable MathLive review before workspace import',
  'Android toolchain modernization remains deferred to Q253',
]) if (!readme.includes(marker)) fail(`README missing Q246 marker: ${marker}`);

for (const marker of [
  '# V172-Q246 OCR Engine Real Benchmark Package Audit',
  'Q246 does not add Text OCR fallback, PaddleOCR, Pix2Text, ONNX, TexTeller, UniMERNet',
  'Assistant-side Flutter/Dart/Android execution is unavailable',
]) if (!audit.includes(marker)) fail(`Q246 audit missing marker: ${marker}`);

for (const marker of [
  'lib/features/camera/gauss_ocr_engine_real_benchmark_package_policy.dart',
  'lib/features/camera/gauss_ocr_engine_real_benchmark_package.dart',
  'test/v172_q246_ocr_engine_real_benchmark_package_test.dart',
  'tool/verify_ocr_engine_real_benchmark_package_v172_q246.mjs',
]) if (!changed.includes(marker)) fail(`Q246 changed-files missing marker: ${marker}`);

if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('pubspec must preserve camera: 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('pubspec must preserve camera_android: 0.10.9+3');
if (/camera_android_camerax/.test(pubspec)) fail('Q246 must not reintroduce camera_android_camerax');
if (!settings.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) fail('settings.gradle must preserve Kotlin plugin 2.1.0');
if (!settings.includes("id 'com.android.application' version '8.3.2' apply false") && !(q253ToolchainActive && settings.includes("id 'com.android.application' version '8.6.1' apply false"))) {
  fail('settings.gradle must preserve AGP 8.3.2 for Q246 or move to 8.6.1 only through Q253 successor modernization');
}
if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission missing');
for (const forbidden of ['INTERNET', 'READ_MEDIA_IMAGES', 'READ_EXTERNAL_STORAGE']) {
  if (androidManifest.includes(forbidden)) fail(`Q246 must not add Android manifest permission: ${forbidden}`);
}
for (const regex of [
  /^\s*google_mlkit_text_recognition\s*:/m,
  /^\s*google_mlkit_commons\s*:/m,
  /^\s*paddle/m,
  /^\s*onnxruntime/m,
  /^\s*pix2text/m,
  /^\s*workmanager\s*:/m,
  /^\s*flutter_downloader\s*:/m,
  /^\s*http\s*:/m,
]) if (regex.test(pubspec)) fail(`Q246 must not add OCR/download/runtime dependency matching ${regex}`);

const runtimeJoined = `${cameraShell}\n${reviewSurface}`.toLowerCase();
for (const forbidden of [
  'evaluatefromcamera',
  'solvefromcamera',
  'importtoworkspacefromcamera',
  'mathliveproductioneditorsurface',
  'google_mlkit_text_recognition',
  'onnxruntime',
  'pix2text',
  'paddleocr',
  'httpclient(',
  'workmanager',
]) if (runtimeJoined.includes(forbidden)) fail(`Q246 must not mutate runtime OCR/solver marker in camera runtime files: ${forbidden}`);

const forbiddenExt = /\.(onnx|tflite|pdmodel|pdiparams|pth|pt|safetensors|mlmodel|bin)$/i;
const stack = ['.'];
while (stack.length) {
  const cur = stack.pop();
  for (const ent of fs.readdirSync(p(cur), { withFileTypes: true })) {
    const rel = path.join(cur, ent.name).replace(/^\.\//, '');
    if (rel.startsWith('.git') || rel.startsWith('build') || rel.startsWith('.dart_tool')) continue;
    if (ent.isDirectory()) stack.push(rel);
    else if (forbiddenExt.test(ent.name)) fail(`Q246 must not bundle model/binary artifact: ${rel}`);
  }
}

if (manifest.ocrEngineRealBenchmarkPackageLatestPhase !== phase) fail('manifest latest Q246 phase missing');
const env = manifest.v172Q246OcrEngineRealBenchmarkPackage;
if (!env || env.phase !== phase) fail('manifest Q246 envelope missing');
for (const [key, expected] of Object.entries({
  closesOverPhase: q245,
  sourcePackageSha256: '605d66f70049e4fb1d00c013263db238f2313492b0b62fcb52fa03a636b4ffcf',
  packageIsBenchmarkProtocolOnly: true,
  requiredRealImageCaseCount: 18,
  benchmarkWinnerSelected: false,
  realOcrRuntimeAdded: false,
  textOcrFallbackRuntimeAdded: false,
  paddleRuntimeAdded: false,
  pix2TextRuntimeAdded: false,
  onnxRuntimeAdded: false,
  texTellerRuntimeAdded: false,
  uniMerNetRuntimeAdded: false,
  modelBinaryBundledInBaseApp: false,
  productionModelUrlBound: false,
  backgroundDownloadWorkerImplemented: false,
  productionInferenceAllowed: false,
  cameraRuntimeShellChanged: false,
  workspaceRuntimeChanged: false,
  mathLiveProductionBridgeCalled: false,
  directWorkspaceImportImplemented: false,
  directSolveFromCameraAllowed: false,
  directGraphFromCameraAllowed: false,
  directSolutionFromCameraAllowed: false,
  directHistoryFromCameraAllowed: false,
  mathLiveEditableReviewRequiredBeforeImport: true,
  deferredModelDownloadRequiredForWinner: true,
  baseApkMustNotCarryModelBytes: true,
  androidToolchainModernizationDeferredToQ253: true,
  cameraDependencyChanged: false,
  androidSettingsGradleChanged: false,
  androidManifestChanged: false,
  mainActivityChanged: false,
  keyboardMutationAllowed: false,
  longPressMutationAllowed: false,
  moreMutationAllowed: false,
  mathLiveProductionMutationAllowed: false,
  graphMutationAllowed: false,
  solutionMutationAllowed: false,
  historyMutationAllowed: false,
  splashLauncherMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  flutterRunPassClaimedByAssistant: false,
  androidRealDeviceBenchmarkPassClaimedByAssistant: false,
  nextPlannedPhase: 'V172-Q247-WINNER-ENGINE-SELECTION',
})) if (env[key] !== expected) fail(`manifest Q246 ${key} expected ${expected} got ${env[key]}`);
for (const label of ['PP-FormulaNet-S','PP-FormulaNet_plus-S','Pix2Text MFR ONNX','UniMERNet tiny','TexTeller','PP-FormulaNet_plus-L']) {
  if (!env.candidateFamilies?.includes(label)) fail(`manifest Q246 candidate missing ${label}`);
}
for (const gate of ['latexExactness','structurePreservation','latencyMs','modelSizeBytes','peakMemoryMb','offlineAfterInstall','licenseDistribution','mathLiveReviewCompatibility']) {
  if (!env.hardGateMetrics?.includes(gate)) fail(`manifest Q246 hard gate missing ${gate}`);
}
for (const rel of [
  'lib/features/camera/gauss_ocr_engine_real_benchmark_package_policy.dart',
  'lib/features/camera/gauss_ocr_engine_real_benchmark_package.dart',
  'test/v172_q246_ocr_engine_real_benchmark_package_test.dart',
  'tool/verify_ocr_engine_real_benchmark_package_v172_q246.mjs',
  'docs/audit/V172_Q246_OCR_ENGINE_REAL_BENCHMARK_PACKAGE_AUDIT.md',
  'docs/audit/V172_Q246_CHANGED_FILES.md',
]) if (!env.changedFiles?.includes(rel)) fail(`manifest Q246 changedFiles missing ${rel}`);

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
  'lib/features/graph/graph_card.dart': '124accae8499c2dbc8cb6e1dde3a2317dfaafad576363aecebd5f78c94f22b6f',
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
  'android/app/src/main/AndroidManifest.xml': '4fe91898ddf5ff94af1527314c8977806f23b051b7de078f25604dfa4731c1a6',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt': 'c27aa8777ba2a3b33bc15d839b2b05bb35f9f6a09f4c5c8de0e39365f65dacf1',
  'lib/app/gauss_splash_screen.dart': '465c3b70662673dbed283ef15cd7bbc22cba0402668e670da136aedfeb54ee81',
  'lib/features/workspace/workspace_panel.dart': '7e3c32f710b07b8fba3bd4223de650c71f334747644a41cfd0079ff7d49812b1',
  'pubspec.yaml': '97182bbfa14cace9cf1825ba75832e2da18e183279299a14fdfb578a0ad49304',
  'android/settings.gradle': '13fddb7fda0628619eb9341fa53c40b6e360b56a515464cd4148ddb6d56f1666',
};
for (const [rel, expected] of Object.entries(protectedHashes)) {
  if (!exists(rel)) fail(`protected/red-line file missing: ${rel}`);
  const actual = sha(rel);
  if (rel === 'android/settings.gradle' && q253ToolchainActive) {
    const q253Expected = 'c492170c6368a6191d77de61153abe3d1265949213e8392def93a8038575be30';
    if (actual !== expected && actual !== q253Expected) fail(`protected/red-line hash mismatch for ${rel}: ${actual} expected ${expected} or ${q253Expected}`);
    continue;
  }
  if (actual !== expected) fail(`protected/red-line hash mismatch for ${rel}: ${actual} expected ${expected}`);
}

if (!verifier.includes('OCR_ENGINE_REAL_BENCHMARK_PACKAGE_Q246_STATIC_READY_BUT_REAL_BENCHMARK_AND_FLUTTER_RETEST_REQUIRED')) {
  fail('Q246 verifier terminal marker missing');
}

console.log(JSON.stringify({
  phase,
  status: 'OCR_ENGINE_REAL_BENCHMARK_PACKAGE_Q246_STATIC_READY_BUT_REAL_BENCHMARK_AND_FLUTTER_RETEST_REQUIRED',
  candidateFamilies: env.candidateFamilies.length,
  requiredRealImageCaseCount: env.requiredRealImageCaseCount,
  realOcrRuntimeAdded: false,
  benchmarkWinnerSelected: false,
  protectedHashComparison: 'PASS',
}, null, 2));
