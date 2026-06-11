#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const phase = 'V172-Q293-FIRST-REAL-RUNTIME-STARTUP-SMOKE';
const sourcePhase = 'V172-Q292-REAL-PRIVATE-ARTIFACT-LOAD-SMOKE';
function fail(message) { console.error(`[Q293 VERIFY FAIL] ${message}`); process.exit(1); }
function read(file) { return fs.readFileSync(file, 'utf8'); }
function json(file) { return JSON.parse(read(file)); }
function sha(file) { return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex'); }
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(full));
    else out.push(full);
  }
  return out;
}

const manifest = json('assets/mathlive/manifest.json');
const q292 = manifest.q292RealPrivateArtifactLoadSmoke;
const q293 = manifest.q293FirstRealRuntimeStartupSmoke;
const pubspec = read('pubspec.yaml');
const readme = read('README.md');
const policy = read('lib/features/camera/gauss_first_real_runtime_startup_smoke_policy.dart');
const gate = read('lib/features/camera/gauss_first_real_runtime_startup_smoke.dart');
const test = read('test/v172_q293_first_real_runtime_startup_smoke_test.dart');
const audit = read('docs/audit/V172_Q293_REAL_RUNTIME_STARTUP_SMOKE_AUDIT.md');
const changed = read('docs/audit/V172_Q293_CHANGED_FILES.md');

if (![phase, 'V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL', 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE', 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME', 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME', 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION', 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT', 'V172-Q300-RELEASE-CANDIDATE-FREEZE', 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK', 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q293 or Q294 successor');
if (['V172-Q294-FIRST-REAL-DUMMY-INPUT-RUNTIME-CALL', 'V172-Q295-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE', 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME'].includes(manifest.cameraOcrLatestPhase) && !manifest.q294FirstRealDummyInputRuntimeCall) fail('Q294 successor envelope missing');
if (manifest.firstRealRuntimeStartupSmokeLatestPhase !== phase) fail('manifest Q293 latest marker missing');
if (!q292) fail('Q292 real private artifact load smoke envelope missing');
if (q292.realPrivateArtifactFileLoaded !== false || q292.modelFormatProbeExecuted !== false || q292.nativeRuntimeBridgeInvoked !== false) fail('Q292 must still block private artifact load/probe/bridge');
if (!q293) fail('Q293 envelope missing');
if (q293.phase !== phase) fail('Q293 phase mismatch');
if (q293.sourcePhase !== sourcePhase) fail('Q293 source phase mismatch');
if (q293.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q293 selected engine mismatch');
if (q293.startupFeatureFlag !== 'gauss.ppFormulaNetS.firstRealRuntimeStartupSmoke.defaultOff') fail('Q293 startup feature flag mismatch');
if (q293.startupReadinessState !== 'BLOCKED_PENDING_Q292_REAL_PRIVATE_ARTIFACT_LOAD_AND_NATIVE_RUNTIME_EVIDENCE') fail('Q293 readiness state must stay blocked/pending');
if (!q293.runtimeActivationDecision.includes('blocked-until-verified-private-artifact')) fail('Q293 activation decision must remain blocked on verified artifact/native runtime evidence');
if (q293.runtimeProcessPolicy !== 'isolated-runtime-startup-only-no-image-inference-no-workspace-mutation') fail('Q293 runtime process policy mismatch');

for (const key of [
  'q292RealPrivateArtifactLoadRequired',
  'q292RealPrivateArtifactLoadStillPending',
  'verifiedPrivateArtifactRequired',
  'expectedActualShaMatchRequired',
  'modelFormatProbeRequiredBeforeStartup',
  'nativeRuntimePackageRequiredBeforeStartup',
  'supportedAndroidAbiRequired',
  'startupTimeoutPolicyRequired',
  'startupCancellationPolicyRequired',
  'memoryPressurePolicyRequired',
  'startupEvidenceLogRequired',
  'editableMathLiveReviewRequired',
  'explicitUserApprovalRequiredBeforeWorkspaceImport',
  'directSolveGraphSolutionHistoryBlocked',
]) {
  if (q293[key] !== true) fail(`Q293 ${key} must be true`);
}

for (const key of [
  'changesRuntimeBehavior',
  'keyboardLayoutChanged',
  'moreTemplateTrayChanged',
  'longPressListsChanged',
  'graphSolutionHistoryChanged',
  'mathLiveProductionRouteChanged',
  'cameraShellRuntimeChanged',
  'workspaceRuntimeChanged',
  'solverEvaluatorChanged',
  'androidToolchainChanged',
  'cameraDependencyChanged',
  'androidManifestChanged',
  'mainActivityChanged',
  'startupFeatureFlagEnabledByDefault',
  'realRuntimeStartupExecuted',
  'nativeRuntimePackageBundled',
  'nativeRuntimeHandlerImplemented',
  'methodChannelRuntimeBindingAdded',
  'jniBindingAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'runtimeDependencyAddedToPubspec',
  'gradleNativeRuntimeDependencyAdded',
  'realPrivateArtifactFileLoaded',
  'modelFormatProbeExecuted',
  'runtimeWarmupCallExecuted',
  'imageToLatexInferenceExecuted',
  'modelBinaryBundledInBaseApp',
  'productionDownloadEnabled',
  'directWorkspaceImportEnabled',
  'directSolveGraphSolutionHistoryEnabled',
  'runtimeStartupPassClaimed',
  'runtimeSmokePassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'storeReadyPassClaimed',
  'releasePassClaimed',
]) {
  if (q293[key] !== false) fail(`Q293 ${key} must be false`);
}

for (const marker of [
  'q292-real-private-artifact-load-smoke-present',
  'q292-real-private-artifact-load-still-pending',
  'verified-private-artifact-required-before-runtime-startup',
  'expected-actual-sha256-match-required-before-runtime-startup',
  'model-format-probe-required-before-runtime-startup',
  'native-runtime-package-required-before-runtime-startup',
  'supported-android-abi-required-before-runtime-startup',
  'startup-timeout-budget-required',
  'startup-cancellation-policy-required',
  'memory-pressure-policy-required',
  'runtime-startup-evidence-log-required',
  'editable-mathlive-review-and-explicit-user-approval-remain-mandatory',
  'direct-solve-graph-solution-history-remain-blocked-for-camera-output',
  'no-real-runtime-startup-without-user-side-native-runtime-evidence',
]) {
  if (!q293.runtimeStartupSmokePreconditions.includes(marker)) fail(`Q293 precondition missing: ${marker}`);
}
for (const field of ['requestId', 'engineLabel', 'verifiedPrivateArtifactPath', 'expectedSha256', 'actualSha256', 'runtimePackageId', 'androidAbi', 'startupTimeoutMs', 'startupFeatureFlagEnabled', 'modelFormatProbeStatus', 'privateArtifactLoadStatus', 'startupMode']) {
  if (!q293.runtimeStartupRequestFields.includes(field)) fail(`Q293 request field missing: ${field}`);
}
for (const field of ['requestId', 'status', 'runtimeProcessStarted', 'modelArtifactOpened', 'modelFormatProbePassed', 'warmupCallExecuted', 'imageInferenceExecuted', 'errorCode', 'warnings', 'startupLatencyMs', 'peakMemoryMb', 'reviewRequired', 'directWorkspaceMutationAttempted']) {
  if (!q293.runtimeStartupResultFields.includes(field)) fail(`Q293 result field missing: ${field}`);
}
for (const code of ['startupFeatureFlagOff', 'verifiedArtifactMissing', 'artifactShaMismatch', 'privateArtifactLoadMissing', 'modelFormatProbeMissing', 'nativeRuntimePackageMissing', 'unsupportedAbi', 'methodChannelNotBound', 'nativeHandlerNotImplemented', 'startupTimeout', 'startupCancelled', 'memoryPressure', 'noRealRuntimeStartupExecutedInQ293']) {
  if (!q293.runtimeStartupErrorCodes.includes(code)) fail(`Q293 error code missing: ${code}`);
}

for (const file of [
  'lib/features/camera/gauss_first_real_runtime_startup_smoke_policy.dart',
  'lib/features/camera/gauss_first_real_runtime_startup_smoke.dart',
  'test/v172_q293_first_real_runtime_startup_smoke_test.dart',
  'tool/verify_first_real_runtime_startup_smoke_v172_q293.mjs',
  'docs/audit/V172_Q293_REAL_RUNTIME_STARTUP_SMOKE_AUDIT.md',
  'docs/audit/V172_Q293_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q293 file missing: ${file}`);
}

if (!policy.includes(phase) || !policy.includes('realRuntimeStartupExecuted = false') || !policy.includes('startupFeatureFlagEnabledByDefault = false')) fail('Q293 policy markers missing');
if (!gate.includes('startupSmokeContractReadyRealStartupBlocked') || !gate.includes('noRealRuntimeStartupExecutedInQ293')) fail('Q293 gate markers missing');
if (!test.includes('gauss.ppFormulaNetS.firstRealRuntimeStartupSmoke.defaultOff') || !test.includes('noRealRuntimeStartupExecutedInQ293')) fail('Q293 test markers missing');
if (!audit.includes('First Real Runtime Startup Smoke') || !audit.includes('Runtime Boundary') || !audit.includes('does not add Paddle runtime')) fail('Q293 audit markers missing');
if (!changed.includes('gauss_first_real_runtime_startup_smoke_policy.dart')) fail('Q293 changed files must disclose new policy');
if (changed.includes('- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`') || changed.includes('- `android/app/src/main/AndroidManifest.xml`') || changed.includes('- `assets/mathlive/mathlive_prod_bridge.js`') || changed.includes('- `lib/features/mathlive/mathlive_production_editor_surface.dart`') || changed.includes('- `lib/features/camera/gauss_camera_capture_shell.dart`')) fail('Q293 changed files must not list protected runtime files as changed');
if (!readme.includes('V172-Q293')) fail('README must mention Q293');

for (const verifier of [
  'tool/verify_camera_ocr_runtime_premium_regression_tap_latency_cadence_v172_q277r3.mjs',
  'tool/verify_real_runtime_integration_evidence_lock_v172_q278.mjs',
  'tool/verify_selected_runtime_dependency_trial_v172_q279.mjs',
  'tool/verify_native_runtime_bridge_implementation_v172_q280.mjs',
  'tool/verify_private_artifact_load_real_smoke_v172_q281.mjs',
  'tool/verify_first_real_runtime_smoke_on_device_v172_q282.mjs',
  'tool/verify_first_real_image_to_latex_inference_court_v172_q283.mjs',
  'tool/verify_ocr_result_real_mathlive_review_runtime_binding_v172_q284.mjs',
  'tool/verify_approved_ocr_workspace_import_runtime_court_v172_q285.mjs',
  'tool/verify_full_camera_ocr_runtime_premium_regression_v172_q286.mjs',
  'tool/verify_store_readiness_camera_ocr_release_audit_v172_q287.mjs',
  'tool/verify_store_readiness_camera_ocr_release_audit_log_repair_v172_q287r1.mjs',
  'tool/verify_store_readiness_camera_ocr_release_audit_test_doc_section_repair_v172_q287r2.mjs',
  'tool/verify_real_ocr_artifact_source_intake_v172_q288.mjs',
  'tool/verify_runtime_dependency_actual_trial_default_off_v172_q289.mjs',
  'tool/verify_native_runtime_handler_skeleton_android_binding_v172_q290.mjs',
  'tool/verify_private_model_download_sha_verification_runtime_v172_q291.mjs',
  'tool/verify_real_private_artifact_load_smoke_v172_q292.mjs',
]) {
  if (!read(verifier).includes(phase)) fail(`successor-aware verifier missing Q293 marker: ${verifier}`);
}

for (const forbidden of q293.blockedDependencyFamilies) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q293');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors', '.so', '.aar'];
for (const file of walk('.')) {
  const normalized = file.replaceAll('\\', '/');
  const base = path.basename(normalized).toLowerCase();
  if (normalized.includes('/.git/') || normalized.includes('/.dart_tool/') || normalized.includes('/build/') || normalized.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/native runtime binary must not be bundled in Q293: ${normalized}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q293: ${normalized}`);
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
  status: 'FIRST_REAL_RUNTIME_STARTUP_SMOKE_STATIC_READY_REAL_STARTUP_BLOCKED',
  sourcePhase,
  selectedEngineLabel: q293.selectedEngineLabel,
  startupFeatureFlag: q293.startupFeatureFlag,
  startupReadinessState: q293.startupReadinessState,
  protectedHashComparison: 'PASS',
  realRuntimeStartupExecuted: q293.realRuntimeStartupExecuted,
  nativeRuntimeHandlerImplemented: q293.nativeRuntimeHandlerImplemented,
  methodChannelRuntimeBindingAdded: q293.methodChannelRuntimeBindingAdded,
  realPrivateArtifactFileLoaded: q293.realPrivateArtifactFileLoaded,
  modelFormatProbeExecuted: q293.modelFormatProbeExecuted,
  runtimeWarmupCallExecuted: q293.runtimeWarmupCallExecuted,
  imageToLatexInferenceExecuted: q293.imageToLatexInferenceExecuted,
  ocrPassClaimed: q293.ocrPassClaimed,
  cameraOcrRuntimePassClaimed: q293.cameraOcrRuntimePassClaimed,
  storeReadyPassClaimed: q293.storeReadyPassClaimed,
  releasePassClaimed: q293.releasePassClaimed,
}, null, 2));

// V172-Q299 successor-awareness marker: V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT
