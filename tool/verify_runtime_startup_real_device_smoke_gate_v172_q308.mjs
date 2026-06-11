#!/usr/bin/env node
import fs from 'node:fs';
import crypto from 'node:crypto';
import path from 'node:path';

const successorPhase = 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE';
const phase = 'V172-Q308-RUNTIME-STARTUP-REAL-DEVICE-SMOKE-GATE';
const q309SuccessorPhase = 'V172-Q309-DUMMY-INPUT-REAL-RUNTIME-CALL-GATE';
const q310SuccessorPhase = 'V172-Q310-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GATE';
const sourcePhase = 'V172-Q307-PRIVATE-ARTIFACT-LOAD-REAL-DEVICE-SMOKE-GATE';
const fail = (msg) => { console.error(`[Q308][FAIL] ${msg}`); process.exit(1); };
const read = (p) => fs.readFileSync(p, 'utf8');
const sha = (p) => crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex');
const json = (p) => JSON.parse(read(p));
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
if (![phase, q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR', 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN', 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE', 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR', 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG', 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION'].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase must be ${phase} or Q309 successor`);
if (manifest.latestPhase !== phase) fail(`latestPhase mismatch: ${manifest.latestPhase}`);
if (![phase, q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR', 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN', 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE', 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR', 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG', 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION'].includes(manifest.activeProductDevelopmentLatestPhase)) fail(`activeProductDevelopmentLatestPhase must be ${phase} or Q309 successor`);
if (manifest.runtimeStartupRealDeviceSmokeGateLatestPhase !== phase) fail('runtimeStartupRealDeviceSmokeGateLatestPhase missing/mismatch');
const q308 = manifest.v172Q308RuntimeStartupRealDeviceSmokeGate;
if (!q308) fail('manifest Q308 envelope missing');
if (q308.phase !== phase) fail('Q308 phase mismatch');
if (q308.sourcePhase !== sourcePhase) fail('Q308 source phase mismatch');
if (q308.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q308 selected engine mismatch');
if (q308.runtimeStartupFeatureFlag !== 'gauss.ppFormulaNetS.runtimeStartupRealDeviceSmoke.defaultOff') fail('Q308 feature flag mismatch');
if (q308.readinessState !== 'BLOCKED_PENDING_Q307_PRIVATE_ARTIFACT_LOAD_AND_REAL_DEVICE_RUNTIME_STARTUP_EVIDENCE') fail('Q308 readiness state mismatch');

for (const key of [
  'q307PrivateArtifactLoadSmokeGatePresent','androidAbiMatrixReviewed','runtimeStartupTimeoutPolicyPresent','runtimeMemoryPressurePolicyPresent','realAndroidDeviceStartupLogRequired','rollbackPlanPresent','defaultOffFeatureFlagPresent','runtimeStartupSmokeGateDefined','runtimeStartupSmokeDefaultOff','reviewBeforeImportRequired','explicitUserApprovalRequired','directWorkspaceImportBlocked','directSolveGraphSolutionHistoryBlocked'
]) { if (q308[key] !== true) fail(`Q308 ${key} must be true`); }

for (const key of [
  'q306VerifiedPrivateArtifactPathRecorded','q306ExpectedActualSha256Match','q306AtomicMoveSucceeded','q307RealPrivateArtifactLoadEvidencePresent','q307ModelFormatProbeEvidencePresent','nativeRuntimePackageSelected','pubspecChanged','androidManifestChanged','mainActivityChanged','nativeRuntimeDependencyAdded','methodChannelRuntimeBound','jniNativeHandlerImplemented','productionDownloadEnabled','modelBinaryBundledInBaseApp','realPrivateArtifactLoaded','modelFormatProbeExecuted','realRuntimeStartupExecuted','realRuntimeWarmupExecuted','realDummyInputRuntimeCallExecuted','realImageToLatexInferenceExecuted','realEditableMathLiveReviewOpened','realWorkspaceImportExecuted','changesRuntimeBehavior','keyboardLayoutChanged','moreTemplateTrayChanged','longPressListsChanged','graphSolutionHistoryChanged','mathLiveProductionRouteChanged','mathLiveBridgeChanged','cameraShellRuntimeChanged','workspaceRuntimeChanged','solverEvaluatorChanged','splashIconChanged','cameraDependencyChanged','androidToolchainChanged','runtimeStartupPassClaimed','runtimeIntegrationPassClaimed','ocrPassClaimed','cameraOcrRuntimePassClaimed','storeReadyPassClaimed','releasePassClaimed'
]) { if (q308[key] !== false) fail(`Q308 ${key} must be false`); }

for (const item of ['q307-private-artifact-load-smoke-gate-present','q307-real-private-artifact-load-evidence','q307-model-format-probe-evidence','native-runtime-package-selected','real-android-device-startup-log-required']) {
  if (!q308.requiredBeforeRuntimeStartupSmoke.includes(item)) fail(`missing Q308 requirement: ${item}`);
}
for (const field of ['startupRequestId','verifiedPrivatePath','runtimeCandidate','androidAbi','startupState','durationMs','peakMemoryMb','errorCode']) {
  if (!q308.startupEnvelopeFields.includes(field)) fail(`missing Q308 envelope field: ${field}`);
}
for (const state of ['blockedNativeRuntimeNotBound','startupRequested','startupSucceeded','startupFailed','startupTimedOut']) {
  if (!q308.startupStates.includes(state)) fail(`missing Q308 startup state: ${state}`);
}
for (const code of ['nativeRuntimeDependencyMissing','nativeBridgeNotBound','unsupportedAndroidAbi','startupTimeout','runtimeCrash']) {
  if (!q308.errorCodes.includes(code)) fail(`missing Q308 error code: ${code}`);
}
for (const action of ['startRuntimeInsideQ308Package','callMethodChannelInsideQ308Package','addRuntimeDependencyInQ308','modifyMainActivityForRuntimeInQ308','claimRuntimeStartupPassWithoutDeviceEvidence','bypassEditableMathLiveReview']) {
  if (!q308.forbiddenActions.includes(action)) fail(`missing Q308 forbidden action: ${action}`);
}

for (const file of [
  'lib/features/camera/gauss_runtime_startup_real_device_smoke_gate_policy.dart',
  'lib/features/camera/gauss_runtime_startup_real_device_smoke_gate.dart',
  'test/v172_q308_runtime_startup_real_device_smoke_gate_test.dart',
  'tool/verify_runtime_startup_real_device_smoke_gate_v172_q308.mjs',
  'docs/audit/V172_Q308_RUNTIME_STARTUP_REAL_DEVICE_SMOKE_GATE_AUDIT.md',
  'docs/audit/V172_Q308_CHANGED_FILES.md',
]) { if (!fs.existsSync(file)) fail(`Q308 file missing: ${file}`); }

const policy = read('lib/features/camera/gauss_runtime_startup_real_device_smoke_gate_policy.dart');
const gate = read('lib/features/camera/gauss_runtime_startup_real_device_smoke_gate.dart');
const test = read('test/v172_q308_runtime_startup_real_device_smoke_gate_test.dart');
const audit = read('docs/audit/V172_Q308_RUNTIME_STARTUP_REAL_DEVICE_SMOKE_GATE_AUDIT.md');
const changed = read('docs/audit/V172_Q308_CHANGED_FILES.md');
const readme = read('README.md');
const q307Verifier = read('tool/verify_private_artifact_load_real_device_smoke_gate_v172_q307.mjs');
const pubspec = read('pubspec.yaml');

if (!policy.includes(phase) || !policy.includes('runtimeStartupFeatureFlag') || !policy.includes('real-android-device-startup-log-required')) fail('Q308 policy markers missing');
if (!gate.includes('runtimeStartupSmokeGateDefinedDefaultOff') || !gate.includes('runtime-startup-or-runtime-mutation-forbidden-in-q308')) fail('Q308 gate markers missing');
if (!test.includes('q308-must-not-accept-complete-runtime-startup-evidence-inside-static-package') || !test.includes('forbidden-runtime-startup-mutation')) fail('Q308 test markers missing');
if (!audit.includes('Runtime Startup') || !audit.includes('does **not** start a native runtime')) fail('Q308 audit markers missing');
if (!changed.includes('gauss_runtime_startup_real_device_smoke_gate_policy.dart')) fail('Q308 changed files must disclose new policy');
if (!readme.includes('V172-Q308')) fail('README must mention Q308');
if (!q307Verifier.includes(phase)) fail('Q307 verifier must be Q308 successor-aware');

const modifiedSection = changed.split('## Protected Files Not Modified')[0];
for (const protectedPath of ['MainActivity.kt','AndroidManifest.xml','pubspec.yaml','mathlive_prod_bridge.js','mathlive_production_editor_surface.dart','gauss_camera_capture_shell.dart','workspace_panel.dart','graph_card.dart','solution_steps_panel.dart','history_panel.dart']) {
  if (modifiedSection.includes(protectedPath)) fail(`Q308 modified section must not list protected/runtime file as changed: ${protectedPath}`);
}
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q308');

for (const file of walk('.')) {
  const normalized = file.split(path.sep).join('/').replace(/^\.\//, '');
  if (/\.(apk|aab|onnx|pdmodel|pdiparams|pdparams|nb|tflite|pt|pth|ckpt|zip|tar|aar|so)$/i.test(normalized) && !normalized.startsWith('assets/mathlive/vendor/')) {
    fail(`forbidden binary/archive/model artifact present: ${normalized}`);
  }
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
  status: 'RUNTIME_STARTUP_REAL_DEVICE_SMOKE_GATE_STATIC_READY_STARTUP_BLOCKED',
  sourcePhase,
  selectedEngineLabel: q308.selectedEngineLabel,
  runtimeStartupFeatureFlag: q308.runtimeStartupFeatureFlag,
  readinessState: q308.readinessState,
  runtimeStartupSmokeDefaultOff: q308.runtimeStartupSmokeDefaultOff,
  realRuntimeStartupExecuted: q308.realRuntimeStartupExecuted,
  methodChannelRuntimeBound: q308.methodChannelRuntimeBound,
  ocrPassClaimed: q308.ocrPassClaimed
}, null, 2));
