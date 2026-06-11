#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const phase = 'V172-Q297-APPROVED-OCR-WORKSPACE-IMPORT-REAL-RUNTIME';
const sourcePhase = 'V172-Q296-OCR-RESULT-EDITABLE-MATHLIVE-REVIEW-REAL-RUNTIME';
function fail(message) { console.error(`[Q297 VERIFY FAIL] ${message}`); process.exit(1); }
function read(file) { return fs.readFileSync(file, 'utf8'); }
function sha(file) { return crypto.createHash('sha256').update(fs.readFileSync(file)).digest('hex'); }
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(full));
    else out.push(full.replaceAll('\\', '/'));
  }
  return out;
}

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const pubspec = read('pubspec.yaml');
const policy = read('lib/features/camera/gauss_approved_ocr_workspace_import_real_runtime_policy.dart');
const gate = read('lib/features/camera/gauss_approved_ocr_workspace_import_real_runtime.dart');
const test = read('test/v172_q297_approved_ocr_workspace_import_real_runtime_test.dart');
const audit = read('docs/audit/V172_Q297_APPROVED_OCR_WORKSPACE_IMPORT_REAL_RUNTIME_AUDIT.md');
const changed = read('docs/audit/V172_Q297_CHANGED_FILES.md');
const readme = read('README.md');
const q296Verifier = read('tool/verify_ocr_result_editable_mathlive_review_real_runtime_v172_q296.mjs');
const q297 = manifest.q297ApprovedOcrWorkspaceImportRealRuntime;

if (![phase, 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION', 'V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT', 'V172-Q300-RELEASE-CANDIDATE-FREEZE', 'V172-Q301-PRODUCT-DEVELOPMENT-TRACK-REBASE-STORE-TRACK-PARK', 'V172-Q302-REAL-PP-FORMULANET-S-ARTIFACT-URL-SHA-LOCK'].includes(manifest.cameraOcrLatestPhase)) fail('manifest cameraOcrLatestPhase must point to Q297 or Q298 successor');
if (manifest.cameraOcrLatestPhase === 'V172-Q298-FULL-REAL-CAMERA-OCR-REGRESSION' && !manifest.q298FullRealCameraOcrRegression) fail('Q298 successor envelope missing');
if (manifest.approvedOcrWorkspaceImportRealRuntimeLatestPhase !== phase) fail('manifest Q297 latest marker missing');
if (!q297) fail('manifest q297ApprovedOcrWorkspaceImportRealRuntime block missing');
if (q297.phase !== phase) fail('Q297 manifest phase mismatch');
if (q297.sourcePhase !== sourcePhase) fail('Q297 source phase mismatch');
if (q297.selectedEngineLabel !== 'PP-FormulaNet-S') fail('Q297 selected engine mismatch');
if (q297.workspaceImportFeatureFlag !== 'gauss.ppFormulaNetS.approvedOcrWorkspaceImport.defaultOff') fail('Q297 feature flag mismatch');
if (!q297.workspaceImportMode.includes('contract-only') || !q297.workspaceImportMode.includes('real-import-blocked')) fail('Q297 mode must be contract-only/real-import-blocked');
if (!q297.workspaceImportReadinessState.includes('BLOCKED_PENDING_Q296')) fail('Q297 readiness must depend on Q296 evidence');

for (const key of [
  'q296EditableMathLiveReviewRequired',
  'q296RealEditableReviewStillPending',
  'acceptedEditableReviewDraftRequired',
  'userCorrectionAllowedBeforeApproval',
  'explicitUserApprovalRequiredBeforeWorkspaceImport',
  'approvedLatexDraftRequired',
  'workspaceImportPreparedOnlyAfterUserApproval',
  'workspaceImportEnvelopeMustPreserveReviewMetadata',
  'workspaceImportEnvelopeMustPreserveEngineMetadata',
  'workspaceImportEnvelopeMustPreserveImageInputMetadata',
  'workspaceMutationRuntimeExecutionBlockedInQ297',
  'directEvaluateBlocked',
  'directSolveGraphSolutionHistoryBlocked',
  'manualSolveGraphAfterImportOnly',
  'editableMathLiveReviewStillRequired',
]) {
  if (q297[key] !== true) fail(`Q297 ${key} must be true`);
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
  'workspaceImportFeatureFlagEnabledByDefault',
  'realWorkspaceImportRuntimeExecuted',
  'realEditableMathLiveReviewOpened',
  'realReviewDraftBoundToMathLive',
  'realUserCorrectionCaptured',
  'realUserApprovalCaptured',
  'realImageToLatexInferenceExecuted',
  'nativeRuntimeStartupExecuted',
  'nativeRuntimeHandlerImplemented',
  'methodChannelRuntimeBindingAdded',
  'jniBindingAdded',
  'paddleRuntimeAdded',
  'paddleOcrDependencyAdded',
  'runtimeDependencyAddedToPubspec',
  'gradleNativeRuntimeDependencyAdded',
  'realPrivateArtifactFileLoaded',
  'cameraImageSentToNativeRuntime',
  'latexCandidateReturnedByRuntime',
  'modelBinaryBundledInBaseApp',
  'productionDownloadEnabled',
  'directWorkspaceImportEnabled',
  'autoEvaluateEnabled',
  'autoSolveGraphSolutionHistoryEnabled',
  'solutionHistoryWriteEnabled',
  'workspaceImportPassClaimed',
  'reviewBindingPassClaimed',
  'imageToLatexPassClaimed',
  'ocrPassClaimed',
  'cameraOcrRuntimePassClaimed',
  'storeReadyPassClaimed',
  'releasePassClaimed',
]) {
  if (q297[key] !== false) fail(`Q297 ${key} must be false`);
}

for (const marker of [
  'q296-editable-mathlive-review-contract-present',
  'q296-real-editable-review-still-pending',
  'accepted-editable-review-draft-required',
  'explicit-user-approval-required-before-workspace-import',
  'approved-latex-draft-required',
  'workspace-import-prepared-only-after-user-approval',
  'workspace-import-envelope-preserves-review-metadata',
  'workspace-import-envelope-preserves-engine-metadata',
  'workspace-import-envelope-preserves-image-input-metadata',
  'workspace-mutation-runtime-execution-blocked-in-q297',
  'direct-evaluate-remains-blocked',
  'direct-solve-graph-solution-history-remain-blocked',
  'manual-solve-graph-after-import-only',
  'no-real-workspace-import-without-user-side-review-approval-evidence',
]) {
  if (!q297.workspaceImportPreconditions.includes(marker)) fail(`Q297 precondition missing: ${marker}`);
}
for (const field of ['workspaceImportRequestId','reviewId','sourceInferenceRequestId','captureId','engineLabel','approvedLatexDraft','userApprovedForWorkspaceImport','workspaceImportPrepared','workspaceImportRuntimeExecuted','workspaceExpressionCandidate','reviewMetadata','engineMetadata','cropMetadata','imageSha256','manualSolveGraphAfterImportOnly','directEvaluateAttempted','directSolveGraphSolutionHistoryAttempted','errorCode']) {
  if (!q297.workspaceImportEnvelopeFields.includes(field)) fail(`Q297 workspace import envelope field missing: ${field}`);
}
for (const code of ['workspaceImportFeatureFlagOff','q296EditableReviewMissing','acceptedEditableReviewDraftMissing','missingExplicitUserApproval','approvedLatexDraftEmpty','approvedLatexDraftTooLong','metadataNotPreserved','workspaceMutationRuntimeExecutionBlockedInQ297','directEvaluateBlocked','solveGraphSolutionHistoryBlocked','noRealWorkspaceImportExecutedInQ297']) {
  if (!q297.workspaceImportErrorCodes.includes(code)) fail(`Q297 error code missing: ${code}`);
}

for (const file of [
  'lib/features/camera/gauss_approved_ocr_workspace_import_real_runtime_policy.dart',
  'lib/features/camera/gauss_approved_ocr_workspace_import_real_runtime.dart',
  'test/v172_q297_approved_ocr_workspace_import_real_runtime_test.dart',
  'tool/verify_approved_ocr_workspace_import_real_runtime_v172_q297.mjs',
  'docs/audit/V172_Q297_APPROVED_OCR_WORKSPACE_IMPORT_REAL_RUNTIME_AUDIT.md',
  'docs/audit/V172_Q297_CHANGED_FILES.md',
]) {
  if (!fs.existsSync(file)) fail(`Q297 file missing: ${file}`);
}

if (!policy.includes(phase) || !policy.includes('realWorkspaceImportRuntimeExecuted = false') || !policy.includes('workspaceImportFeatureFlagEnabledByDefault = false')) fail('Q297 policy markers missing');
if (!gate.includes('approvedWorkspaceImportContractReadyRealImportBlocked') || !gate.includes('noRealWorkspaceImportExecutedInQ297') || !gate.includes('canMutateWorkspaceInQ297 => false')) fail('Q297 gate markers missing');
if (!test.includes('gauss.ppFormulaNetS.approvedOcrWorkspaceImport.defaultOff') || !test.includes('noRealWorkspaceImportExecutedInQ297')) fail('Q297 test markers missing');
if (!audit.includes('Approved OCR Workspace Import Real Runtime') || !audit.includes('Runtime Boundary') || !audit.includes('does not mutate the workspace')) fail('Q297 audit markers missing');
if (!changed.includes('gauss_approved_ocr_workspace_import_real_runtime_policy.dart')) fail('Q297 changed files must disclose new policy');
const modifiedSection = changed.split('## Modified For Successor Awareness Only')[0];
if (modifiedSection.includes('- `android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt`') || modifiedSection.includes('- `android/app/src/main/AndroidManifest.xml`') || modifiedSection.includes('- `assets/mathlive/mathlive_prod_bridge.js`') || modifiedSection.includes('- `lib/features/mathlive/mathlive_production_editor_surface.dart`') || modifiedSection.includes('- `lib/features/camera/gauss_camera_capture_shell.dart`')) fail('Q297 modified section must not list protected runtime files as changed');
if (!readme.includes('V172-Q297')) fail('README must mention Q297');
if (!q296Verifier.includes(phase)) fail('Q296 verifier must be Q297 successor-aware');

for (const forbidden of q297.blockedDependencyFamilies) {
  if (pubspec.includes(forbidden)) fail(`forbidden runtime/download dependency added to pubspec: ${forbidden}`);
}
if (!pubspec.includes('camera: 0.10.6')) fail('camera dependency changed');
if (!pubspec.includes('camera_android: 0.10.9+3')) fail('camera_android dependency changed');
if (pubspec.includes('camera_android_camerax')) fail('camera_android_camerax must not be added in Q297');

const forbiddenModelExtensions = ['.pdmodel', '.pdiparams', '.pdparams', '.onnx', '.tflite', '.mlmodel', '.pt', '.pth', '.bin', '.safetensors', '.so', '.aar'];
for (const file of walk('.')) {
  const normalized = file.replaceAll('\\', '/');
  const base = path.basename(normalized).toLowerCase();
  if (normalized.includes('/.git/') || normalized.includes('/.dart_tool/') || normalized.includes('/build/') || normalized.includes('/.gradle/')) continue;
  if (forbiddenModelExtensions.some((ext) => base.endsWith(ext))) fail(`model/native runtime binary must not be bundled in Q297: ${normalized}`);
  if (base.endsWith('.apk') || base.endsWith('.aab')) fail(`release binary must not be bundled in Q297: ${normalized}`);
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
  status: 'APPROVED_OCR_WORKSPACE_IMPORT_REAL_RUNTIME_STATIC_READY_REAL_WORKSPACE_IMPORT_BLOCKED',
  sourcePhase,
  selectedEngineLabel: q297.selectedEngineLabel,
  workspaceImportFeatureFlag: q297.workspaceImportFeatureFlag,
  workspaceImportReadinessState: q297.workspaceImportReadinessState,
  protectedHashComparison: 'PASS',
  realWorkspaceImportRuntimeExecuted: q297.realWorkspaceImportRuntimeExecuted,
  realEditableMathLiveReviewOpened: q297.realEditableMathLiveReviewOpened,
  realUserApprovalCaptured: q297.realUserApprovalCaptured,
  methodChannelRuntimeBindingAdded: q297.methodChannelRuntimeBindingAdded,
  directWorkspaceImportEnabled: q297.directWorkspaceImportEnabled,
  autoEvaluateEnabled: q297.autoEvaluateEnabled,
  autoSolveGraphSolutionHistoryEnabled: q297.autoSolveGraphSolutionHistoryEnabled,
  workspaceImportPassClaimed: q297.workspaceImportPassClaimed,
  ocrPassClaimed: q297.ocrPassClaimed,
  cameraOcrRuntimePassClaimed: q297.cameraOcrRuntimePassClaimed,
  storeReadyPassClaimed: q297.storeReadyPassClaimed,
  releasePassClaimed: q297.releasePassClaimed,
}, null, 2));

// V172-Q299 successor-awareness marker: V172-Q299-STORE-RELEASE-CANDIDATE-AUDIT
