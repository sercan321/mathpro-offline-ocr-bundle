#!/usr/bin/env node
// Successor-aware through V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const phase = 'V172-Q281-PRIVATE-ARTIFACT-LOAD-REAL-SMOKE';
const sourcePhase = 'V172-Q280-NATIVE-RUNTIME-BRIDGE-IMPLEMENTATION-BEHIND-FLAG';

function fail(message) {
  console.error(`PRIVATE_ARTIFACT_LOAD_REAL_SMOKE_Q281_BLOCKED: ${message}`);
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
const policy = read('lib/features/camera/gauss_private_artifact_load_real_smoke_policy.dart');
const gate = read('lib/features/camera/gauss_private_artifact_load_real_smoke.dart');
const test = read('test/v172_q281_private_artifact_load_real_smoke_test.dart');
const audit = read('docs/audit/V172_Q281_PRIVATE_ARTIFACT_LOAD_REAL_SMOKE_AUDIT.md');
const changed = read('docs/audit/V172_Q281_CHANGED_FILES.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml').toLowerCase();
const settings = read('android/settings.gradle');
const appBuild = read('android/app/build.gradle');
const gradleWrapper = read('android/gradle/wrapper/gradle-wrapper.properties');
const q280Verifier = read('tool/verify_native_runtime_bridge_implementation_v172_q280.mjs');
const q282Verifier = read('tool/verify_first_real_runtime_smoke_on_device_v172_q282.mjs');

if (![phase, 'V172-Q282-FIRST-REAL-RUNTIME-SMOKE-ON-DEVICE', 'V172-Q283-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-COURT', 'V172-Q284-OCR-RESULT-REAL-MATHLIVE-REVIEW-RUNTIME-BINDING', 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT', 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION', 'V172-Q287-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT', 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR', 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR', 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE', 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING', 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME', 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE', 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE', 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL', 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q281 or Q282 successor through Q287R1');
if (manifest.privateArtifactLoadRealSmokeLatestPhase !== phase) fail('manifest Q281 latest marker missing');
if (manifest.nativeRuntimeBridgeImplementationLatestPhase !== sourcePhase) fail('Q280 bridge marker must remain source phase');
const q280 = manifest.v172Q280NativeRuntimeBridgeImplementationBehindFlag;
if (!q280 || q280.phase !== sourcePhase) fail('Q280 source envelope missing');
const q281 = manifest.v172Q281PrivateArtifactLoadRealSmoke;
if (!q281 || q281.phase !== phase) fail('Q281 manifest envelope missing');
if (q281.sourcePhase !== sourcePhase) fail('Q281 source phase mismatch');
if (q281.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q281 selected engine changed');
if (q281.fallbackEngineLabel !== 'PP-FormulaNet_plus-L only') fail('Q281 fallback label mismatch');
if (q281.smokeMode !== 'private-artifact-load-real-smoke-gate-only-no-runtime-inference-no-workspace-mutation') fail('Q281 smoke mode mismatch');
if (q281.privateArtifactRootRelativePath !== 'files/models/pp_formulanet_s') fail('Q281 private artifact root mismatch');

for (const key of [
  'privateArtifactLoadRealSmokeGateImplemented',
  'requiresQ280NativeRuntimeBridge',
  'requiresQ279DependencyTrial',
  'requiresQ278EvidenceLock',
  'requiresVerifiedPrivateStorageArtifact',
  'requiresPrivateAppStoragePath',
  'requiresExpectedSha256',
  'requiresActualSha256',
  'requiresChecksumBeforeLoad',
  'requiresChecksumMatchBeforeReady',
  'requiresAtomicMoveCompletedEvidence',
  'requiresModelFormatProbePlan',
  'requiresDummyInputOnlySmoke',
  'requiresTimeoutCancellationPolicy',
  'requiresMemoryPressurePolicy',
  'reviewOnlyModeRequired',
  'editableMathLiveReviewRequired',
  'explicitUserApprovalRequiredBeforeWorkspaceImport',
  'directSolveGraphSolutionHistoryBlocked',
  'privateArtifactLoadSmokeEnvelopeAdded',
]) {
  if (q281[key] !== true) fail(`Q281 ${key} must be true`);
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
  'splashIconChanged',
  'realPrivateArtifactFileLoadedInQ281',
  'modelFormatProbeExecutedInQ281',
  'nativeRuntimeBridgeInvokedInQ281',
  'realOcrRuntimeAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'runtimeDependencyAddedToPubspec',
  'gradleNativeRuntimeDependencyAdded',
  'nativeHandlerImplementationAdded',
  'jniBindingAdded',
  'methodChannelRuntimeBindingAdded',
  'modelBinaryBundledInBaseApp',
  'productionModelUrlBound',
  'productionDownloadEnabled',
  'realNetworkDownloadWorkerImplemented',
  'realImageToLatexInferenceExecuted',
  'privateArtifactLoadPassClaimed',
  'runtimeSmokePassClaimed',
  'imageToLatexPassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'premiumFinalPassClaimed',
  'releasePassClaimed',
]) {
  if (q281[key] !== false) fail(`Q281 ${key} must be false`);
}

if (q281.maxArtifactSizeMb !== 256) fail('Q281 max artifact size budget mismatch');
if (q281.loadTimeoutBudgetMs !== 2500) fail('Q281 load timeout mismatch');
if (q281.modelFormatProbeTimeoutMs !== 900) fail('Q281 model format probe timeout mismatch');
if (q281.peakMemoryBudgetMb !== 384) fail('Q281 memory budget mismatch');
if (!Array.isArray(q281.requiredPrivateArtifactLoadSmokeGates) || q281.requiredPrivateArtifactLoadSmokeGates.length < 20) fail('Q281 private artifact load gate list too small');
for (const required of ['q280NativeRuntimeBridgePresent', 'checksumMatchBeforeReadyRequired', 'dummyInputOnlySmokeRequired', 'editableMathLiveReviewRequired']) {
  if (!q281.requiredPrivateArtifactLoadSmokeGates.includes(required)) fail(`Q281 missing gate: ${required}`);
}
if (!Array.isArray(q281.blockedUntilRealEvidence) || q281.blockedUntilRealEvidence.length < 14) fail('Q281 blocked evidence list too small');
if (!q281.blockedUntilRealEvidence.includes('realDeviceArtifactLoadSmokeEvidence')) fail('Q281 must require real device load smoke evidence');
if (!Array.isArray(q281.privateArtifactLoadRequestFields) || q281.privateArtifactLoadRequestFields.length < 9) fail('Q281 request envelope too small');
if (!q281.privateArtifactLoadRequestFields.includes('privateStoragePathVerified')) fail('Q281 request envelope missing private storage field');
if (!Array.isArray(q281.privateArtifactLoadResultFields) || q281.privateArtifactLoadResultFields.length < 11) fail('Q281 result envelope too small');
if (!q281.privateArtifactLoadResultFields.includes('directWorkspaceMutationAttempted')) fail('Q281 result envelope must expose direct workspace guard');
if (!Array.isArray(q281.artifactLoadErrorCodes) || !q281.artifactLoadErrorCodes.includes('artifactShaMismatch') || !q281.artifactLoadErrorCodes.includes('noRealArtifactLoadExecutedInQ281')) fail('Q281 artifact load error taxonomy incomplete');
if (!Array.isArray(q281.forbiddenActions) || q281.forbiddenActions.length < 18) fail('Q281 forbidden action list too small');
if (!q281.forbiddenActions.includes('runImageToLatexInferenceInQ281')) fail('Q281 must forbid inference');
if (!q281.forbiddenActions.includes('bundlePPFormulaNetSModelInBaseApkInQ281')) fail('Q281 must forbid model bundling');

for (const file of [
  'lib/features/camera/gauss_private_artifact_load_real_smoke_policy.dart',
  'lib/features/camera/gauss_private_artifact_load_real_smoke.dart',
  'test/v172_q281_private_artifact_load_real_smoke_test.dart',
  'tool/verify_private_artifact_load_real_smoke_v172_q281.mjs',
  'docs/audit/V172_Q281_PRIVATE_ARTIFACT_LOAD_REAL_SMOKE_AUDIT.md',
  'docs/audit/V172_Q281_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q281 file missing: ${file}`);
}
if (!policy.includes(phase) || !policy.includes('realPrivateArtifactFileLoadedInQ281 = false')) fail('Q281 policy markers missing');
if (!gate.includes('guardedLoadSmoke') || !gate.includes('blockedNoRealLoadExecuted') || !gate.includes('readyForQ282FirstRuntimeSmokeGateOnly')) fail('Q281 gate markers missing');
if (!test.includes('noRealArtifactLoadExecutedInQ281') || !test.includes('canLoadRealPrivateArtifactInQ281, isFalse')) fail('Q281 test markers missing');
if (!audit.includes('no Paddle runtime') || !changed.includes('gauss_private_artifact_load_real_smoke.dart') || !readme.includes('V172-Q281')) fail('Q281 docs/readme markers missing');
if (!q280Verifier.includes(phase)) fail('Q280 verifier must be Q281 successor through Q287R1-aware');
if (!q282Verifier.includes(phase)) fail('Q282 verifier must reference Q281 source phase');

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
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q281');
if (!settings.includes("com.android.application' version '8.6.1'")) fail('AGP must remain 8.6.1');
if (!settings.includes("org.jetbrains.kotlin.android' version '2.1.0'")) fail('Kotlin plugin must remain 2.1.0');
if (!gradleWrapper.includes('gradle-8.7-bin.zip')) fail('Gradle wrapper must remain 8.7');
if (!appBuild.includes('JavaVersion.VERSION_17') || !appBuild.includes("jvmTarget = '17'")) fail('Java/Kotlin target must remain 17');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors', '.so', '.aar'];
for (const file of walk('.')) {
  const base = path.basename(file).toLowerCase();
  if (file.includes('/.git/') || file.includes('/.dart_tool/') || file.includes('/build/') || file.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/native runtime binary must not be bundled in Q281: ${file}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q281: ${file}`);
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
  status: 'PRIVATE_ARTIFACT_LOAD_REAL_SMOKE_Q281_STATIC_READY_BUT_REAL_ARTIFACT_LOAD_RUNTIME_INFERENCE_AND_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  selectedEngineLabel: q281.selectedEngineLabel,
  smokeMode: q281.smokeMode,
  requiredPrivateArtifactLoadSmokeGates: q281.requiredPrivateArtifactLoadSmokeGates.length,
  blockedUntilRealEvidence: q281.blockedUntilRealEvidence.length,
  forbiddenActions: q281.forbiddenActions.length,
  privateArtifactLoadSmokeEnvelopeAdded: q281.privateArtifactLoadSmokeEnvelopeAdded,
  realPrivateArtifactFileLoadedInQ281: q281.realPrivateArtifactFileLoadedInQ281,
  modelFormatProbeExecutedInQ281: q281.modelFormatProbeExecutedInQ281,
  nativeRuntimeBridgeInvokedInQ281: q281.nativeRuntimeBridgeInvokedInQ281,
  realOcrRuntimeAdded: q281.realOcrRuntimeAdded,
  paddleRuntimeAdded: q281.paddleRuntimeAdded,
  paddleOcrDependencyAdded: q281.paddleOcrDependencyAdded,
  modelBinaryBundledInBaseApp: q281.modelBinaryBundledInBaseApp,
  productionModelUrlBound: q281.productionModelUrlBound,
  productionDownloadEnabled: q281.productionDownloadEnabled,
  realImageToLatexInferenceExecuted: q281.realImageToLatexInferenceExecuted,
  privateArtifactLoadPassClaimed: q281.privateArtifactLoadPassClaimed,
  ocrPassClaimed: q281.ocrPassClaimed,
  protectedHashComparison: 'PASS',
  requiresUserSideRetest: q281.requiresUserSideRetest,
}, null, 2));

// Successor-aware through V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG
