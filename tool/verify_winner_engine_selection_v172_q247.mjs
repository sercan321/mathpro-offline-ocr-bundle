import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const rel = (p) => path.join(root, p);
const exists = (p) => fs.existsSync(rel(p));
const read = (p) => fs.readFileSync(rel(p), 'utf8');
const sha = (p) => crypto.createHash('sha256').update(fs.readFileSync(rel(p))).digest('hex');
const fail = (message) => {
  console.error(`WINNER_ENGINE_SELECTION_Q247_FAIL: ${message}`);
  process.exit(1);
};

const phase = 'V172-Q247-WINNER-ENGINE-SELECTION';
const q246 = 'V172-Q246-OCR-ENGINE-REAL-BENCHMARK-PACKAGE';
const required = [
  'lib/features/camera/gauss_winner_engine_selection_policy.dart',
  'lib/features/camera/gauss_winner_engine_selection.dart',
  'test/v172_q247_winner_engine_selection_test.dart',
  'tool/verify_winner_engine_selection_v172_q247.mjs',
  'docs/audit/V172_Q247_WINNER_ENGINE_SELECTION_AUDIT.md',
  'docs/audit/V172_Q247_CHANGED_FILES.md',
  'assets/mathlive/manifest.json',
  'README.md',
];
for (const p of required) if (!exists(p)) fail(`missing required Q247 file: ${p}`);

const policy = read('lib/features/camera/gauss_winner_engine_selection_policy.dart');
const selection = read('lib/features/camera/gauss_winner_engine_selection.dart');
const test = read('test/v172_q247_winner_engine_selection_test.dart');
const manifestText = read('assets/mathlive/manifest.json');
const manifest = JSON.parse(manifestText);
const q253ToolchainActive = manifest.androidToolchainModernizationLatestPhase === 'V172-Q253-ANDROID-TOOLCHAIN-MODERNIZATION';
const readme = read('README.md');
const audit = read('docs/audit/V172_Q247_WINNER_ENGINE_SELECTION_AUDIT.md');
const changed = read('docs/audit/V172_Q247_CHANGED_FILES.md');
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

for (const marker of [
  phase,
  q246,
  'sourcePackageSha256',
  'winnerSelectionGateImplemented = true',
  'realBenchmarkEvidenceRequired = true',
  'externalLabReportRequired = true',
  'minimumCaseCoverageRequired = 30',
  'mathLiveEditableReviewRequired = true',
  'deferredModelDownloadStillRequired = true',
  'baseApkMustNotCarryModelBytes = true',
  'plainTextOcrFallbackDisabled = true',
  'primaryFormulaRecognizerRequired = true',
  'noWinnerSelectedWithoutRealBenchmark = true',
  'benchmarkWinnerSelected = false',
  "selectedWinnerEngineLabel = 'none'",
  'realOcrRuntimeAdded = false',
  'modelBinaryBundledInBaseApp = false',
  'productionRuntimeBindingAllowed = false',
  'directSolveFromCameraAllowed = false',
  'androidToolchainModernizationDeferredToQ253 = true',
  'flutterAnalyzePassClaimedByAssistant = false',
  'nextPlannedPhase',
]) if (!policy.includes(marker)) fail(`Q247 policy missing marker: ${marker}`);

for (const marker of [
  'enum GaussWinnerEngineSelectionDecision',
  'blockedNoRealBenchmarkReport',
  'blockedPlainTextOcrFallbackPrimaryClaim',
  'eligibleForQ248DeferredModelDownloadPlanning',
  'maxDeferredDownloadModelSizeBytes = 160 * 1024 * 1024',
  'maxMedianLatencyMs = 1800',
  'minimumRealSampleCount = 30',
  'PP-FormulaNet-S',
  'PP-FormulaNet_plus-S',
  'Pix2Text MFR ONNX',
  'UniMERNet tiny',
  'TexTeller',
  'PP-FormulaNet_plus-L',
  'mayBePrimaryFormulaRecognizer: false',
  'fallback for simple text only',
  'requiredEvidenceArtifacts',
  'evaluateEvidence',
  'direct solve/evaluate from camera OCR is unsafe',
  'benchmarkWinnerSelected: false',
  'productionRuntimeBindingAllowed: false',
]) if (!selection.includes(marker)) fail(`Q247 selection missing marker: ${marker}`);

for (const marker of [
  'V172-Q247-WINNER-ENGINE-SELECTION',
  'noWinnerSelectedWithoutRealBenchmark, isTrue',
  'selectedWinnerEngineLabel, \'none\'',
  'canBindRuntimeInQ247, isFalse',
  'PP-FormulaNet_plus-L',
  'blockedNoRealBenchmarkReport',
  'blockedUnsafeDirectSolve',
  'blockedPlainTextOcrFallbackPrimaryClaim',
  'eligibleForQ248DeferredModelDownloadPlanning',
  'camera: 0.10.6',
  'camera_android',
]) if (!test.includes(marker)) fail(`Q247 test missing marker: ${marker}`);

if (manifest.winnerEngineSelectionLatestPhase !== phase) fail('manifest latest Q247 phase missing');
const env = manifest.v172Q247WinnerEngineSelection;
if (!env || env.phase !== phase) fail('manifest Q247 envelope missing');
for (const [key, expected] of Object.entries({
  closesOverPhase: q246,
  sourcePackageSha256: 'a7c58a1cb90583a6e0ae0bd6cf6790107ade1fb4664a7a67437538b190c55330',
  q246RealBenchmarkPackagePreserved: true,
  winnerSelectionGateImplemented: true,
  realBenchmarkEvidenceRequired: true,
  externalLabReportRequired: true,
  q240r3IntakeGateRequired: true,
  minimumCaseCoverageRequired: 30,
  mathLiveEditableReviewRequired: true,
  deferredModelDownloadStillRequired: true,
  baseApkMustNotCarryModelBytes: true,
  plainTextOcrFallbackDisabled: true,
  primaryFormulaRecognizerRequired: true,
  noWinnerSelectedWithoutRealBenchmark: true,
  benchmarkWinnerSelected: false,
  selectedWinnerEngineLabel: 'none',
  selectedFallbackEngineLabel: 'none',
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
  productionRuntimeBindingAllowed: false,
  cameraRuntimeShellChanged: false,
  workspaceRuntimeChanged: false,
  mathLiveProductionBridgeCalled: false,
  directWorkspaceImportImplemented: false,
  directSolveFromCameraAllowed: false,
  directGraphFromCameraAllowed: false,
  directSolutionFromCameraAllowed: false,
  directHistoryFromCameraAllowed: false,
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
  realEngineAccuracyPassClaimedByAssistant: false,
  nextPlannedPhase: 'V172-Q248-DEFERRED-MODEL-DOWNLOAD-RUNTIME',
})) if (env[key] !== expected) fail(`manifest Q247 ${key} expected ${expected} got ${env[key]}`);

for (const label of ['PP-FormulaNet-S','PP-FormulaNet_plus-S','Pix2Text MFR ONNX','UniMERNet tiny','TexTeller','PP-FormulaNet_plus-L']) {
  if (!env.candidateFamilies?.includes(label)) fail(`manifest Q247 candidate missing ${label}`);
}
if (!Array.isArray(env.disabledFallbackFamilies) || env.disabledFallbackFamilies.length !== 0) fail('manifest Q247 disabledFallbackFamilies must be empty');
for (const artifact of ['externalLabReportJson','reportSha256','fixtureManifestSha256','caseLevelExpectedVsActualLatexDiffs','offlineAfterInstallProof','licenseDistributionNote','mathLiveEditableReviewCompatibilityProof']) {
  if (!env.requiredEvidenceArtifacts?.includes(artifact)) fail(`manifest Q247 requiredEvidenceArtifacts missing ${artifact}`);
}
for (const gate of ['realBenchmarkReport','minimumSampleCount','mathLiveReviewRequired','directSolveBlocked','licenseClearedForDistribution','offlineAfterInstallProven','deferredModelSizeBudget','medianLatencyBudget','plainTextOcrFallbackDisabled']) {
  if (!env.hardSelectionGates?.includes(gate)) fail(`manifest Q247 hardSelectionGates missing ${gate}`);
}
for (const rel of required) {
  if (!env.changedFiles?.includes(rel)) fail(`manifest Q247 changedFiles missing ${rel}`);
}

for (const marker of [
  '## V172-Q247 Winner Engine Selection',
  'does **not** claim that a production OCR winner has been selected',
  'PP-FormulaNet_plus-L',
  'No OCR runtime is added in Q247',
  'Android toolchain modernization remains deferred to Q253',
]) if (!readme.includes(marker)) fail(`README missing Q247 marker: ${marker}`);

for (const marker of [
  '# V172-Q247 Winner Engine Selection Audit',
  'does not claim or bind a winner',
  'PP-FormulaNet_plus-L',
  'Q247 does not add plain text OCR fallback, PaddleOCR, Pix2Text, ONNX, TexTeller, UniMERNet',
  'Q247 does not claim real OCR accuracy',
]) if (!audit.includes(marker)) fail(`Q247 audit missing marker: ${marker}`);
for (const marker of [
  '# V172-Q247 Changed Files',
  'gauss_winner_engine_selection_policy.dart',
  'verify_winner_engine_selection_v172_q247.mjs',
  'Protected Runtime Surfaces',
]) if (!changed.includes(marker)) fail(`Q247 changed-files missing marker: ${marker}`);

if (!/^\s*camera\s*:\s*0\.10\.6\s*$/m.test(pubspec)) fail('pubspec must keep camera: 0.10.6');
if (!/^\s*camera_android\s*:\s*0\.10\.9\+3\s*$/m.test(pubspec)) fail('pubspec must keep camera_android: 0.10.9+3');
if (/camera_android_camerax/.test(pubspec)) fail('Q247 must not reintroduce camera_android_camerax');
if (!settings.includes("id 'org.jetbrains.kotlin.android' version '2.1.0' apply false")) fail('Q247 must keep Kotlin plugin 2.1.0');
if (!settings.includes("id 'com.android.application' version '8.3.2' apply false") && !(q253ToolchainActive && settings.includes("id 'com.android.application' version '8.6.1' apply false"))) {
  fail('AGP must remain 8.3.2 for Q247 or move to 8.6.1 only through Q253 successor modernization');
}
if (!androidManifest.includes('<uses-permission android:name="android.permission.CAMERA" />')) fail('Android CAMERA permission missing');
for (const forbidden of ['READ_MEDIA_IMAGES', 'READ_EXTERNAL_STORAGE', 'INTERNET']) {
  if (androidManifest.includes(forbidden)) fail(`Q247 must not add Android manifest permission: ${forbidden}`);
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
]) if (regex.test(pubspec)) fail(`Q247 must not add OCR/download/runtime dependency matching ${regex}`);

const runtimeFiles = [
  'lib/features/camera/gauss_camera_capture_shell.dart',
  'lib/features/camera/gauss_mathlive_ocr_review_surface.dart',
  'lib/features/workspace/workspace_panel.dart',
  'lib/app/app_shell.dart',
  'assets/mathlive/mathlive_prod_bridge.js',
].map(read).join('\n');
for (const forbidden of [
  'runOcrEngine(',
  'setWorkspaceLatexWithoutReview',
  'evaluateFromCamera',
  'graphFromCamera',
  'writeHistoryFromCamera',
  'solveFromCamera',
  'downloadModelNow',
]) if (runtimeFiles.includes(forbidden)) fail(`Q247 must not mutate runtime OCR/solver marker: ${forbidden}`);

const forbiddenExt = /\.(onnx|tflite|pt|pth|pdmodel|pdiparams|bin)$/i;
const walk = (dir) => {
  for (const name of fs.readdirSync(dir)) {
    const p = path.join(dir, name);
    const st = fs.statSync(p);
    const relative = path.relative(root, p).replaceAll('\\\\', '/');
    if (st.isDirectory()) {
      if (['.dart_tool','build','.gradle','node_modules','.idea','__pycache__'].includes(name)) fail(`forbidden generated directory present: ${relative}`);
      walk(p);
    } else if (forbiddenExt.test(name)) fail(`Q247 must not bundle model/binary artifact: ${relative}`);
  }
};
walk(root);

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
  'lib/features/camera/gauss_camera_capture_shell.dart': '92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51',
};
for (const [p, expected] of Object.entries(protectedHashes)) {
  if (!exists(p)) fail(`protected file missing: ${p}`);
  const actual = sha(p);
  if (p === 'android/settings.gradle' && q253ToolchainActive) {
    const q253Expected = 'c492170c6368a6191d77de61153abe3d1265949213e8392def93a8038575be30';
    if (actual !== expected && actual !== q253Expected) fail(`protected hash mismatch for ${p}: ${actual} expected ${expected} or ${q253Expected}`);
    continue;
  }
  if (actual !== expected) fail(`protected hash mismatch for ${p}: ${actual} expected ${expected}`);
}

console.log(JSON.stringify({
  phase,
  status: 'WINNER_ENGINE_SELECTION_Q247_STATIC_READY_BUT_REAL_BENCHMARK_AND_FLUTTER_RETEST_REQUIRED',
  benchmarkWinnerSelected: false,
  realOcrRuntimeAdded: false,
  modelBinaryBundledInBaseApp: false,
  candidateFamilies: env.candidateFamilies.length,
  hardSelectionGates: env.hardSelectionGates.length,
  protectedHashComparison: 'PASS',
}, null, 2));
