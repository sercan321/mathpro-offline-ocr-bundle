#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const successorPhase = 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE';
const phase = 'V172-Q306-SHA-VERIFICATION-ATOMIC-MOVE-REAL-RUNTIME-GATE';
const sourcePhase = 'V172-Q305-PRIVATE-MODEL-DOWNLOAD-WORKER-REAL-IMPLEMENTATION-GATE';
const q307SuccessorPhase = 'V172-Q307-PRIVATE-ARTIFACT-LOAD-REAL-DEVICE-SMOKE-GATE';
const q308SuccessorPhase = 'V172-Q308-RUNTIME-STARTUP-REAL-DEVICE-SMOKE-GATE';
const q309SuccessorPhase = 'V172-Q309-DUMMY-INPUT-REAL-RUNTIME-CALL-GATE';
const q310SuccessorPhase = 'V172-Q310-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GATE';
function fail(message) { console.error(`[Q306 BLOCKED] ${message}`); process.exit(1); }
function read(file) { return fs.readFileSync(file, 'utf8'); }
function sha(file) { return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex'); }
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const p = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(p)); else out.push(p);
  }
  return out;
}

if (!fs.existsSync('assets/mathlive/manifest.json')) fail('manifest missing');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
if (![phase, q307SuccessorPhase, q308SuccessorPhase, q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR', 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN', 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE', 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR', 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG', 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION'].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase must be ${phase} or Q307/Q308 successor`);
if (manifest.cameraOcrLatestPhase === q307SuccessorPhase && !manifest.v172Q307PrivateArtifactLoadRealDeviceSmokeGate) fail('Q307 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q308SuccessorPhase && !manifest.v172Q308RuntimeStartupRealDeviceSmokeGate) fail('Q308 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q309SuccessorPhase && !manifest.v172Q309DummyInputRealRuntimeCallGate) fail('Q309 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q310SuccessorPhase && !manifest.v172Q310FirstRealImageToLatexInferenceGate) fail('Q310 successor envelope missing');
if (['V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR', 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN', 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE', 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR', 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG', 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION'].includes(manifest.cameraOcrLatestPhase) && !manifest.v172Q311OcrCandidateEditableMathLiveReviewUiBindingGate) fail('Q311 successor envelope missing');
if (![phase, q307SuccessorPhase, q308SuccessorPhase, q309SuccessorPhase, q310SuccessorPhase, 'V172-Q311-OCR-CANDIDATE-EDITABLE-MATHLIVE-REVIEW-UI-BINDING-GATE', 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE', 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE', 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE', 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE', 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR', 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN', 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE', 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR', 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG', 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG', 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION'].includes(manifest.activeProductDevelopmentLatestPhase)) fail('activeProductDevelopmentLatestPhase must point to Q306/Q307/Q308 successor');
if (manifest.shaVerificationAtomicMoveRealRuntimeGateLatestPhase !== phase) fail('Q306 latest manifest pointer missing');
const q306 = manifest.q306ShaVerificationAtomicMoveRealRuntimeGate;
if (!q306 || q306.phase !== phase) fail('Q306 manifest envelope missing or wrong phase');
if (q306.sourcePhase !== sourcePhase) fail('Q306 source phase mismatch');

for (const [key, expected] of Object.entries({
  selectedEngineLabel: 'PP-FormulaNet-S',
  fallbackEngineLabel: 'PP-FormulaNet_plus-L only',
  verificationFeatureFlag: 'gauss.ppFormulaNetS.shaVerificationAtomicMove.defaultOff',
  verificationMode: 'sha-verification-atomic-move-gate-default-off-no-file-move',
  readinessState: 'BLOCKED_PENDING_Q302_EXPECTED_ACTUAL_SHA_AND_Q305_CONTROLLED_DOWNLOAD_EVIDENCE',
})) {
  if (q306[key] !== expected) fail(`Q306 ${key} mismatch`);
}

for (const key of [
  'shaVerificationAtomicMoveGateDefined',
  'shaVerificationAtomicMoveDefaultOff',
  'q305DownloadWorkerGatePresent',
  'temporaryPrivatePathReviewed',
  'verifiedPrivatePathReviewed',
  'checksumBeforeReadyPolicyReviewed',
  'atomicMoveAfterChecksumPolicyReviewed',
  'partialCorruptCleanupPolicyReviewed',
  'rollbackPlanPresent',
  'defaultOffFeatureFlagPresent',
  'reviewBeforeImportRequired',
  'explicitUserApprovalRequired',
  'directWorkspaceImportBlocked',
  'directSolveGraphSolutionHistoryBlocked',
]) {
  if (q306[key] !== true) fail(`Q306 ${key} must be true`);
}

for (const key of [
  'q302ExpectedSha256Locked',
  'q302ActualSha256Computed',
  'q302ExpectedActualSha256Match',
  'pubspecChanged',
  'androidManifestChanged',
  'mainActivityChanged',
  'productionDownloadEnabled',
  'modelBinaryBundledInBaseApp',
  'realModelDownloadExecuted',
  'actualSha256ComputedInPackage',
  'shaVerificationExecutedInPackage',
  'atomicMoveExecutedInPackage',
  'artifactAcceptedForRuntime',
  'realPrivateArtifactLoaded',
  'realRuntimeStartupExecuted',
  'realDummyInputRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted',
  'realEditableMathLiveReviewOpened',
  'realWorkspaceImportExecuted',
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
  'splashIconChanged',
  'cameraDependencyChanged',
  'androidToolchainChanged',
  'shaVerificationPassClaimed',
  'atomicMovePassClaimed',
  'modelReadyPassClaimed',
  'runtimeIntegrationPassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'storeReadyPassClaimed',
  'releasePassClaimed',
]) {
  if (q306[key] !== false) fail(`Q306 ${key} must be false`);
}

for (const item of ['q302-expected-actual-sha256-match','q305-private-download-worker-evidence','checksum-before-ready','atomic-move-after-checksum-pass','verified-private-artifact-path-recorded']) {
  if (!q306.requiredBeforeArtifactReady.includes(item)) fail(`missing Q306 requirement: ${item}`);
}
for (const field of ['temporaryPrivatePath','verifiedPrivatePath','expectedSha256','actualSha256','verificationState','atomicMoveState']) {
  if (!q306.verificationEnvelopeFields.includes(field)) fail(`missing Q306 envelope field: ${field}`);
}
for (const state of ['checksumMismatch','checksumVerified','atomicMoveSucceeded','atomicMoveFailed']) {
  if (!q306.atomicMoveStates.includes(state)) fail(`missing Q306 atomic move state: ${state}`);
}
for (const code of ['expectedShaMissing','actualShaComputationFailed','checksumMismatch','atomicMoveAttemptedBeforeChecksumPass','verifiedArtifactPathUnsafe']) {
  if (!q306.errorCodes.includes(code)) fail(`missing Q306 error code: ${code}`);
}
for (const action of ['computeRealArtifactShaInsideQ306Package','performAtomicMoveInsideQ306Package','acceptArtifactForRuntimeInsideQ306Package','claimShaModelRuntimeOrOcrPassWithoutEvidence','bypassEditableMathLiveReview']) {
  if (!q306.forbiddenActions.includes(action)) fail(`missing Q306 forbidden action: ${action}`);
}

for (const file of [
  'lib/features/camera/gauss_sha_verification_atomic_move_real_runtime_gate_policy.dart',
  'lib/features/camera/gauss_sha_verification_atomic_move_real_runtime_gate.dart',
  'test/v172_q306_sha_verification_atomic_move_real_runtime_gate_test.dart',
  'tool/verify_sha_verification_atomic_move_real_runtime_gate_v172_q306.mjs',
  'docs/audit/V172_Q306_SHA_VERIFICATION_ATOMIC_MOVE_REAL_RUNTIME_GATE_AUDIT.md',
  'docs/audit/V172_Q306_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q306 file missing: ${file}`);
}

const policy = read('lib/features/camera/gauss_sha_verification_atomic_move_real_runtime_gate_policy.dart');
const gate = read('lib/features/camera/gauss_sha_verification_atomic_move_real_runtime_gate.dart');
const test = read('test/v172_q306_sha_verification_atomic_move_real_runtime_gate_test.dart');
const audit = read('docs/audit/V172_Q306_SHA_VERIFICATION_ATOMIC_MOVE_REAL_RUNTIME_GATE_AUDIT.md');
const changed = read('docs/audit/V172_Q306_CHANGED_FILES.md');
const readme = read('README.md');
const q305Verifier = read('tool/verify_private_model_download_worker_real_implementation_gate_v172_q305.mjs');
const pubspec = read('pubspec.yaml');

if (!policy.includes(phase) || !policy.includes('atomic-move-after-checksum-pass') || !policy.includes('verificationFeatureFlag')) fail('Q306 policy markers missing');
if (!gate.includes('shaVerificationAtomicMoveGateDefinedDefaultOff') || !gate.includes('sha-verification-atomic-move-or-runtime-mutation-forbidden-in-q306')) fail('Q306 gate markers missing');
if (!test.includes('atomicMoveAttemptedBeforeChecksumPass') || !test.includes('q306-must-not-accept-complete-sha-evidence-inside-static-package')) fail('Q306 test markers missing');
if (!audit.includes('SHA Verification') || !audit.includes('does **not** perform atomic move')) fail('Q306 audit markers missing');
if (!changed.includes('gauss_sha_verification_atomic_move_real_runtime_gate_policy.dart')) fail('Q306 changed files must disclose new policy');
if (!readme.includes('V172-Q306')) fail('README must mention Q306');
if (!q305Verifier.includes(phase)) fail('Q305 verifier must be Q306 successor-aware');

const modifiedSection = changed.split('## Protected Files Not Modified')[0];
for (const protectedPath of ['MainActivity.kt','AndroidManifest.xml','pubspec.yaml','mathlive_prod_bridge.js','mathlive_production_editor_surface.dart','gauss_camera_capture_shell.dart','workspace_panel.dart','graph_card.dart','solution_steps_panel.dart','history_panel.dart']) {
  if (modifiedSection.includes(protectedPath)) fail(`Q306 modified section must not list protected/runtime file as changed: ${protectedPath}`);
}
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q306');

for (const file of walk('.')) {
  const normalized = file.split(path.sep).join('/').replace(/^\.\//, '');
  if (/\.(apk|aab|onnx|pdmodel|pdiparams|pdparams|nb|tflite|pt|pth|ckpt|zip|tar|aar|so)$/i.test(normalized) && !normalized.startsWith('assets/mathlive/vendor/')) {
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
  status: 'SHA_VERIFICATION_ATOMIC_MOVE_REAL_RUNTIME_GATE_STATIC_READY_FILE_MOVE_BLOCKED',
  sourcePhase,
  selectedEngineLabel: q306.selectedEngineLabel,
  verificationFeatureFlag: q306.verificationFeatureFlag,
  readinessState: q306.readinessState,
  shaVerificationAtomicMoveDefaultOff: q306.shaVerificationAtomicMoveDefaultOff,
  actualSha256ComputedInPackage: q306.actualSha256ComputedInPackage,
  shaVerificationExecutedInPackage: q306.shaVerificationExecutedInPackage,
  atomicMoveExecutedInPackage: q306.atomicMoveExecutedInPackage,
  artifactAcceptedForRuntime: q306.artifactAcceptedForRuntime,
  ocrPassClaimed: q306.ocrPassClaimed,
}, null, 2));
