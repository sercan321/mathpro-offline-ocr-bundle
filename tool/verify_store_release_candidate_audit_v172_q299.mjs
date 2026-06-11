import fs from 'fs';
import crypto from 'crypto';
import path from 'path';

function fail(message) {
  console.error(`[Q299 VERIFY FAIL] ${message}`);
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

const phase = 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT';
const q300SuccessorPhase = 'V172-Q300-RELEASE-CANDIDATE-FREEZE';
const q301SuccessorPhase = 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK';
const q302SuccessorPhase = 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK';
const sourcePhase = 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION';
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q299 = manifest.q299StoreReleaseCandidateAudit;
if (![phase, q300SuccessorPhase, q301SuccessorPhase, q302SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q299 or Q300/Q301 successor');
if ([q300SuccessorPhase, q301SuccessorPhase].includes(manifest.cameraOcrLatestPhase) && !manifest.q300ReleaseCandidateFreeze) fail('Q300 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q301SuccessorPhase && !manifest.q301ProductDevelopmentTrackRebaseStoreTrackPark) fail('Q301 successor envelope missing');
if (manifest.cameraOcrLatestPhase === q302SuccessorPhase && !manifest.q302RealPpFormulaNetSArtifactUrlShaLock) fail('Q302 successor envelope missing');
if (manifest.storeReleaseCandidateAuditLatestPhase !== phase) fail('manifest Q299 latest phase marker missing');
if (!q299) fail('manifest q299StoreReleaseCandidateAudit envelope missing');
if (q299.phase !== phase) fail('Q299 phase mismatch');
if (q299.sourcePhase !== sourcePhase) fail('Q299 source phase mismatch');
if (q299.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q299 selected engine mismatch');
if (q299.auditFeatureFlag !== 'gauss.storeReleaseCandidate.audit.defaultOff') fail('Q299 default-off audit flag mismatch');
if (!String(q299.auditReadinessState || '').includes('BLOCKED_PENDING_REAL_STORE_ASSET')) fail('Q299 readiness must remain blocked pending real store evidence');

for (const key of [
  'q298FullRealCameraOcrRegressionRequired',
  'q297ApprovedWorkspaceImportRequired',
  'q296EditableMathLiveReviewRequired',
  'q295ImageToLatexInferenceEvidenceRequired',
  'q294DummyInputRuntimeCallEvidenceRequired',
  'q293RuntimeStartupEvidenceRequired',
  'q292PrivateArtifactLoadEvidenceRequired',
  'q291PrivateModelDownloadShaEvidenceRequired',
  'q288ArtifactSourceIntakeRequired',
  'privacyPolicyRequired',
  'dataSafetyFormRequired',
  'cameraPermissionDisclosureRequired',
  'modelLicenseDisclosureRequired',
  'truthfulOcrClaimsRequired',
  'screenshotsRealDeviceEvidenceRequired',
  'localizationReviewRequired',
  'noMedicalFinancialOrExamGuaranteeClaims',
  'editableMathLiveReviewStillRequired',
  'explicitUserApprovalStillRequired',
  'workspaceImportOnlyAfterApproval',
  'manualSolveGraphAfterImportOnly',
]) {
  if (q299[key] !== true) fail(`Q299 ${key} must be true`);
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
  'storeSubmissionPerformed',
  'playConsoleConfigured',
  'privacyPolicyPublished',
  'dataSafetyFormCompleted',
  'productionReleaseCreated',
  'internalTestingTrackUploaded',
  'realStoreListingAssetsAttached',
  'realLocalizedListingsAttached',
  'fullRealCameraOcrRegressionExecuted',
  'realImageToLatexInferenceExecuted',
  'realWorkspaceImportRuntimeExecuted',
  'nativeRuntimeStartupExecuted',
  'realModelDownloadedAndShaVerified',
  'methodChannelRuntimeBindingAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'modelBinaryBundledInBaseApp',
  'productionDownloadEnabled',
  'directWorkspaceImportEnabled',
  'autoEvaluateEnabled',
  'autoSolveGraphSolutionHistoryEnabled',
  'solutionHistoryWriteEnabled',
  'storeReleaseCandidatePassClaimed',
  'storeReadyPassClaimed',
  'releasePassClaimed',
  'privacyPolicyPassClaimed',
  'dataSafetyPassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'premiumFinalPassClaimed',
]) {
  if (q299[key] !== false) fail(`Q299 ${key} must be false`);
}

for (const marker of [
  'q298-full-real-camera-ocr-regression-contract-present',
  'q297-approved-workspace-import-contract-present',
  'q296-editable-mathlive-review-contract-present',
  'q295-image-to-latex-inference-contract-present',
  'privacy-policy-required',
  'data-safety-form-required',
  'camera-permission-disclosure-required',
  'model-license-source-disclosure-required',
  'truthful-ocr-claims-required',
  'real-device-screenshot-evidence-required',
  'localization-review-required',
  'keyboard-layout-preserved',
  'mathlive-production-route-preserved',
  'editable-mathlive-review-required',
  'explicit-user-approval-required',
  'workspace-import-only-after-approval',
  'no-auto-evaluate-solve-graph-solution-history',
]) {
  if (!q299.requiredStoreAuditGates.includes(marker)) fail(`Q299 required store audit gate missing: ${marker}`);
}
for (const courtCase of [
  'privacy-policy-link-and-in-app-policy-review',
  'play-console-data-safety-form-review',
  'camera-permission-purpose-limitation-review',
  'ocr-claims-no-fake-accuracy-or-photomath-guarantee-review',
  'app-bundle-hygiene-and-no-model-binary-in-base-apk-review',
  'fake-pass-release-claim-guard',
]) {
  if (!q299.storeAuditCourtCases.includes(courtCase)) fail(`Q299 court case missing: ${courtCase}`);
}
for (const evidence of [
  'real-privacy-policy-url-and-in-app-access-evidence',
  'real-play-console-data-safety-form-screenshot-or-export',
  'real-camera-permission-disclosure-review-evidence',
  'real-store-screenshots-from-supported-devices',
  'real-flutter-analyze-log',
  'real-flutter-test-log',
  'real-flutter-run-device-log',
  'real-internal-test-track-upload-evidence',
]) {
  if (!q299.blockedUntilRealEvidence.includes(evidence)) fail(`Q299 evidence blocker missing: ${evidence}`);
}
for (const action of [
  'submitPlayStoreReleaseInQ299',
  'claimStoreReadyPassWithoutPlayConsoleEvidence',
  'claimReleasePassWithoutRealDeviceAndStoreAuditEvidence',
  'claimOcrPassWithoutRealInferenceEvidence',
  'addPaddleRuntimeDependencyInQ299',
  'bindRuntimeMethodChannelInQ299',
  'bundlePPFormulaNetSModelInBaseApkInQ299',
  'autoSolveCameraOutput',
]) {
  if (!q299.forbiddenActions.includes(action)) fail(`Q299 forbidden action missing: ${action}`);
}

for (const file of [
  'lib/features/camera/gauss_store_release_candidate_audit_policy.dart',
  'lib/features/camera/gauss_store_release_candidate_audit.dart',
  'test/v172_q299_store_release_candidate_audit_test.dart',
  'tool/verify_store_release_candidate_audit_v172_q299.mjs',
  'docs/audit/V172_Q299_STORE_RELEASE_CANDIDATE_AUDIT.md',
  'docs/audit/V172_Q299_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q299 file missing: ${file}`);
}

const policy = read('lib/features/camera/gauss_store_release_candidate_audit_policy.dart');
const gate = read('lib/features/camera/gauss_store_release_candidate_audit.dart');
const test = read('test/v172_q299_store_release_candidate_audit_test.dart');
const audit = read('docs/audit/V172_Q299_STORE_RELEASE_CANDIDATE_AUDIT.md');
const changed = read('docs/audit/V172_Q299_CHANGED_FILES.md');
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const q298Verifier = read('tool/verify_full_real_camera_ocr_regression_v172_q298.mjs');

if (!policy.includes(phase) || !policy.includes('storeSubmissionPerformed = false') || !policy.includes('gauss.storeReleaseCandidate.audit.defaultOff')) fail('Q299 policy markers missing');
if (!gate.includes('storeAuditContractReadyReleaseBlocked') || !gate.includes('canSubmitStoreReleaseInQ299 => false') || !gate.includes('canClaimReleasePassInQ299 => false')) fail('Q299 gate markers missing');
if (!test.includes('gauss.storeReleaseCandidate.audit.defaultOff') || !test.includes('refuses store/release/OCR PASS claims')) fail('Q299 test markers missing');
if (!audit.includes('Store Release Candidate Audit') || !audit.includes('Runtime Boundary') || !audit.includes('does **not**')) fail('Q299 audit markers missing');
if (!changed.includes('gauss_store_release_candidate_audit_policy.dart')) fail('Q299 changed files must disclose new policy');
if (!readme.includes('V172-Q299')) fail('README must mention Q299');
if (!q298Verifier.includes(phase)) fail('Q298 verifier must be Q299 successor-aware');

const modifiedSection = changed.split('## Modified For Successor Awareness Only')[0];
for (const protectedPath of ['MainActivity.kt','AndroidManifest.xml','mathlive_prod_bridge.js','mathlive_production_editor_surface.dart','gauss_camera_capture_shell.dart','workspace_panel.dart']) {
  if (modifiedSection.includes(protectedPath)) fail(`Q299 modified section must not list protected runtime file as changed: ${protectedPath}`);
}
for (const forbidden of q299.blockedDependencyFamilies) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q299');

for (const file of walk('.')) {
  const normalized = file.replace(/^\.\//, '').replace(/\\/g, '/');
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
  status: 'STORE_RELEASE_CANDIDATE_AUDIT_STATIC_READY_RELEASE_BLOCKED',
  sourcePhase,
  selectedEngineLabel: q299.selectedEngineLabel,
  auditFeatureFlag: q299.auditFeatureFlag,
  auditReadinessState: q299.auditReadinessState,
  protectedHashComparison: 'PASS',
  storeSubmissionPerformed: q299.storeSubmissionPerformed,
  playConsoleConfigured: q299.playConsoleConfigured,
  privacyPolicyPublished: q299.privacyPolicyPublished,
  dataSafetyFormCompleted: q299.dataSafetyFormCompleted,
  modelBinaryBundledInBaseApp: q299.modelBinaryBundledInBaseApp,
  productionDownloadEnabled: q299.productionDownloadEnabled,
  storeReadyPassClaimed: q299.storeReadyPassClaimed,
  releasePassClaimed: q299.releasePassClaimed,
  ocrPassClaimed: q299.ocrPassClaimed,
}, null, 2));

// V172-Q302 successor-awareness marker: V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK
