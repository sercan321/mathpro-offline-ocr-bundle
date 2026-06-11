import fs from 'fs';
import crypto from 'crypto';
import path from 'path';

function fail(message) {
  console.error(`[Q301 VERIFY FAIL] ${message}`);
  process.exit(1);
}
function read(file) {
  return fs.readFileSync(file, 'utf8');
}
function sha(file) {
  return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex');
}
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (entry.name === '.git') continue;
    const p = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(p));
    else out.push(p);
  }
  return out;
}

const successorPhase = 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE';
const q316SuccessorPhase = 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q317SuccessorPhase = 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG';
const q318SuccessorPhase = 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION';
const phase = 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK';
const q309SuccessorPhase = 'V172-Q309-DUMMY-INPUT-REAL-RUNTIME-CALL-GATE';
const q310SuccessorPhase = 'V172-Q310-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GATE';
const sourcePhase = 'V172-Q300-RELEASE-CANDIDATE-FREEZE';
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q301 = manifest.q301ProductDevelopmentTrackRebaseStoreTrackPark;
if (![phase, 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK', 'V172-Q303-RUNTIME-DEPENDENCY-REAL-TRIAL-DEFAULT-OFF', 'V172-Q304-ANDROID-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-GATE', 'V172-Q305-PRIVATE-MODEL-DOWNLOAD-WORKER-REAL-IMPLEMENTATION-GATE', 'V172-Q306-SHA-VERIFICATION-ATOMIC-MOVE-REAL-RUNTIME-GATE', 'V172-Q307-PRIVATE-ARTIFACT-LOAD-REAL-DEVICE-SMOKE-GATE', 'V172-Q308-RUNTIME-STARTUP-REAL-DEVICE-SMOKE-GATE', q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR', 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN', 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE', 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR', 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG', 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q301/Q302/Q303/Q304/Q305/Q306 successor');
if (manifest.productDevelopmentTrackRebaseStoreTrackParkLatestPhase !== phase) fail('manifest Q301 latest phase marker missing');
if (![phase, 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK', 'V172-Q303-RUNTIME-DEPENDENCY-REAL-TRIAL-DEFAULT-OFF', 'V172-Q304-ANDROID-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-GATE', 'V172-Q305-PRIVATE-MODEL-DOWNLOAD-WORKER-REAL-IMPLEMENTATION-GATE', 'V172-Q306-SHA-VERIFICATION-ATOMIC-MOVE-REAL-RUNTIME-GATE', 'V172-Q307-PRIVATE-ARTIFACT-LOAD-REAL-DEVICE-SMOKE-GATE', 'V172-Q308-RUNTIME-STARTUP-REAL-DEVICE-SMOKE-GATE', q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR', 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN', 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE', 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR', 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG', 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION'].includes(manifest.activeProductDevelopmentLatestPhase)) fail('manifest active product development marker must point to Q301/Q302/Q303/Q304/Q305/Q306 successor');
if (!q301) fail('manifest q301ProductDevelopmentTrackRebaseStoreTrackPark envelope missing');
if (q301.phase !== phase) fail('Q301 phase mismatch');
if (q301.sourcePhase !== sourcePhase) fail('Q301 source phase mismatch');
if (q301.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q301 selected engine mismatch');
if (q301.rebaseMode !== 'product-development-track-rebase-store-track-park-contract-only-no-runtime-no-store-work') fail('Q301 rebase mode mismatch');
if (q301.developmentTrackFeatureFlag !== 'gauss.productDevelopment.track.rebase.defaultOff') fail('Q301 default-off rebase flag mismatch');
if (q301.activeDevelopmentTrack !== 'PRODUCT_DEVELOPMENT_FIRST_STORE_TRACK_PARKED') fail('Q301 active development track mismatch');
if (!String(q301.readinessState || '').includes('PRODUCT_DEVELOPMENT_RESUMED_STORE_RELEASE_BLOCKED')) fail('Q301 readiness state must show product development resumed with release blocked');

for (const key of [
  'q300ReleaseCandidateFreezeRequired',
  'storeTrackParked',
  'playStorePreparationParked',
  'releaseCandidateFreezePreservedAsHistoricalAuditOnly',
  'productDevelopmentTrackActive',
  'realOcrRuntimeTrackActive',
  'premiumUiUxTrackActive',
  'deviceQaTrackActive',
]) {
  if (q301[key] !== true) fail(`Q301 ${key} must be true`);
}

for (const key of [
  'changesRuntimeBehavior',
  'keyboardLayoutChanged',
  'moreTemplateTrayChanged',
  'longPressListsChanged',
  'graphSolutionHistoryChanged',
  'mathLiveProductionRouteChanged',
  'mathLiveBridgeChanged',
  'cameraShellRuntimeChanged',
  'workspaceRuntimeChanged',
  'solverEvaluatorChanged',
  'androidManifestChanged',
  'mainActivityChanged',
  'splashIconChanged',
  'pubspecChanged',
  'cameraDependencyChanged',
  'androidToolchainChanged',
  'storeSubmissionPerformed',
  'playConsoleConfigured',
  'privacyPolicyWritten',
  'dataSafetyFormCompleted',
  'releaseAabCreated',
  'releaseApkCreated',
  'productionReleaseCreated',
  'storeListingAssetsCreated',
  'localizedStoreListingsCreated',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'jniBindingAdded',
  'methodChannelRuntimeBindingAdded',
  'nativeRuntimeHandlerImplemented',
  'modelBinaryBundledInBaseApp',
  'productionDownloadEnabled',
  'realModelDownloadedAndShaVerified',
  'realPrivateArtifactLoaded',
  'realRuntimeStartupExecuted',
  'realImageToLatexInferenceExecuted',
  'realEditableMathLiveReviewOpened',
  'realWorkspaceImportExecuted',
  'autoEvaluateEnabled',
  'autoSolveGraphSolutionHistoryEnabled',
  'flutterAnalyzePassClaimed',
  'flutterTestPassClaimed',
  'flutterRunPassClaimed',
  'androidRealDevicePassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'storeReadyPassClaimed',
  'releasePassClaimed',
  'premiumFinalPassClaimed',
]) {
  if (q301[key] !== false) fail(`Q301 ${key} must be false`);
}

for (const topic of [
  'play-store-listing',
  'privacy-policy-authoring',
  'data-safety-form',
  'release-aab-apk',
  'production-release-submission',
]) {
  if (!q301.parkedStoreTopics.includes(topic)) fail(`Q301 parked store topic missing: ${topic}`);
}
for (const track of [
  'real-pp-formulanet-s-runtime-source-and-sha-lock',
  'first-real-image-to-latex-inference',
  'ocr-candidate-editable-mathlive-review',
  'approved-ocr-workspace-import',
  'mathlive-input-caret-latency-device-quality',
  'workspace-keyboard-graph-solution-history-premium-qa',
]) {
  if (!q301.activeProductTracks.includes(track)) fail(`Q301 active product track missing: ${track}`);
}
for (const marker of [
  'keyboard-layout-preserved',
  'more-template-tray-preserved',
  'long-press-lists-preserved',
  'mathlive-production-route-preserved',
  'mathlive-bridge-preserved',
  'graph-solution-history-preserved',
  'android-manifest-mainactivity-preserved',
  'camera-shell-runtime-preserved',
  'splash-icon-preserved',
]) {
  if (!q301.protectedSurfaceMarkers.includes(marker)) fail(`Q301 protected marker missing: ${marker}`);
}
for (const action of [
  'startPlayStorePreparationInQ301',
  'createPrivacyPolicyOrDataSafetyInQ301',
  'buildReleaseAabOrApkInQ301',
  'submitPlayStoreReleaseInQ301',
  'addPaddleRuntimeDependencyInQ301',
  'bindRuntimeMethodChannelInQ301',
  'implementNativeRuntimeHandlerInQ301',
  'runImageToLatexInferenceInQ301',
  'autoSolveCameraOutput',
]) {
  if (!q301.forbiddenActions.includes(action)) fail(`Q301 forbidden action missing: ${action}`);
}

for (const file of [
  'lib/features/camera/gauss_product_development_track_rebase_store_track_park_policy.dart',
  'lib/features/camera/gauss_product_development_track_rebase_store_track_park.dart',
  'test/v172_q301_product_development_track_rebase_store_track_park_test.dart',
  'tool/verify_product_development_track_rebase_store_track_park_v172_q301.mjs',
  'docs/audit/V172_Q301_PRODUCT_DEVELOPMENT_TRACK_REBASE_STORE_TRACK_PARK_AUDIT.md',
  'docs/audit/V172_Q301_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q301 file missing: ${file}`);
}

const policy = read('lib/features/camera/gauss_product_development_track_rebase_store_track_park_policy.dart');
const gate = read('lib/features/camera/gauss_product_development_track_rebase_store_track_park.dart');
const test = read('test/v172_q301_product_development_track_rebase_store_track_park_test.dart');
const audit = read('docs/audit/V172_Q301_PRODUCT_DEVELOPMENT_TRACK_REBASE_STORE_TRACK_PARK_AUDIT.md');
const changed = read('docs/audit/V172_Q301_CHANGED_FILES.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const q300Verifier = read('tool/verify_release_candidate_freeze_v172_q300.mjs');
const q299Verifier = read('tool/verify_store_release_candidate_audit_v172_q299.mjs');

if (!policy.includes(phase) || !policy.includes('storeTrackParked = true') || !policy.includes('gauss.productDevelopment.track.rebase.defaultOff')) fail('Q301 policy markers missing');
if (!gate.includes('productDevelopmentTrackRebasedStoreTrackParked') || !gate.includes('canStartPlayStorePreparationInQ301 => false') || !gate.includes('canRunImageToLatexInferenceInQ301 => false')) fail('Q301 gate markers missing');
if (!test.includes('parks store work') || !test.includes('real-pp-formulanet-s-runtime-source-and-sha-lock')) fail('Q301 test markers missing');
if (!audit.includes('Product Development Track Rebase') || !audit.includes('Store Track Park') || !audit.includes('does **not**')) fail('Q301 audit markers missing');
if (!changed.includes('gauss_product_development_track_rebase_store_track_park_policy.dart')) fail('Q301 changed files must disclose new policy');
if (!readme.includes('V172-Q301')) fail('README must mention Q301');
if (!q300Verifier.includes(phase)) fail('Q300 verifier must be Q301 successor-aware');
if (!q299Verifier.includes(phase)) fail('Q299 verifier must be Q301 successor-aware');

const modifiedSection = changed.split('## Modified For Successor Awareness Only')[0];
for (const protectedPath of ['MainActivity.kt','AndroidManifest.xml','mathlive_prod_bridge.js','mathlive_production_editor_surface.dart','gauss_camera_capture_shell.dart','workspace_panel.dart','graph_card.dart','solution_steps_panel.dart','history_panel.dart']) {
  if (modifiedSection.includes(protectedPath)) fail(`Q301 modified section must not list protected runtime file as changed: ${protectedPath}`);
}
for (const forbidden of ['paddleocr','paddle_lite','onnxruntime','tflite_flutter','workmanager','background_downloader']) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q301');

for (const file of walk('.')) {
  const normalized = file.split(path.sep).join('/').replace(/^\.\//, '');
  if (/\.(apk|aab|onnx|pdmodel|pdiparams|nb|tflite|pt|pth|ckpt|zip)$/i.test(normalized) && !normalized.startsWith('assets/mathlive/vendor/')) {
    fail(`forbidden binary/archive/model artifact present: ${normalized}`);
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
  'lib/features/camera/gauss_camera_capture_shell.dart': '92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51'
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
  status: 'PRODUCT_DEVELOPMENT_TRACK_REBASED_STORE_TRACK_PARKED_STATIC_READY',
  sourcePhase,
  selectedEngineLabel: q301.selectedEngineLabel,
  activeDevelopmentTrack: q301.activeDevelopmentTrack,
  readinessState: q301.readinessState,
  storeTrackParked: q301.storeTrackParked,
  playStorePreparationParked: q301.playStorePreparationParked,
  productDevelopmentTrackActive: q301.productDevelopmentTrackActive,
  realOcrRuntimeTrackActive: q301.realOcrRuntimeTrackActive,
  runtimeDependencyAdded: q301.paddleRuntimeAdded,
  methodChannelRuntimeBindingAdded: q301.methodChannelRuntimeBindingAdded,
  realImageToLatexInferenceExecuted: q301.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q301.ocrPassClaimed,
  releasePassClaimed: q301.releasePassClaimed,
}, null, 2));
