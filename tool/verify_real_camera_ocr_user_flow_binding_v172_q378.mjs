import fs from 'fs';

const phase = 'V172-Q378-REAL-CAMERA-OCR-USER-FLOW-BINDING';
const q363 = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const manifest = JSON.parse(fs.readFileSync('assets/mathlive/manifest.json', 'utf8'));

function fail(message) {
  console.error(`Q378 VERIFY FAIL: ${message}`);
  process.exit(1);
}
function requireFile(path) {
  if (!fs.existsSync(path)) fail(`missing required file: ${path}`);
  return fs.readFileSync(path, 'utf8');
}

for (const path of [
  'lib/features/camera/gauss_real_camera_ocr_user_flow_binding_q378_policy.dart',
  'lib/features/camera/gauss_real_camera_ocr_user_flow_binding_q378.dart',
  'test/v172_q378_real_camera_ocr_user_flow_binding_test.dart',
  'docs/audit/V172_Q378_REAL_CAMERA_OCR_USER_FLOW_BINDING_AUDIT.md',
  'docs/audit/V172_Q378_CHANGED_FILES.md',
]) requireFile(path);

if (manifest.cameraOcrLatestPhase !== q363) fail('Q378 must preserve Q363 cameraOcrLatestPhase');
if (manifest.activeProductDevelopmentLatestPhase !== q363) fail('Q378 must preserve Q363 activeProductDevelopmentLatestPhase');
if (manifest.realCameraOcrUserFlowBindingLatestPhase !== phase) fail('missing q378 latest phase');
const q378 = manifest.v172Q378RealCameraOcrUserFlowBinding;
if (!q378 || q378.phase !== phase) fail('missing/wrong q378 manifest envelope');
for (const key of [
  'cameraCropAcceptInvokesOcrHarness',
  'editableReviewReceivesDecodedCandidate',
  'approvedReviewImportsToWorkspace',
  'mathLiveControllerSyncRequestedAfterApproval',
  'workspaceStateSyncRequestedAfterApproval',
  'directOcrToWorkspaceImportBlockedBeforeReview',
  'solveGraphSolutionHistoryAutoTriggerBlocked',
]) if (q378[key] !== true) fail(`${key} must be true`);
if (q378.ocrPassClaimedByPackage !== false) fail('q378 must not claim OCR PASS');

const camera = requireFile('lib/features/camera/gauss_camera_capture_shell.dart');
for (const marker of [
  'GaussRealCameraOcrUserFlowBindingQ378.captureAndPrepareReview',
  'GaussMathLiveOcrReviewDraft.fromQ378Evidence',
  'onApprovedLatexImport: widget.onApprovedLatexImport',
  '_ocrUserFlowRunning',
]) if (!camera.includes(marker)) fail(`camera shell missing marker: ${marker}`);
if (camera.includes('OCR sonraki fazda')) fail('camera copy must not say OCR is a later phase');

const review = requireFile('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
for (const marker of [
  'TextEditingController',
  'GaussRealCameraOcrUserFlowBindingQ378.prepareApprovedImport',
  'Workspace’e aktar',
  'onApprovedLatexImport',
  'GaussMathLiveOcrReviewDraft.fromQ378Evidence',
]) if (!review.includes(marker)) fail(`review surface missing marker: ${marker}`);

const workspace = requireFile('lib/features/workspace/workspace_panel.dart');
for (const marker of [
  'onApprovedOcrWorkspaceImport',
  'onApprovedLatexImport: onApprovedOcrWorkspaceImport',
]) if (!workspace.includes(marker)) fail(`workspace panel missing marker: ${marker}`);

const appShell = requireFile('lib/app/app_shell.dart');
for (const marker of [
  '_handleApprovedOcrWorkspaceImport',
  'q378-approved-ocr-workspace-import',
  'setLatexFromApprovedOcrImport',
]) if (!appShell.includes(marker)) fail(`app shell missing marker: ${marker}`);
if (appShell.includes("_calculator.handleKey('↵');\n    _recordEvaluationIfNeeded();\n  }\n\n  Future<void> _handleApprovedOcrWorkspaceImport")) {
  fail('approved OCR import must not be implemented by auto-evaluate path');
}

const mathlive = requireFile('lib/features/mathlive/mathlive_main_editor_surface.dart');
if (!mathlive.includes('setLatexFromApprovedOcrImport')) fail('MathLive controller missing approved OCR import sync method');

const mainActivity = requireFile('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
if (mainActivity.includes('q378Phase') || mainActivity.includes('REAL_CAMERA_OCR_USER_FLOW_BINDING')) {
  fail('Q378 must not add native MainActivity markers; existing native bridges are reused');
}

console.log('Q378 VERIFY PASS: real camera OCR user flow is bound to review-first approved workspace import without auto solve/graph/history.');
