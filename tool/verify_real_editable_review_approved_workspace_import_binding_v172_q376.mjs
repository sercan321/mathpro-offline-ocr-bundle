import fs from 'fs';

const phase = 'V172-Q376-REAL-EDITABLE-REVIEW-APPROVED-WORKSPACE-IMPORT-BINDING';
const q363 = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const q375 = 'V172-Q375-REAL-OCR-EXECUTION-OUTPUT-DECODER-CLOSURE';
const manifest = JSON.parse(fs.readFileSync('assets/mathlive/manifest.json', 'utf8'));

function fail(message) {
  console.error(`Q376 VERIFY FAIL: ${message}`);
  process.exit(1);
}

function requireFile(path) {
  if (!fs.existsSync(path)) fail(`missing required file: ${path}`);
}

for (const path of [
  'lib/features/camera/gauss_real_editable_review_approved_workspace_import_binding_q376_policy.dart',
  'lib/features/camera/gauss_real_editable_review_approved_workspace_import_binding_q376.dart',
  'test/v172_q376_real_editable_review_approved_workspace_import_binding_test.dart',
  'docs/audit/V172_Q376_REAL_EDITABLE_REVIEW_APPROVED_WORKSPACE_IMPORT_BINDING_AUDIT.md',
  'docs/audit/V172_Q376_CHANGED_FILES.md',
]) requireFile(path);

if (manifest.cameraOcrLatestPhase !== q363) fail('Q376 must preserve Q363 cameraOcrLatestPhase');
if (manifest.activeProductDevelopmentLatestPhase !== q363) fail('Q376 must preserve Q363 activeProductDevelopmentLatestPhase');
if (manifest.realEditableReviewApprovedWorkspaceImportBindingLatestPhase !== phase) fail('missing Q376 latest phase metadata');
const q376 = manifest.v172Q376RealEditableReviewApprovedWorkspaceImportBinding;
if (!q376) fail('missing q376 manifest envelope');
if (q376.phase !== phase) fail('wrong q376 phase');
if (q376.sourcePhase !== q375) fail('wrong q376 source phase');
if (q376.activeProductGatePreservedPhase !== q363) fail('q376 must preserve active product gate');

for (const key of [
  'realEditableReviewBindingPrepared',
  'approvedWorkspaceImportBindingPrepared',
  'q375DecodedCandidateRequired',
  'requiresQ375DecodedCandidate',
  'candidateLatexMustBeNonEmptyBeforeReview',
  'reviewLatexEditableBeforeImport',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'requiresNonEmptyApprovedLatex',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'mathLiveProductionRoutePreserved',
  'workspaceUiPreserved',
]) if (q376[key] !== true) fail(`${key} must be true`);

for (const key of [
  'workspaceImportAutoExecuted',
  'approvedWorkspaceImportExecutedByPackage',
  'workspaceImportExecuted',
  'solveGraphSolutionHistoryTouched',
  'ocrPassClaimed',
  'androidPassClaimed',
  'storeReadyPassClaimed',
  'releaseReadyPassClaimed',
  'mainActivityChanged',
  'pubspecChanged',
  'gradleChanged',
  'androidManifestChanged',
  'keyboardChanged',
  'moreTemplateTrayChanged',
  'longPressChanged',
  'mathLiveProductionBridgeChanged',
  'workspaceChanged',
  'graphChanged',
  'solutionChanged',
  'historyChanged',
  'splashChanged',
  'iconChanged',
]) if (q376[key] !== false) fail(`${key} must be false`);

const dart = fs.readFileSync('lib/features/camera/gauss_real_editable_review_approved_workspace_import_binding_q376.dart', 'utf8');
for (const marker of [
  'prepareReviewDraft',
  'buildApprovedWorkspaceImportCommand',
  'explicit-user-approval-missing',
  'autoSolveBlocked',
  'autoGraphBlocked',
  'autoSolutionHistoryBlocked',
  'workspaceImportExecutedByPackage',
]) if (!dart.includes(marker)) fail(`Q376 Dart missing marker: ${marker}`);

const mainActivity = fs.readFileSync('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt', 'utf8');
if (mainActivity.includes('q376Phase') || mainActivity.includes('realEditableReviewApprovedWorkspaceImportBinding')) {
  fail('Q376 must not mutate MainActivity or add native bridge markers');
}

const changed = fs.readFileSync('docs/audit/V172_Q376_CHANGED_FILES.md', 'utf8');
for (const marker of [
  'gauss_real_editable_review_approved_workspace_import_binding_q376.dart',
  'verify_real_editable_review_approved_workspace_import_binding_v172_q376.mjs',
  'Protected Runtime/UI Files Not Modified',
]) if (!changed.includes(marker)) fail(`Q376 changed-files missing marker: ${marker}`);

console.log('Q376 VERIFY PASS: editable review and approved workspace import binding is review-first, explicit-approval-only, and protected.');
