#!/usr/bin/env node
// Successor-aware through V172-Q303-RUNTIME-DEPENDENCY-REAL-TRIAL-DEFAULT-OFF
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const q316SuccessorPhase = 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q317SuccessorPhase = 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG';
const q318SuccessorPhase = 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION';
const phase = 'V172-Q277R3-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-TAP-LATENCY-CADENCE';
const q309SuccessorPhase = 'V172-Q309-DUMMY-INPUT-REAL-RUNTIME-CALL-GATE';
const q310SuccessorPhase = 'V172-Q310-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GATE';
const sourcePhase = 'V172-Q277R2-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION-ANALYZER-HYGIENE';
const q278SuccessorPhase = 'V172-Q278-REAL-RUNTIME-INTEGRATION-EVIDENCE-LOCK';
const q279SuccessorPhase = 'V172-Q279-SELECTED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q280SuccessorPhase = 'V172-Q280-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-BEHIND-FLAG';
const q281SuccessorPhase = 'V172-Q281-PRIVATE-ARTIFACT-LOAD-REAL-SMOKE';
const q282SuccessorPhase = 'V172-Q282-FIRST-REAL-RUNTIME-SMOKE-ON-DEVICE';
const q283SuccessorPhase = 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT';
const q284SuccessorPhase = 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING';
const q285SuccessorPhase = 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT';
const q277r2SuccessorVerifierAware = true;

function fail(message) {
  console.error(`CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_Q277R3_BLOCKED: ${message}`);
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

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const policy = read('lib/features/mathlive/mathlive_production_tap_latency_cadence_policy.dart');
const mainSurface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const productionSurface = read('lib/features/mathlive/mathlive_production_editor_surface.dart');
const prodBridge = read('assets/mathlive/mathlive_prod_bridge.js');
const test = read('test/v172_q277r3_camera_ocr_runtime_premium_regression_tap_latency_cadence_test.dart');
const audit = read('docs/audit/V172_Q277R3_CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_TAP_LATENCY_CADENCE_AUDIT.md');
const changed = read('docs/audit/V172_Q277R3_CHANGED_FILES.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml').toLowerCase();
const settings = read('android/settings.gradle');
const appBuild = read('android/app/build.gradle');
const gradleWrapper = read('android/gradle/wrapper/gradle-wrapper.properties');

if (![phase, q278SuccessorPhase, q279SuccessorPhase, q280SuccessorPhase, q281SuccessorPhase, q282SuccessorPhase, q283SuccessorPhase, q284SuccessorPhase, q285SuccessorPhase, 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION', 'V172-Q287-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT', 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR', 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR', 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE', 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING', 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME', 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE', 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE', 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL', 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE', 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME', 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME', 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION', 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT', 'V172-Q300-RELEASE-CANDIDATE-FREEZE', 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK', 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK', 'V172-Q303-RUNTIME-DEPENDENCY-REAL-TRIAL-DEFAULT-OFF', 'V172-Q304-ANDROID-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-GATE', 'V172-Q305-PRIVATE-MODEL-DOWNLOAD-WORKER-REAL-IMPLEMENTATION-GATE', 'V172-Q306-SHA-VERIFICATION-ATOMIC-MOVE-REAL-RUNTIME-GATE', 'V172-Q307-PRIVATE-ARTIFACT-LOAD-REAL-DEVICE-SMOKE-GATE', 'V172-Q308-RUNTIME-STARTUP-REAL-DEVICE-SMOKE-GATE', q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR', 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN', 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE', 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR', 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG', 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q277R3 or successor through Q304');
if (manifest.cameraOcrRuntimePremiumRegressionLatestPhase !== phase) fail('manifest runtime premium regression latest marker must remain Q277R3');
const q277r2 = manifest.v172Q277R2CameraOcrRuntimePremiumRegressionAnalyzerHygiene;
if (!q277r2 || q277r2.phase !== sourcePhase) fail('Q277R2 source envelope missing');
const q277r3 = manifest.v172Q277R3CameraOcrRuntimePremiumRegressionTapLatencyCadence;
if (!q277r3 || q277r3.phase !== phase) fail('Q277R3 manifest envelope missing');
if (q277r3.sourcePhase !== sourcePhase) fail('Q277R3 source phase mismatch');
if (q277r3.repairMode !== 'real-device-keyboard-tap-to-workspace-latency-cadence-micro-repair-no-runtime-no-inference-no-pass-claim') fail('Q277R3 repair mode mismatch');

for (const key of [
  'userReportedTapToWorkspaceLatency',
  'realDeviceUiSurfacesReportedIntact',
  'protectedMathLiveProductionSurfaceChanged',
  'webViewJavaScriptDispatchRemainsSerial',
  'nativeMathLiveRemainsRendererAuthority',
]) {
  if (q277r3[key] !== true) fail(`Q277R3 ${key} must be true`);
}
for (const key of [
  'keyboardLayoutChanged',
  'moreTemplateTrayChanged',
  'longPressListsChanged',
  'graphSolutionHistoryRuntimeChanged',
  'cameraOcrReviewSafetyChanged',
  'solverEvaluatorChanged',
  'splashIconChanged',
  'mathLiveProductionBridgeJsChanged',
  'mathLiveProductionRouteChanged',
  'legacyFlutterCursorRouteReintroduced',
  'commandTailMayAwaitFlutterStateEcho',
  'emitOptimisticStateBeforeJsDispatch',
  'awaitPostDispatchFlutterStateEcho',
  'redundantDartStateRefreshAfterEveryKeyDispatch',
  'realOcrRuntimeAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'nativeBridgeImplementationAdded',
  'methodChannelRuntimeBindingAdded',
  'modelBinaryBundledInBaseApp',
  'realImageToLatexInferenceExecuted',
  'flutterAnalyzePassClaimedByAssistant',
  'flutterTestPassClaimedByAssistant',
  'flutterRunPassClaimed',
  'androidRealDevicePassClaimed',
  'tapLatencyPassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'premiumFinalPassClaimed',
  'releasePassClaimed',
]) {
  if (q277r3[key] !== false) fail(`Q277R3 ${key} must be false`);
}

if (!policy.includes(phase) || !policy.includes('commandTailMayAwaitFlutterStateEcho = false')) fail('Q277R3 policy markers missing');
if (!mainSurface.includes("import 'mathlive_production_tap_latency_cadence_policy.dart';")) fail('Q277R3 policy import missing from main editor surface');
if (!productionSurface.includes('q277r3-dart-dispatch-scheduled-fast-cadence')) fail('Q277R3 scheduled fast cadence marker missing');
if (!productionSurface.includes('q277r3-dart-command-tail-does-not-await-flutter-state-echo')) fail('Q277R3 non-awaiting command tail marker missing');
if (!productionSurface.includes('MathLiveProductionTapLatencyCadencePolicy.emitOptimisticStateBeforeJsDispatch')) fail('Q277R3 optimistic state gate missing');
if (!productionSurface.includes('MathLiveProductionTapLatencyCadencePolicy.redundantDartStateRefreshAfterEveryKeyDispatch')) fail('Q277R3 redundant refresh gate missing');
if (productionSurface.includes("unawaited(_refreshProductionStateDeferred(reason: 'q200-production-command-refresh-")) fail('Q277R3 must remove the previous redundant per-key Dart refresh marker');
if (sha('assets/mathlive/mathlive_prod_bridge.js') !== 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4') fail('Q277R3 must not modify production JS bridge');
if (!test.includes('tapLatencyPassClaimed, isFalse') || !audit.includes('tap-to-MathLive cadence') || !changed.includes('protected surface changed intentionally') || !readme.includes('V172-Q277R3')) fail('Q277R3 test/docs/readme markers missing');

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
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q277R3');
if (!settings.includes("com.android.application' version '8.6.1'")) fail('AGP must remain 8.6.1');
if (!settings.includes("org.jetbrains.kotlin.android' version '2.1.0'")) fail('Kotlin plugin must remain 2.1.0');
if (!gradleWrapper.includes('gradle-8.7-bin.zip')) fail('Gradle wrapper must remain 8.7');
if (!appBuild.includes('JavaVersion.VERSION_17') || !appBuild.includes("jvmTarget = '17'")) fail('Java/Kotlin target must remain 17');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors'];
for (const file of walk('.')) {
  const base = path.basename(file).toLowerCase();
  if (file.includes('/.git/') || file.includes('/.dart_tool/') || file.includes('/build/') || file.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/runtime binary must not be bundled in Q277R3: ${file}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q277R3: ${file}`);
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
  if (actual !== expected) {
    const q325AllowsMainActivitySuccessorChange =
      filePath === 'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt' &&
      manifest.v172Q325RuntimeDependencyCoordinateSelectionBuildTrialGate;
    if (!q325AllowsMainActivitySuccessorChange) fail(`protected hash changed unexpectedly for ${filePath}`);
  }
}

console.log(JSON.stringify({
  phase,
  status: 'CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_Q277R3_TAP_LATENCY_CADENCE_STATIC_READY_BUT_USER_FLUTTER_ANALYZE_TEST_RUN_AND_DEVICE_CADENCE_RETEST_REQUIRED',
  q278SuccessorVerifierAware: true,
  sourcePhase,
  q277r2SuccessorVerifierAware,
  protectedMathLiveProductionSurfaceChanged: q277r3.protectedMathLiveProductionSurfaceChanged,
  mathLiveProductionBridgeJsChanged: q277r3.mathLiveProductionBridgeJsChanged,
  commandTailMayAwaitFlutterStateEcho: q277r3.commandTailMayAwaitFlutterStateEcho,
  redundantDartStateRefreshAfterEveryKeyDispatch: q277r3.redundantDartStateRefreshAfterEveryKeyDispatch,
  realOcrRuntimeAdded: q277r3.realOcrRuntimeAdded,
  modelBinaryBundledInBaseApp: q277r3.modelBinaryBundledInBaseApp,
  tapLatencyPassClaimed: q277r3.tapLatencyPassClaimed,
  ocrPassClaimed: q277r3.ocrPassClaimed,
  requiresUserSideRetest: q277r3.requiresUserSideRetest,
}, null, 2));

// Successor-aware through V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG

// V172-Q299 successor-awareness marker: V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT
