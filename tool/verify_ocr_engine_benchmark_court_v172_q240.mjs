import fs from 'node:fs';
import crypto from 'node:crypto';

const errors = [];
const fail = (message) => errors.push(message);
const exists = (file) => fs.existsSync(file);
const read = (file) => fs.readFileSync(file, 'utf8');
const readJson = (file) => JSON.parse(read(file));
const sha = (file) => crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');

for (const required of [
  'lib/features/camera/gauss_ocr_engine_benchmark_court_policy.dart',
  'lib/features/camera/gauss_ocr_engine_benchmark_court.dart',
  'lib/features/camera/gauss_mathlive_ocr_review_surface.dart',
  'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart',
  'test/v172_q240_ocr_engine_benchmark_court_test.dart',
  'tool/verify_ocr_engine_benchmark_court_v172_q240.mjs',
  'docs/audit/V172_Q240_OCR_ENGINE_BENCHMARK_COURT_AUDIT.md',
  'docs/audit/V172_Q240_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
  'pubspec.yaml',
  'android/app/src/main/AndroidManifest.xml'
]) if (!exists(required)) fail(`missing Q240 required file: ${required}`);

const policy = read('lib/features/camera/gauss_ocr_engine_benchmark_court_policy.dart');
const court = read('lib/features/camera/gauss_ocr_engine_benchmark_court.dart');
const test = read('test/v172_q240_ocr_engine_benchmark_court_test.dart');
const pubspec = read('pubspec.yaml');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const cameraShell = read('lib/features/camera/gauss_camera_capture_shell.dart');
const reviewSurface = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');

for (const marker of [
  "phase = 'V172-Q240'",
  "fullPhase = 'V172-Q240-OCR-ENGINE-BENCHMARK-COURT-FOUNDATION'",
  'q239eMathLiveReviewSurfacePreserved = true',
  'q239dDeferredModelManagerPreserved = true',
  'benchmarkCourtContractImplemented = true',
  'candidateEngineRegistryImplemented = true',
  'benchmarkCaseTaxonomyImplemented = true',
  'scoringRubricContractImplemented = true',
  'winnerSelectionContractImplemented = true',
  'appRuntimeIsolationRequired = true',
  'desktopOrLabBenchmarkOnly = true',
  'mathLiveEditableReviewRemainsRequired = true',
  'deferredModelManagerWillUseWinnerOnly = true',
  'realOcrEngineAdded = false',
  'textOcrFallbackAdded = false',
  'paddleRuntimeAdded = false',
  'pix2TextRuntimeAdded = false',
  'texTellerRuntimeAdded = false',
  'uniMerNetRuntimeAdded = false',
  'onnxRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionModelUrlBound = false',
  'backgroundDownloadWorkerImplemented = false',
  'productionMathLiveBridgeCalled = false',
  'directWorkspaceImportImplemented = false',
  'directSolveFromCameraAllowed = false',
  'benchmarkWinnerSelected = false',
  'cameraShellRuntimeMutationAllowed = false',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'androidRealDeviceBenchmarkPassClaimedByAssistant = false'
]) if (!policy.includes(marker)) fail(`Q240 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussOcrBenchmarkEngineFamily',
  'ppFormulaNetS',
  'ppFormulaNetPlusS',
  'pix2TextMfrOnnx',
  'uniMerNetTiny',
  'texTeller',
  'ppFormulaNetPlusL',
  'class GaussOcrBenchmarkEngineDescriptor',
  'class GaussOcrBenchmarkCaseDescriptor',
  'class GaussOcrEngineBenchmarkCourt',
  'candidateEngines = <GaussOcrBenchmarkEngineDescriptor>',
  'PP-FormulaNet-S',
  'PP-FormulaNet_plus-S',
  'Pix2Text MFR ONNX',
  'UniMERNet tiny',
  'TexTeller',
  'PP-FormulaNet_plus-L',
  'requiredCases = <GaussOcrBenchmarkCaseDescriptor>',
  'definiteIntegral',
  'indefiniteIntegral',
  'derivativePrimeNotation',
  'derivativeLeibnizNotation',
  'fraction',
  'squareRoot',
  'sigma',
  'matrix',
  'simpleHandwriting',
  'lowLightCapture',
  'skewedCapture',
  'blurredCapture',
  'scoringDimensions = <String>',
  'latexExactness',
  'integralLimitPlacement',
  'derivativeNotationFidelity',
  'androidRuntimeBindingRisk',
  'hasEnoughCaseCoverage => requiredCases.length >= 18',
  'hasPrimaryAndFallbackCandidates => candidateEngines.length >= 6',
  'directSolveAllowed = false'
]) if (!court.includes(marker)) fail(`Q240 benchmark court missing marker: ${marker}`);

for (const marker of [
  'GaussOcrEngineBenchmarkCourtPolicy',
  'GaussOcrEngineBenchmarkCourt',
  'ppFormulaNetS',
  'pix2TextMfrOnnx',
  'definiteIntegral',
  'derivativeLeibnizNotation',
  'baseAppRuntimeBundled, isFalse',
  'productionReadyInQ240, isFalse',
  'directSolveAllowed, isFalse',
  'MathLive editable review'
]) if (!test.includes(marker)) fail(`Q240 test missing marker: ${marker}`);

const q240RuntimeFiles = `${cameraShell}\n${reviewSurface}`;
for (const forbidden of [
  'evaluateFromCamera',
  'solveFromCamera',
  'importToWorkspaceFromCamera',
  'setLatex',
  'MathLiveProductionEditorSurface',
  'HttpClient(',
  'http.Client',
  'DownloadManager',
  'WorkManager',
  'google_mlkit_text_recognition',
  'onnxruntime',
  'pix2text',
  'paddleocr'
]) if (q240RuntimeFiles.toLowerCase().includes(forbidden.toLowerCase())) {
  fail(`Q240 must not bind runtime/OCR/network/solver marker in camera runtime files: ${forbidden}`);
}

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
]) if (regex.test(pubspec)) fail(`Q240 must not add OCR/download/runtime dependency matching ${regex}`);

if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission from Q239B missing');
for (const forbidden of ['READ_MEDIA_IMAGES', 'READ_EXTERNAL_STORAGE', 'INTERNET']) {
  if (androidManifest.includes(forbidden)) fail(`Q240 must not add manifest permission marker: ${forbidden}`);
}

if (!readme.includes('## V172-Q240 — OCR Engine Benchmark Court Foundation')) fail('README missing Q240 section');
if (!readme.includes('The winner engine is not selected in Q240')) fail('README must state no winner selected in Q240');

const env = manifest.v172Q240OcrEngineBenchmarkCourt;
if (!env) fail('manifest missing v172Q240OcrEngineBenchmarkCourt envelope');
else {
  for (const [key, expected] of Object.entries({
    phase: 'V172-Q240',
    fullPhase: 'V172-Q240-OCR-ENGINE-BENCHMARK-COURT-FOUNDATION',
    q239eMathLiveReviewSurfacePreserved: true,
    q239dDeferredModelManagerPreserved: true,
    q239cCropScanFramePreserved: true,
    benchmarkCourtContractImplemented: true,
    candidateEngineRegistryImplemented: true,
    benchmarkCaseTaxonomyImplemented: true,
    scoringRubricContractImplemented: true,
    winnerSelectionContractImplemented: true,
    appRuntimeIsolationRequired: true,
    desktopOrLabBenchmarkOnly: true,
    mathLiveEditableReviewRemainsRequired: true,
    deferredModelManagerWillUseWinnerOnly: true,
    requiredBenchmarkCaseCount: 18,
    realOcrEngineAdded: false,
    textOcrFallbackAdded: false,
    paddleRuntimeAdded: false,
    pix2TextRuntimeAdded: false,
    texTellerRuntimeAdded: false,
    uniMerNetRuntimeAdded: false,
    onnxRuntimeAdded: false,
    modelBinaryBundledInBaseApp: false,
    productionModelUrlBound: false,
    backgroundDownloadWorkerImplemented: false,
    productionMathLiveBridgeCalled: false,
    directWorkspaceImportImplemented: false,
    directSolveFromCameraAllowed: false,
    benchmarkWinnerSelected: false,
    cameraShellRuntimeMutationAllowed: false,
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
    androidRealDeviceBenchmarkPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q240 ${key} expected ${expected} got ${env[key]}`);
  const engines = env.candidateEngines || [];
  for (const label of ['PP-FormulaNet-S', 'PP-FormulaNet_plus-S', 'Pix2Text MFR ONNX', 'UniMERNet tiny', 'TexTeller', 'PP-FormulaNet_plus-L']) {
    if (!engines.includes(label)) fail(`manifest Q240 candidate engine missing ${label}`);
  }
}

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
  'lib/app/gauss_splash_screen.dart': '465c3b70662673dbed283ef15cd7bbc22cba0402668e670da136aedfeb54ee81',
  'lib/features/workspace/workspace_panel.dart': '7e3c32f710b07b8fba3bd4223de650c71f334747644a41cfd0079ff7d49812b1',
  'pubspec.yaml': '97182bbfa14cace9cf1825ba75832e2da18e183279299a14fdfb578a0ad49304'
};
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) fail(`protected/red-line file missing: ${file}`);
  else {
    const actual = sha(file);
    if (actual !== expected) fail(`protected/red-line hash mismatch for ${file}: ${actual} expected ${expected}`);
  }
}

const report = {
  phase: 'V172-Q240',
  status: errors.length === 0
    ? 'OCR_ENGINE_BENCHMARK_COURT_Q240_STATIC_READY_BUT_REAL_ENGINE_BENCHMARK_AND_FLUTTER_RETEST_REQUIRED'
    : 'OCR_ENGINE_BENCHMARK_COURT_Q240_BLOCKED',
  errors,
  candidateEngineRegistryImplemented: true,
  benchmarkCaseTaxonomyImplemented: true,
  scoringRubricContractImplemented: true,
  realOcrEngineAdded: false,
  benchmarkWinnerSelected: false,
  directSolveFromCameraAllowed: false,
  protectedHashComparison: errors.some((e) => e.includes('protected/red-line')) ? 'FAILED' : 'PASS',
};

console.log(JSON.stringify(report, null, 2));
if (errors.length) process.exit(1);
