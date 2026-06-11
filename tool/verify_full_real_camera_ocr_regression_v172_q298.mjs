import fs from 'fs';
import crypto from 'crypto';
import path from 'path';

function fail(message) {
  console.error(`[Q298 VERIFY FAIL] ${message}`);
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

const phase = 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION';
const q309SuccessorPhase = 'V172-Q309-DUMMY-INPUT-REAL-RUNTIME-CALL-GATE';
const q310SuccessorPhase = 'V172-Q310-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GATE';
const sourcePhase = 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME';
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q298 = manifest.q298FullRealCameraOcrRegression;
if (![phase, 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT', 'V172-Q300-RELEASE-CANDIDATE-FREEZE', 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK', 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK', 'V172-Q303-RUNTIME-DEPENDENCY-REAL-TRIAL-DEFAULT-OFF', 'V172-Q304-ANDROID-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-GATE', 'V172-Q305-PRIVATE-MODEL-DOWNLOAD-WORKER-REAL-IMPLEMENTATION-GATE', 'V172-Q306-SHA-VERIFICATION-ATOMIC-MOVE-REAL-RUNTIME-GATE', 'V172-Q307-PRIVATE-ARTIFACT-LOAD-REAL-DEVICE-SMOKE-GATE', 'V172-Q308-RUNTIME-STARTUP-REAL-DEVICE-SMOKE-GATE', q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q298 or successor');
if (manifest.cameraOcrLatestPhase === 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT' && !manifest.q299StoreReleaseCandidateAudit) fail('Q299 successor envelope missing');
if (manifest.fullRealCameraOcrRegressionLatestPhase !== phase) fail('manifest Q298 latest phase marker missing');
if (!q298) fail('manifest q298FullRealCameraOcrRegression envelope missing');
if (q298.phase !== phase) fail('Q298 phase mismatch');
if (q298.sourcePhase !== sourcePhase) fail('Q298 source phase mismatch');
if (q298.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q298 selected engine mismatch');
if (q298.regressionFeatureFlag !== 'gauss.ppFormulaNetS.fullRealCameraOcrRegression.defaultOff') fail('Q298 default-off flag mismatch');
if (!String(q298.regressionReadinessState || '').includes('BLOCKED_PENDING_REAL_Q291_TO_Q297')) fail('Q298 readiness must remain blocked pending real evidence');

for (const key of [
  'q297ApprovedOcrWorkspaceImportRequired',
  'q296EditableMathLiveReviewRequired',
  'q295ImageToLatexInferenceEvidenceRequired',
  'q294DummyInputRuntimeCallEvidenceRequired',
  'q293RuntimeStartupEvidenceRequired',
  'q292PrivateArtifactLoadEvidenceRequired',
  'q291PrivateModelDownloadShaEvidenceRequired',
  'q290NativeHandlerBindingEvidenceRequired',
  'q289RuntimeDependencyTrialDefaultOffRequired',
  'q288ArtifactSourceIntakeRequired',
  'editableMathLiveReviewStillRequired',
  'explicitUserApprovalStillRequired',
  'workspaceImportOnlyAfterApproval',
  'manualSolveGraphAfterImportOnly',
]) {
  if (q298[key] !== true) fail(`Q298 ${key} must be true`);
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
  'androidToolchainChanged',
  'cameraDependencyChanged',
  'androidManifestChanged',
  'mainActivityChanged',
  'splashIconChanged',
  'fullRealCameraOcrRegressionExecuted',
  'realWorkspaceImportRuntimeExecuted',
  'realEditableMathLiveReviewOpened',
  'realUserApprovalCaptured',
  'realImageToLatexInferenceExecuted',
  'realDummyInputRuntimeCallExecuted',
  'nativeRuntimeStartupExecuted',
  'realPrivateArtifactFileLoaded',
  'realModelDownloadedAndShaVerified',
  'nativeRuntimeHandlerImplemented',
  'methodChannelRuntimeBindingAdded',
  'jniBindingAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'runtimeDependencyAddedToPubspec',
  'gradleNativeRuntimeDependencyAdded',
  'cameraImageSentToNativeRuntime',
  'latexCandidateReturnedByRuntime',
  'modelBinaryBundledInBaseApp',
  'productionDownloadEnabled',
  'directWorkspaceImportEnabled',
  'autoEvaluateEnabled',
  'autoSolveGraphSolutionHistoryEnabled',
  'solutionHistoryWriteEnabled',
  'fullRegressionPassClaimed',
  'workspaceImportPassClaimed',
  'reviewBindingPassClaimed',
  'imageToLatexPassClaimed',
  'runtimeSmokePassClaimed',
  'modelDownloadPassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'premiumFinalPassClaimed',
  'storeReadyPassClaimed',
  'releasePassClaimed',
]) {
  if (q298[key] !== false) fail(`Q298 ${key} must be false`);
}

for (const marker of [
  'q297-approved-ocr-workspace-import-contract-present',
  'q296-editable-mathlive-review-contract-present',
  'q295-image-to-latex-inference-contract-present',
  'q294-dummy-input-runtime-call-contract-present',
  'q293-runtime-startup-smoke-contract-present',
  'q292-private-artifact-load-smoke-contract-present',
  'q291-private-model-download-sha-verification-contract-present',
  'q290-native-handler-android-binding-contract-present',
  'q289-runtime-dependency-trial-default-off-contract-present',
  'q288-real-ocr-artifact-source-intake-contract-present',
  'keyboard-layout-preserved',
  'mathlive-production-route-preserved',
  'editable-mathlive-review-required',
  'explicit-user-approval-required',
  'workspace-import-only-after-approval',
  'no-auto-evaluate-solve-graph-solution-history',
]) {
  if (!q298.requiredRegressionGates.includes(marker)) fail(`Q298 required regression gate missing: ${marker}`);
}
for (const courtCase of ['camera-entry-button-still-reachable','image-to-latex-candidate-gate','editable-mathlive-review-gate','approved-workspace-import-gate','keyboard-more-longpress-regression-guard','fake-pass-claim-guard']) {
  if (!q298.regressionCourtCases.includes(courtCase)) fail(`Q298 court case missing: ${courtCase}`);
}
for (const evidence of ['real-flutter-analyze-log','real-flutter-test-log','real-flutter-run-device-log','real-image-to-latex-inference-device-log','real-approved-workspace-import-evidence']) {
  if (!q298.blockedUntilRealEvidence.includes(evidence)) fail(`Q298 evidence blocker missing: ${evidence}`);
}
for (const action of ['invokeNativeRuntimeInQ298','autoSolveCameraOutput','addPaddleRuntimeDependencyInQ298','bindRuntimeMethodChannelInQ298','bundlePPFormulaNetSModelInBaseApkInQ298','claimOcrPassWithoutRealInferenceEvidence']) {
  if (!q298.forbiddenActions.includes(action)) fail(`Q298 forbidden action missing: ${action}`);
}

for (const file of [
  'lib/features/camera/gauss_full_real_camera_ocr_regression_policy.dart',
  'lib/features/camera/gauss_full_real_camera_ocr_regression.dart',
  'test/v172_q298_full_real_camera_ocr_regression_test.dart',
  'tool/verify_full_real_camera_ocr_regression_v172_q298.mjs',
  'docs/audit/V172_Q298_FULL_REAL_CAMERA_OCR_REGRESSION_AUDIT.md',
  'docs/audit/V172_Q298_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q298 file missing: ${file}`);
}

const policy = read('lib/features/camera/gauss_full_real_camera_ocr_regression_policy.dart');
const gate = read('lib/features/camera/gauss_full_real_camera_ocr_regression.dart');
const test = read('test/v172_q298_full_real_camera_ocr_regression_test.dart');
const audit = read('docs/audit/V172_Q298_FULL_REAL_CAMERA_OCR_REGRESSION_AUDIT.md');
const changed = read('docs/audit/V172_Q298_CHANGED_FILES.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const q297Verifier = read('tool/verify_approved_ocr_workspace_import_real_runtime_v172_q297.mjs');

if (!policy.includes(phase) || !policy.includes('fullRealCameraOcrRegressionExecuted = false') || !policy.includes('gauss.ppFormulaNetS.fullRealCameraOcrRegression.defaultOff')) fail('Q298 policy markers missing');
if (!gate.includes('fullRegressionContractReadyRealRuntimeBlocked') || !gate.includes('canRunRealOcrInQ298 => false') || !gate.includes('canClaimFullCameraOcrRegressionPassInQ298 => false')) fail('Q298 gate markers missing');
if (!test.includes('gauss.ppFormulaNetS.fullRealCameraOcrRegression.defaultOff') || !test.includes('is static-ready only and refuses real OCR/runtime/PASS claims')) fail('Q298 test markers missing');
if (!audit.includes('Full Real Camera/OCR Regression') || !audit.includes('Runtime Boundary') || !audit.includes('does **not**')) fail('Q298 audit markers missing');
if (!changed.includes('gauss_full_real_camera_ocr_regression_policy.dart')) fail('Q298 changed files must disclose new policy');
const modifiedSection = changed.split('## Modified For Successor Awareness Only')[0];
for (const protectedPath of ['MainActivity.kt','AndroidManifest.xml','mathlive_prod_bridge.js','mathlive_production_editor_surface.dart','gauss_camera_capture_shell.dart','workspace_panel.dart']) {
  if (modifiedSection.includes(protectedPath)) fail(`Q298 modified section must not list protected runtime file as changed: ${protectedPath}`);
}
if (!readme.includes('V172-Q298')) fail('README must mention Q298');
if (!q297Verifier.includes(phase)) fail('Q297 verifier must be Q298 successor-aware');

for (const forbidden of q298.blockedDependencyFamilies) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q298');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors', '.so', '.aar'];
for (const file of walk('.')) {
  const normalized = file.replaceAll('\\', '/');
  const base = path.basename(normalized).toLowerCase();
  if (normalized.includes('/.git/') || normalized.includes('/.dart_tool/') || normalized.includes('/build/') || normalized.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/native runtime binary must not be bundled in Q298: ${normalized}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q298: ${normalized}`);
}

const protectedHashes = {
  "lib/features/keyboard/key_config.dart": "4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2",
  "lib/features/keyboard/math_keyboard.dart": "fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c",
  "lib/features/keyboard/bottom_dock.dart": "a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354",
  "lib/features/keyboard/long_press_popup.dart": "4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369",
  "lib/features/keyboard/premium_key.dart": "4311a54f0f4e21b3b134552af2613d2ff30fed2078ebd6279a222d877fa21b43",
  "lib/features/workspace/template_tray.dart": "b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678",
  "assets/mathlive/main_editor_prod.html": "f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd",
  "assets/mathlive/mathlive_prod_bridge.js": "fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4",
  "lib/features/mathlive/mathlive_production_editor_surface.dart": "d9110c8d0018758216b1e9967bbd422cd97559d923cfc090e6677514da0d1c99",
  "lib/features/solution/solution_steps_panel.dart": "558c0f232dd4bb81bbf92ffa7687ff8d77fb450daf95f5e04a98f277f1625f2b",
  "lib/features/solution/solution_step_models.dart": "faab66d941f841911989bee8fae44d0d1edc546fabb6f65fd7dab777405cc248",
  "lib/features/history/history_panel.dart": "fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b",
  "lib/features/history/history_controller.dart": "331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51",
  "lib/features/graph/graph_card.dart": "124accae8499c2dbc8cb6e1dde3a2317dfaafad576363aecebd5f78c94f22b6f",
  "lib/app/app_shell.dart": "ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637",
  "lib/main.dart": "068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689",
  "android/app/src/main/AndroidManifest.xml": "4fe91898ddf5ff94af1527314c8977806f23b051b7de078f25604dfa4731c1a6",
  "android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt": "c27aa8777ba2a3b33bc15d839b2b05bb35f9f6a09f4c5c8de0e39365f65dacf1",
  "lib/app/gauss_splash_screen.dart": "465c3b70662673dbed283ef15cd7bbc22cba0402668e670da136aedfeb54ee81",
  "lib/features/workspace/workspace_panel.dart": "7e3c32f710b07b8fba3bd4223de650c71f334747644a41cfd0079ff7d49812b1",
  "lib/features/camera/gauss_camera_capture_shell.dart": "92ede0a9ab5a8dba305a587d5cfa5145b7065accac85063bd907326eccb26a51"
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
  status: 'FULL_REAL_CAMERA_OCR_REGRESSION_STATIC_READY_REAL_RUNTIME_BLOCKED',
  sourcePhase,
  selectedEngineLabel: q298.selectedEngineLabel,
  regressionFeatureFlag: q298.regressionFeatureFlag,
  regressionReadinessState: q298.regressionReadinessState,
  protectedHashComparison: 'PASS',
  fullRealCameraOcrRegressionExecuted: q298.fullRealCameraOcrRegressionExecuted,
  realImageToLatexInferenceExecuted: q298.realImageToLatexInferenceExecuted,
  methodChannelRuntimeBindingAdded: q298.methodChannelRuntimeBindingAdded,
  modelBinaryBundledInBaseApp: q298.modelBinaryBundledInBaseApp,
  productionDownloadEnabled: q298.productionDownloadEnabled,
  fullRegressionPassClaimed: q298.fullRegressionPassClaimed,
  ocrPassClaimed: q298.ocrPassClaimed,
  cameraOcrRuntimePassClaimed: q298.cameraOcrRuntimePassClaimed,
  releasePassClaimed: q298.releasePassClaimed,
}, null, 2));

// V172-Q299 successor-awareness marker: V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT
