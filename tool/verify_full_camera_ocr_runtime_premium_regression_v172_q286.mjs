#!/usr/bin/env node
// Successor-aware through V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE
import fs from 'node:fs';
// Successor-aware through V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG
import path from 'node:path';
import crypto from 'node:crypto';

const phase = 'V172-Q286-FULL-CAMERA-OCR-RUNTIME-PREMIUM-REGRESSION';
const sourcePhase = 'V172-Q285-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-COURT';
function fail(message) { console.error(`[Q286 VERIFY FAIL] ${message}`); process.exit(1); }
function read(file) { return fs.readFileSync(file, 'utf8'); }
function json(file) { return JSON.parse(read(file)); }
function sha(file) { return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex'); }
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(p));
    else out.push(p);
  }
  return out;
}

const manifest = json('assets/mathlive/manifest.json');
const pubspec = read('pubspec.yaml');
const settings = read('android/settings.gradle');
const gradleWrapper = read('android/gradle/wrapper/gradle-wrapper.properties');
const appBuild = read('android/app/build.gradle');
const policy = read('lib/features/camera/gauss_full_camera_ocr_runtime_premium_regression_policy.dart');
const gate = read('lib/features/camera/gauss_full_camera_ocr_runtime_premium_regression.dart');
const test = read('test/v172_q286_full_camera_ocr_runtime_premium_regression_test.dart');
const audit = read('docs/audit/V172_Q286_FULL_CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_AUDIT.md');
const changed = read('docs/audit/V172_Q286_CHANGED_FILES.md');
const readme = read('README.md');
const q286 = manifest.q286FullCameraOcrRuntimePremiumRegression;

if (![phase, 'V172-Q287-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT', 'V172-Q287R1-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-FLUTTER-LOG-REPAIR', 'V172-Q287R2-STORE-READINESS-CAMERA-OCR-RELEASE-AUDIT-TEST-DOC-SECTION-REPAIR', 'V172-Q288-REAL-OCR-ARTIFACT-SOURCE-INTAKE', 'V172-Q289-RUNTIME-DEPENDENCY-ACTUAL-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q290-NATIVE-RUNTIME-HANDLER-SKELETON-ANDROID-BINDING', 'V172-Q291-PRIVATE-MODEL-DOWNLOAD-SHA-VERIFICATION-RUNTIME', 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE', 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE', 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL', 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE', 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME', 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME', 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION', 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT', 'V172-Q300-RELEASE-CANDIDATE-FREEZE', 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK', 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q286 or Q287/Q287R1 successor');
if (manifest.fullCameraOcrRuntimePremiumRegressionLatestPhase !== phase) fail('manifest Q286 latest marker missing');
if (!q286 || q286.phase !== phase) fail('Q286 manifest envelope missing or phase mismatch');
if (q286.sourcePhase !== sourcePhase) fail('Q286 source phase mismatch');
if (q286.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q286 selected engine mismatch');
if (!q286.regressionMode.includes('gate-only') || !q286.regressionMode.includes('no-real-inference')) fail('Q286 mode must be gate-only/no-real-inference');

for (const key of [
  'fullCameraOcrRuntimePremiumRegressionImplemented',
  'requiresQ285ApprovedWorkspaceImportRuntimeCourt',
  'requiresQ284EditableMathLiveReviewRuntimeBinding',
  'requiresQ283ImageToLatexInferenceCourt',
  'requiresQ282RuntimeSmokeCourt',
  'requiresQ281PrivateArtifactLoadSmoke',
  'requiresQ280NativeRuntimeBridgeGate',
  'requiresQ279DependencyTrialDefaultOff',
  'requiresQ278EvidenceLock',
  'reviewBeforeImportStillMandatory',
  'explicitUserApprovalStillMandatory',
  'workspaceImportAfterApprovalOnly',
  'manualSolveGraphAfterImportOnly',
  'directSolveGraphSolutionHistoryBlocked',
]) {
  if (q286[key] !== true) fail(`Q286 ${key} must be true`);
}

for (const key of [
  'keyboardLayoutChanged',
  'moreTemplateTrayChanged',
  'longPressListsChanged',
  'mathLiveProductionRouteChanged',
  'graphRuntimeChanged',
  'solutionRuntimeChanged',
  'historyRuntimeChanged',
  'cameraShellRuntimeChanged',
  'realFullCameraOcrRuntimeRegressionExecutedInQ286',
  'realWorkspaceImportRuntimeExecutedInQ286',
  'realImageToLatexInferenceExecutedInQ286',
  'realRuntimeSmokeExecutedInQ286',
  'realRuntimeInvocationExecutedInQ286',
  'nativeRuntimeBridgeInvokedInQ286',
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
  'directWorkspaceMutationAllowed',
  'directSolveAllowed',
  'directGraphAllowed',
  'directSolutionHistoryWriteAllowed',
  'fullCameraOcrRuntimeRegressionPassClaimed',
  'workspaceImportRuntimePassClaimed',
  'reviewBindingPassClaimed',
  'imageToLatexPassClaimed',
  'runtimeSmokePassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'premiumFinalPassClaimed',
  'releasePassClaimed',
]) {
  if (q286[key] !== false) fail(`Q286 ${key} must be false`);
}

if (!Array.isArray(q286.requiredFullRegressionGates) || q286.requiredFullRegressionGates.length < 28) fail('Q286 regression gate list too small');
for (const required of ['keyboardLayoutPreserved', 'mathLiveProductionRoutePreserved', 'noAutoSolveAfterCamera', 'realFlutterRunDeviceLogRequired']) {
  if (!q286.requiredFullRegressionGates.includes(required)) fail(`Q286 missing regression gate: ${required}`);
}
if (!Array.isArray(q286.blockedUntilRealEvidence) || q286.blockedUntilRealEvidence.length < 16 || !q286.blockedUntilRealEvidence.includes('realQ285ApprovedWorkspaceImportEnvelopeEvidence')) fail('Q286 blocked evidence list incomplete');
if (!Array.isArray(q286.regressionCourtCases) || q286.regressionCourtCases.length < 18 || !q286.regressionCourtCases.includes('cameraCaptureReviewSurfaceSmoke')) fail('Q286 regression court cases incomplete');
if (!Array.isArray(q286.forbiddenActions) || !q286.forbiddenActions.includes('autoSolveCameraOutput') || !q286.forbiddenActions.includes('bundlePPFormulaNetSModelInBaseApkInQ286')) fail('Q286 forbidden actions incomplete');

for (const file of [
  'lib/features/camera/gauss_full_camera_ocr_runtime_premium_regression_policy.dart',
  'lib/features/camera/gauss_full_camera_ocr_runtime_premium_regression.dart',
  'test/v172_q286_full_camera_ocr_runtime_premium_regression_test.dart',
  'tool/verify_full_camera_ocr_runtime_premium_regression_v172_q286.mjs',
  'docs/audit/V172_Q286_FULL_CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_AUDIT.md',
  'docs/audit/V172_Q286_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q286 file missing: ${file}`);
}
if (!policy.includes(phase) || !policy.includes('realFullCameraOcrRuntimeRegressionExecutedInQ286 = false')) fail('Q286 policy markers missing');
if (!gate.includes('fromQ285Court') || !gate.includes('canRunRealOcrInQ286') || !gate.includes('readyForFutureFullRuntimeRegressionEvidenceOnly')) fail('Q286 gate markers missing');
if (!test.includes('canRunRealOcrInQ286, isFalse') || !test.includes('blockedAutoEvaluateSolveGraphSolutionHistoryRisk')) fail('Q286 test markers missing');
if (!audit.includes('does not run PP-FormulaNet-S') || !audit.includes('direct-solve')) fail('Q286 audit must document runtime and direct-solve boundaries');
if (!changed.includes('gauss_full_camera_ocr_runtime_premium_regression.dart') || !readme.includes('V172-Q286')) fail('Q286 docs/readme markers missing');

for (const previousVerifier of [
  'tool/verify_approved_ocr_workspace_import_runtime_court_v172_q285.mjs',
  'tool/verify_ocr_result_real_mathlive_review_runtime_binding_v172_q284.mjs',
  'tool/verify_first_real_image_to_latex_inference_court_v172_q283.mjs',
  'tool/verify_first_real_runtime_smoke_on_device_v172_q282.mjs',
  'tool/verify_private_artifact_load_real_smoke_v172_q281.mjs',
  'tool/verify_native_runtime_bridge_implementation_v172_q280.mjs',
  'tool/verify_selected_runtime_dependency_trial_v172_q279.mjs',
  'tool/verify_real_runtime_integration_evidence_lock_v172_q278.mjs',
]) {
  if (!read(previousVerifier).includes(phase)) fail(`${previousVerifier} must be Q286 successor-aware`);
}

for (const forbidden of [
  'paddleocr', 'paddle_ocr', 'paddle_flutter', 'paddle_lite', 'google_mlkit_text_recognition',
  'onnxruntime', 'tesseract', 'pix2text', 'flutter_downloader', 'background_downloader', 'dio',
]) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q286');
if (!settings.includes("com.android.application' version '8.6.1'")) fail('AGP must remain 8.6.1');
if (!settings.includes("org.jetbrains.kotlin.android' version '2.1.0'")) fail('Kotlin plugin must remain 2.1.0');
if (!gradleWrapper.includes('gradle-8.7-bin.zip')) fail('Gradle wrapper must remain 8.7');
if (!appBuild.includes('JavaVersion.VERSION_17') || !appBuild.includes("jvmTarget = '17'")) fail('Java/Kotlin target must remain 17');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors', '.so', '.aar'];
for (const file of walk('.')) {
  const normalized = file.replaceAll('\\', '/');
  const base = path.basename(normalized).toLowerCase();
  if (normalized.includes('/.git/') || normalized.includes('/.dart_tool/') || normalized.includes('/build/') || normalized.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/native runtime binary must not be bundled in Q286: ${normalized}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q286: ${normalized}`);
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
  status: 'FULL_CAMERA_OCR_RUNTIME_PREMIUM_REGRESSION_Q286_STATIC_READY_BUT_REAL_RUNTIME_AND_FLUTTER_RETEST_REQUIRED',
  sourcePhase,
  selectedEngineLabel: q286.selectedEngineLabel,
  regressionMode: q286.regressionMode,
  requiredFullRegressionGates: q286.requiredFullRegressionGates.length,
  blockedUntilRealEvidence: q286.blockedUntilRealEvidence.length,
  regressionCourtCases: q286.regressionCourtCases.length,
  forbiddenActions: q286.forbiddenActions.length,
  realFullCameraOcrRuntimeRegressionExecutedInQ286: q286.realFullCameraOcrRuntimeRegressionExecutedInQ286,
  realImageToLatexInferenceExecutedInQ286: q286.realImageToLatexInferenceExecutedInQ286,
  realRuntimeInvocationExecutedInQ286: q286.realRuntimeInvocationExecutedInQ286,
  nativeRuntimeBridgeInvokedInQ286: q286.nativeRuntimeBridgeInvokedInQ286,
  realOcrRuntimeAdded: q286.realOcrRuntimeAdded,
  paddleRuntimeAdded: q286.paddleRuntimeAdded,
  paddleOcrDependencyAdded: q286.paddleOcrDependencyAdded,
  modelBinaryBundledInBaseApp: q286.modelBinaryBundledInBaseApp,
  fullCameraOcrRuntimeRegressionPassClaimed: q286.fullCameraOcrRuntimeRegressionPassClaimed,
  ocrPassClaimed: q286.ocrPassClaimed,
  protectedHashComparison: 'PASS',
}, null, 2));

// V172-Q299 successor-awareness marker: V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT
