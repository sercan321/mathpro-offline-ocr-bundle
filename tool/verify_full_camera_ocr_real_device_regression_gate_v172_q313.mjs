#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';
const successorPhase = 'V172-Q313R1-FLUTTER-LOG-REPAIR-Q295-PATH-ESCAPE-Q152-SUCCESSOR-AWARE';
const successorPhaseQ313R2 = 'V172-Q313R2-FLUTTER-ANALYZE-INFO-HYGIENE';
const successorPhaseQ313R3 = 'V172-Q313R3-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
const successorPhaseQ314 = 'V172-Q314-REAL-OCR-IMPLEMENTATION-READINESS-ARTIFACT-ACQUISITION-PLAN';
const successorPhaseQ315 = 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE';
const q315R1SuccessorPhase = 'V172-Q315R1-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE-FLUTTER-TEST-REPAIR';
const q316SuccessorPhase = 'V172-Q316-RUNTIME-DEPENDENCY-FEASIBILITY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q317SuccessorPhase = 'V172-Q317-ANDROID-NATIVE-BRIDGE-MINIMAL-HEALTHCHECK-BEHIND-FLAG';
const q318SuccessorPhase = 'V172-Q318-PRIVATE-MODEL-DOWNLOAD-STORAGE-REAL-IMPLEMENTATION';
const q319SuccessorPhase = 'V172-Q319-VERIFIED-ARTIFACT-LOAD-SMOKE-ON-DEVICE';
const q320SuccessorPhase = 'V172-Q320-RUNTIME-STARTUP-SMOKE-ON-DEVICE';
const q321SuccessorPhase = 'V172-Q321-DUMMY-INPUT-RUNTIME-CALL';
const q322SuccessorPhase = 'V172-Q322-FIRST-IMAGE-TO-LATEX-INFERENCE-ENVELOPE';
const q323SuccessorPhase = 'V172-Q323-RUNTIME-DEPENDENCY-MODEL-LOADER-DECISION-IMPLEMENTATION';
const q324SuccessorPhase = 'V172-Q324-APPROVED-RUNTIME-DEPENDENCY-TRIAL-BEHIND-DEFAULT-OFF-FLAG';
const q325SuccessorPhase = 'V172-Q325-EXPLICIT-RUNTIME-DEPENDENCY-COORDINATE-SELECTION-BUILD-TRIAL-GATE';
const q326SuccessorPhase = 'V172-Q326-NATIVE-LIBRARY-BUILD-TRIAL-APPROVAL-ABI-PACKAGING-PREFLIGHT';
const q327SuccessorPhase = 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK';
const q328SuccessorPhase = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const q329SuccessorPhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const q330SuccessorPhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';
const q335SuccessorPhase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const phase = 'V172-Q313-FULL-CAMERA-OCR-REAL-DEVICE-REGRESSION-GATE';
const sourcePhase = 'V172-Q312-APPROVED-OCR-WORKSPACE-IMPORT-RUNTIME-BINDING-GATE';
const fail = (msg) => { console.error(`[Q313][FAIL] ${msg}`); process.exit(1); };
const read = (p) => fs.readFileSync(p, 'utf8');
const sha = (p) => crypto.createHash('sha256').update(fs.readFileSync(p)).digest('hex');
function walk(dir) {
  let out = [];
  for (const entry of fs.readdirSync(dir)) {
    const p = path.join(dir, entry);
    const st = fs.statSync(p);
    if (st.isDirectory()) out = out.concat(walk(p)); else out.push(p);
  }
  return out;
}

if (!fs.existsSync('assets/mathlive/manifest.json')) fail('manifest missing');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
if (![phase, successorPhase, successorPhaseQ313R2, successorPhaseQ313R3, successorPhaseQ314, successorPhaseQ315, q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) fail(`cameraOcrLatestPhase mismatch: ${manifest.cameraOcrLatestPhase}`);
if (![phase, successorPhase, successorPhaseQ313R2, successorPhaseQ313R3, successorPhaseQ314, successorPhaseQ315, q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase, q319SuccessorPhase, q320SuccessorPhase, q321SuccessorPhase, q322SuccessorPhase, q323SuccessorPhase, q324SuccessorPhase, q325SuccessorPhase, q326SuccessorPhase, q327SuccessorPhase, q328SuccessorPhase, q329SuccessorPhase, q330SuccessorPhase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase)) fail('activeProductDevelopmentLatestPhase must point to Q313 or Q313R1 successor');
if (manifest.fullCameraOcrRealDeviceRegressionGateLatestPhase !== phase) fail('Q313 latest manifest pointer missing');
const q313 = manifest.v172Q313FullCameraOcrRealDeviceRegressionGate;
if (!q313) fail('manifest Q313 envelope missing');
if (q313.phase !== phase) fail('Q313 phase mismatch');
if (q313.sourcePhase !== sourcePhase) fail('Q313 source phase mismatch');
if (q313.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q313 selected engine mismatch');
if (q313.fullRegressionFeatureFlag !== 'gauss.ppFormulaNetS.fullCameraOcrRealDeviceRegression.defaultOff') fail('Q313 feature flag mismatch');
if (q313.readinessState !== 'BLOCKED_PENDING_REAL_OCR_RUNTIME_DEVICE_EVIDENCE') fail('Q313 readiness state mismatch');

for (const key of [
  'contractStaticReady','fullRegressionGateDefined','fullRegressionDefaultOff','productDevelopmentTrackActive','storeReleaseTrackParked',
  'q302ArtifactUrlShaLockGatePresent','q303RuntimeDependencyTrialGatePresent','q304AndroidNativeBridgeGatePresent','q305PrivateModelDownloadWorkerGatePresent','q306ShaAtomicMoveGatePresent','q307PrivateArtifactLoadGatePresent','q308RuntimeStartupGatePresent','q309DummyInputRuntimeCallGatePresent','q310ImageToLatexInferenceGatePresent','q311EditableMathLiveReviewGatePresent','q312ApprovedWorkspaceImportGatePresent','editableMathLiveReviewRequired','explicitUserApprovalRequired','directWorkspaceImportBlockedBeforeApproval','directEvaluateBlocked','directSolveGraphSolutionHistoryBlocked','manualSolveGraphAfterApprovedImportOnly','realAndroidFullRegressionLogRequired','protectedSurfaceRegressionBlocked','rollbackPolicyPresent','timeoutPolicyPresent','memoryPressurePolicyPresent'
]) { if (q313[key] !== true) fail(`Q313 ${key} must be true`); }

for (const key of [
  'realModelSha256Verified','realRuntimeDependencyAdded','nativeMethodChannelBindingImplemented','nativeHandlerImplemented','realPrivateArtifactLoaded','realRuntimeStartupExecuted','realDummyInputRuntimeCallExecuted','realImageToLatexInferenceExecuted','realEditableMathLiveReviewOpened','realWorkspaceImportExecuted','pubspecChanged','androidManifestChanged','mainActivityChanged','mathLiveProductionRouteChanged','mathLiveBridgeChanged','keyboardLayoutChanged','moreTemplateTrayChanged','longPressListsChanged','graphSolutionHistoryChanged','cameraShellRuntimeChanged','workspaceRuntimeChanged','splashIconChanged','solverEvaluatorChanged','cameraDependencyChanged','androidToolchainChanged','paddleRuntimeAdded','paddleOcrDependencyAdded','jniNativeHandlerAdded','methodChannelRuntimeBindingAdded','productionDownloadEnabled','modelBinaryBundledInBaseApp','autoEvaluateEnabled','autoSolveGraphSolutionHistoryEnabled','solutionHistoryWriteEnabled','runtimeIntegrationPassClaimed','ocrPassClaimed','cameraOcrRuntimePassClaimed','workspaceImportPassClaimed','storeReadyPassClaimed','releasePassClaimed','changesRuntimeBehavior'
]) { if (q313[key] !== false) fail(`Q313 ${key} must be false`); }

for (const item of ['q302-controlled-artifact-url-and-sha-lock-evidence','q303-runtime-dependency-real-trial-device-build-evidence','q304-android-native-bridge-implementation-evidence','q305-private-model-download-worker-evidence','q306-sha-verification-and-atomic-move-evidence','q307-private-artifact-load-real-device-smoke-evidence','q308-runtime-startup-real-device-smoke-evidence','q309-dummy-input-real-runtime-call-evidence','q310-first-image-to-latex-inference-evidence','q311-editable-mathlive-review-ui-evidence','q312-approved-workspace-import-envelope-evidence','flutter-analyze-log','flutter-test-log','flutter-run-real-device-log','protected-workspace-keyboard-graph-solution-history-regression-evidence']) {
  if (!q313.requiredRegressionEvidence.includes(item)) fail(`missing Q313 required evidence: ${item}`);
}
for (const field of ['regressionRunId','deviceId','androidApiLevel','abi','appPhase','expectedSha256','actualSha256','runtimeStartupStatus','dummyInputCallStatus','imageToLatexInferenceStatus','editableReviewStatus','userApprovalStatus','workspaceImportEnvelopeStatus','directSolveGraphSolutionHistoryStatus','protectedSurfaceRegressionStatus','latencyMs','peakMemoryMb','errorCode']) {
  if (!q313.regressionEnvelopeFields.includes(field)) fail(`missing Q313 envelope field: ${field}`);
}
for (const state of ['blockedMissingArtifactShaEvidence','blockedMissingRuntimeDependencyEvidence','blockedMissingNativeBridgeEvidence','blockedMissingImageToLatexEvidence','blockedMissingEditableReviewEvidence','blockedMissingExplicitUserApproval','blockedWorkspaceImportBeforeApproval','regressionEnvelopePrepared']) {
  if (!q313.regressionStates.includes(state)) fail(`missing Q313 regression state: ${state}`);
}
for (const code of ['artifactShaEvidenceMissing','runtimeDependencyEvidenceMissing','nativeBridgeEvidenceMissing','imageToLatexInferenceEvidenceMissing','editableReviewEvidenceMissing','explicitUserApprovalMissing','workspaceImportBeforeApprovalBlocked','directSolveGraphSolutionHistoryBlocked','fakePassClaimBlocked']) {
  if (!q313.errorCodes.includes(code)) fail(`missing Q313 error code: ${code}`);
}
for (const action of ['claimOcrPassInsideQ313Package','claimRuntimePassInsideQ313Package','claimWorkspaceImportPassInsideQ313Package','addPaddleRuntimeInsideQ313Package','callMethodChannelInsideQ313Package','invokeNativeRuntimeInsideQ313Package','runImageToLatexInsideQ313Package','openEditableReviewInsideQ313Package','mutateWorkspaceInsideQ313Package','bypassEditableMathLiveReview','bypassExplicitUserApproval']) {
  if (!q313.forbiddenActions.includes(action)) fail(`missing Q313 forbidden action: ${action}`);
}

for (const file of [
  'lib/features/camera/gauss_full_camera_ocr_real_device_regression_gate_policy.dart',
  'lib/features/camera/gauss_full_camera_ocr_real_device_regression_gate.dart',
  'test/v172_q313_full_camera_ocr_real_device_regression_gate_test.dart',
  'tool/verify_full_camera_ocr_real_device_regression_gate_v172_q313.mjs',
  'docs/audit/V172_Q313_FULL_CAMERA_OCR_REAL_DEVICE_REGRESSION_GATE_AUDIT.md',
  'docs/audit/V172_Q313_CHANGED_FILES.md',
]) { if (!fs.existsSync(file)) fail(`Q313 file missing: ${file}`); }

const policy = read('lib/features/camera/gauss_full_camera_ocr_real_device_regression_gate_policy.dart');
const gate = read('lib/features/camera/gauss_full_camera_ocr_real_device_regression_gate.dart');
const test = read('test/v172_q313_full_camera_ocr_real_device_regression_gate_test.dart');
const audit = read('docs/audit/V172_Q313_FULL_CAMERA_OCR_REAL_DEVICE_REGRESSION_GATE_AUDIT.md');
const changed = read('docs/audit/V172_Q313_CHANGED_FILES.md');
const readme = read('README.md');
const q312Verifier = read('tool/verify_approved_ocr_workspace_import_runtime_binding_gate_v172_q312.mjs');
const pubspec = read('pubspec.yaml');
if (!policy.includes(phase) || !policy.includes('fullRegressionFeatureFlag') || !policy.includes('q302-controlled-artifact-url-and-sha-lock-evidence')) fail('Q313 policy markers missing');
if (!gate.includes('fullRegressionGateDefinedDefaultOff') || !gate.includes('runtime-or-workspace-mutation-forbidden-in-q313-static-package')) fail('Q313 gate markers missing');
if (!test.includes('q313-blocks-incomplete-q302-through-q312-chain') || !test.includes('forbidden-runtime-mutation-and-fake-pass')) fail('Q313 test markers missing');
if (!audit.includes('Full Camera/OCR Real Device Regression') || !audit.includes('does **not** add Paddle/PaddleOCR')) fail('Q313 audit markers missing');
if (!changed.includes('gauss_full_camera_ocr_real_device_regression_gate_policy.dart')) fail('Q313 changed files must disclose new policy');
if (!readme.includes('V172-Q313')) fail('README must mention Q313');
if ([successorPhaseQ313R2, successorPhaseQ313R3, successorPhaseQ314, successorPhaseQ315, q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !readme.includes('V172-Q313R2')) fail('README must mention Q313R2 successor');
if ([successorPhaseQ313R3, successorPhaseQ314, successorPhaseQ315, q315R1SuccessorPhase, q316SuccessorPhase, q317SuccessorPhase, q318SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !readme.includes('V172-Q313R3')) fail('README must mention Q313R3 successor');
if ((manifest.cameraOcrLatestPhase === successorPhaseQ314 || (manifest.cameraOcrLatestPhase === successorPhaseQ315 || manifest.cameraOcrLatestPhase === q315R1SuccessorPhase)) && !readme.includes('V172-Q314')) fail('README must mention Q314 successor');
if ((manifest.cameraOcrLatestPhase === successorPhaseQ315 || manifest.cameraOcrLatestPhase === q315R1SuccessorPhase) && !readme.includes('V172-Q315')) fail('README must mention Q315 successor');
if (!q312Verifier.includes(phase)) fail('Q312 verifier must be Q313 successor-aware');

const modifiedSection = changed.split('## Protected Files Not Modified')[0];
for (const protectedPath of ['MainActivity.kt','AndroidManifest.xml','pubspec.yaml','mathlive_prod_bridge.js','mathlive_production_editor_surface.dart','gauss_camera_capture_shell.dart','workspace_panel.dart','graph_card.dart','solution_steps_panel.dart','history_panel.dart']) {
  if (modifiedSection.includes(protectedPath)) fail(`Q313 modified section must not list protected/runtime file as changed: ${protectedPath}`);
}
for (const forbidden of ['paddleocr','paddle_lite','paddle-lite','onnxruntime','tflite_flutter','workmanager','background_downloader','dio','http:','flutter_downloader']) {
  if (pubspec.toLowerCase().includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q313');

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
  status: 'FULL_CAMERA_OCR_REAL_DEVICE_REGRESSION_GATE_STATIC_READY_RUNTIME_BLOCKED',
  sourcePhase,
  selectedEngineLabel: q313.selectedEngineLabel,
  fullRegressionFeatureFlag: q313.fullRegressionFeatureFlag,
  readinessState: q313.readinessState,
  fullRegressionDefaultOff: q313.fullRegressionDefaultOff,
  realImageToLatexInferenceExecuted: q313.realImageToLatexInferenceExecuted,
  realEditableMathLiveReviewOpened: q313.realEditableMathLiveReviewOpened,
  realWorkspaceImportExecuted: q313.realWorkspaceImportExecuted,
  ocrPassClaimed: q313.ocrPassClaimed
}, null, 2));
