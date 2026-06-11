#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const phase = 'V172-Q277R1-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-FLUTTER-LOG-REPAIR';
const sourcePhase = 'V172-Q277-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION';
const q277r2SuccessorPhase = 'V172-Q277R2-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-ANALYZER-HYGIENE';
const q277r3SuccessorPhase = 'V172-Q277R3-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-TAP-LATENCY-CADENCE';
const q278SuccessorPhase = 'V172-Q278-REAL-RUNTIME-INTEGRATION-EVIDENCE-LOCK';
const q279SuccessorPhase = 'V172-Q279-SELECTED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q280SuccessorPhase = 'V172-Q280-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-BEHIND-FLAG';
const q281SuccessorPhase = 'V172-Q281-PRIVATE-ARTIFACT-LOAD-REAL-SMOKE';
const q282SuccessorPhase = 'V172-Q282-FIRST-REAL-RUNTIME-SMOKE-ON-DEVICE';
const q283SuccessorPhase = 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT';
const q284SuccessorPhase = 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING';
const q285SuccessorPhase = 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT';
const allowedLatestPhases = [phase, q277r2SuccessorPhase, q277r3SuccessorPhase];
const q286SuccessorPhase = 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION';
const q287SuccessorPhase = 'V172-Q287-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT';
const q287r1SuccessorPhase = 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR';
const allowedCameraOcrLatestPhases = [phase, q277r2SuccessorPhase, q277r3SuccessorPhase, q278SuccessorPhase, q279SuccessorPhase, q280SuccessorPhase, q281SuccessorPhase, q282SuccessorPhase, q283SuccessorPhase, q284SuccessorPhase, q285SuccessorPhase, q286SuccessorPhase, q287SuccessorPhase, q287r1SuccessorPhase];

function fail(message) {
  console.error(`CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_Q277R1_BLOCKED: ${message}`);
  process.exit(1);
}
function read(filePath) {
  if (!fs.existsSync(filePath)) fail(`missing file: ${filePath}`);
  return fs.readFileSync(filePath, 'utf8');
}
function sha(filePath) {
  return crypto.createHash('sha256').update(fs.readFileSync(filePath)).digest('hex');
}
function walk(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full, out);
    else out.push(full.replaceAll('\\', '/'));
  }
  return out;
}
function countOccurrences(haystack, needle) {
  let count = 0;
  let offset = 0;
  while (true) {
    const index = haystack.indexOf(needle, offset);
    if (index === -1) return count;
    count += 1;
    offset = index + needle.length;
  }
}

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const reviewSurface = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
const deferredRuntime = read('lib/features/camera/gauss_deferred_model_download_runtime.dart');
const q277Verifier = read('tool/verify_camera_ocr_runtime_premium_regression_v172_q277.mjs');
const q277r1Test = read('test/v172_q277r1_camera_ocr_runtime_premium_regression_log_repair_test.dart');
const audit = read('docs/audit/V172_Q277R1_CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_FLUTTER_LOG_REPAIR_AUDIT.md');
const changed = read('docs/audit/V172_Q277R1_CHANGED_FILES.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml').toLowerCase();
const settings = read('android/settings.gradle');
const appBuild = read('android/app/build.gradle');
const gradleWrapper = read('android/gradle/wrapper/gradle-wrapper.properties');

if (!allowedCameraOcrLatestPhases.includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q277R1 or Q277R2/Q277R3/Q278/Q279 successor through Q287R1');
if (!allowedLatestPhases.includes(manifest.cameraOcrRuntimePremiumRegressionLatestPhase)) fail('manifest runtime premium regression latest marker must point to Q277R1 or Q277R2/Q277R3/Q278/Q279 successor through Q287R1');
const q277 = manifest.v172Q277CameraOcrRuntimePremiumRegression;
if (!q277 || q277.phase !== sourcePhase) fail('Q277 source envelope missing');
const q277r1 = manifest.v172Q277R1CameraOcrRuntimePremiumRegressionFlutterLogRepair;
if (!q277r1 || q277r1.phase !== phase) fail('Q277R1 manifest envelope missing');
if (q277r1.sourcePhase !== sourcePhase) fail('Q277R1 source phase mismatch');
if (q277r1.repairMode !== 'real-user-flutter-analyze-test-log-repair-only-no-runtime-no-inference-no-pass-claim') fail('Q277R1 repair mode mismatch');

for (const marker of [
  'misplacedDuplicateGaussMathLiveOcrReviewDraftFromQ250ImportFactory',
  'q239dReviewSafetyCopyAssertionRestored',
  'buildUnitTestAssetManifestBinIgnoredByHistoricalModelArtifactScans',
  'gaussDeferredModelDownloadRuntimePreferConstInfoCleaned',
]) {
  if (!q277r1.realLogIssuesRepaired.includes(marker)) fail(`Q277R1 issue marker missing: ${marker}`);
}
for (const key of [
  'protectedRuntimeSurfacesUnchanged',
]) {
  if (q277r1[key] !== true) fail(`Q277R1 ${key} must be true`);
}
for (const key of [
  'keyboardLayoutChanged',
  'moreTemplateTrayChanged',
  'longPressListsChanged',
  'mathLiveProductionRouteChanged',
  'legacyFlutterCursorRouteReintroduced',
  'graphSolutionHistoryRuntimeChanged',
  'cameraShellRuntimeChanged',
  'solverEvaluatorChanged',
  'realOcrRuntimeAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'nativeBridgeImplementationAdded',
  'jniBindingAdded',
  'methodChannelRuntimeBindingAdded',
  'modelBinaryBundledInBaseApp',
  'productionModelUrlBound',
  'realNetworkDownloadWorkerImplemented',
  'realImageToLatexInferenceExecuted',
  'flutterAnalyzePassClaimed',
  'flutterTestPassClaimed',
  'flutterRunPassClaimed',
  'androidRealDevicePassClaimed',
  'cameraPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'ocrPassClaimed',
  'premiumFinalPassClaimed',
  'releasePassClaimed',
]) {
  if (q277r1[key] !== false) fail(`Q277R1 ${key} must be false`);
}

const factoryMarker = 'factory GaussMathLiveOcrReviewDraft.fromQ250Import';
if (countOccurrences(reviewSurface, factoryMarker) !== 1) fail('Q250 review draft factory must appear exactly once');
const sheetStart = reviewSurface.indexOf('class GaussMathLiveOcrReviewSheet extends StatelessWidget');
if (sheetStart < 0) fail('review sheet class missing');
const sheetBody = reviewSurface.slice(sheetStart);
if (sheetBody.includes(factoryMarker)) fail('Q250 draft factory must not be inside GaussMathLiveOcrReviewSheet');
if (!reviewSurface.includes('Gerçek OCR adayı gelmeden workspace aktarımı')) fail('Q239D safety phrase not restored');
if (!reviewSurface.includes('kullanıcı onayı olmadan import hazırlanmaz')) fail('user approval safety copy missing');
if (!deferredRuntime.includes('return const GaussDeferredModelReadinessResult(\n      phase: phase,\n      decision: GaussDeferredModelReadinessDecision.readyForFutureQ249AdapterOnly')) fail('prefer_const constructor repair missing');
if (deferredRuntime.includes('issues: const <String>[],')) fail('Q277R2 successor through Q287R1 must remove the remaining unnecessary_const analyzer info');

const repairedTests = [
  'test/v172_q252_camera_ocr_premium_final_regression_test.dart',
  'test/v172_q254_pp_formulanet_s_runtime_source_evidence_test.dart',
  'test/v172_q256_pp_formulanet_s_artifact_manifest_sha_lock_test.dart',
  'test/v172_q257_pp_formulanet_s_download_orchestrator_ui_guard_test.dart',
  'test/v172_q258_pp_formulanet_s_production_artifact_resolver_gate_test.dart',
  'test/v172_q259_pp_formulanet_s_real_download_worker_dry_run_test.dart',
  'test/v172_q260_pp_formulanet_s_real_model_download_integration_gate_test.dart',
  'test/v172_q261_pp_formulanet_s_runtime_feasibility_adapter_test.dart',
  'test/v172_q262_pp_formulanet_s_runtime_prototype_bridge_gate_test.dart',
  'test/v172_q263_pp_formulanet_s_runtime_prototype_smoke_evidence_template_test.dart',
];
for (const testPath of repairedTests) {
  const text = read(testPath);
  if (!text.includes("file.path.replaceAll('\\\\', '/')")) fail(`path normalization missing in ${testPath}`);
  if (!text.includes("!normalizedPath.contains('/build/')")) fail(`build exclusion missing in ${testPath}`);
  if (!text.includes("!normalizedPath.contains('/.dart_tool/')")) fail(`dart_tool exclusion missing in ${testPath}`);
}

for (const marker of [phase, 'Flutter Log Repair', 'no runtime', 'no inference']) {
  if (!audit.includes(marker) && !changed.includes(marker) && !readme.includes(marker) && !q277r1Test.includes(marker)) fail(`Q277R1 marker missing: ${marker}`);
}
if (!q277Verifier.includes('q277r1SuccessorPhase')) fail('Q277 verifier must be Q277R1 successor through Q287R1-aware');
if (!q277Verifier.includes('q277r2SuccessorPhase')) fail('Q277 verifier must be Q277R2 successor through Q287R1-aware');

for (const forbidden of [
  'paddleocr',
  'paddle_ocr',
  'paddle_flutter',
  'paddle_lite',
  'google_mlkit_text_recognition',
  'onnxruntime',
  'tesseract',
  'pix2text',
  'flutter_downloader',
  'background_downloader',
  'dio',
]) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q277R1');
if (!settings.includes("com.android.application' version '8.6.1'")) fail('AGP must remain 8.6.1');
if (!settings.includes("org.jetbrains.kotlin.android' version '2.1.0'")) fail('Kotlin plugin must remain 2.1.0');
if (!gradleWrapper.includes('gradle-8.7-bin.zip')) fail('Gradle wrapper must remain 8.7');
if (!appBuild.includes('JavaVersion.VERSION_17') || !appBuild.includes("jvmTarget = '17'")) fail('Java/Kotlin target must remain 17');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors'];
for (const file of walk('.')) {
  const base = path.basename(file).toLowerCase();
  if (file.includes('/.git/') || file.includes('/.dart_tool/') || file.includes('/build/') || file.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/runtime binary must not be bundled in Q277R1: ${file}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q277R1: ${file}`);
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
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'd9110c8d0018758216b1e9967bbd422cd97559d923cfc090e6677514da0d1c99',
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
  'android/settings.gradle': 'c492170c6368a6191d77de61153abe3d1265949213e8392def93a8038575be30',
  'android/gradle/wrapper/gradle-wrapper.properties': '797ea7d637b36ce5ccff6559a427ae97077073c7992883469e6ecb523fea2b97',
  'android/app/build.gradle': '5533186d6120cb1c8d5c976e2f13f2505d395721d03f6025138fdf96ac3c3ecb',
  'lib/features/camera/gauss_camera_capture_shell.dart': '92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51',
};
for (const [filePath, expected] of Object.entries(protectedHashes)) {
  if (!fs.existsSync(filePath)) fail(`protected path missing: ${filePath}`);
  const actual = sha(filePath);
  if (actual !== expected) fail(`protected hash changed for ${filePath}`);
}

console.log(JSON.stringify({
  phase,
  status: 'CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_Q277R1_LOG_REPAIR_STATIC_READY_BUT_USER_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  repairedIssues: q277r1.realLogIssuesRepaired.length,
  protectedHashComparison: 'PASS',
  realOcrRuntimeAdded: q277r1.realOcrRuntimeAdded,
  paddleRuntimeAdded: q277r1.paddleRuntimeAdded,
  modelBinaryBundledInBaseApp: q277r1.modelBinaryBundledInBaseApp,
  ocrPassClaimed: q277r1.ocrPassClaimed,
  requiresUserSideRetest: q277r1.requiresUserSideRetest,
}, null, 2));
