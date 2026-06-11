import fs from 'fs';

const phase = 'V172-Q373-CONTROLLED-OCR-ACTIVATION-EVIDENCE-CAPTURE-ENTRY';
const q363 = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const manifestPath = 'assets/mathlive/manifest.json';
const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));

function fail(message) {
  console.error(`Q373 VERIFY FAIL: ${message}`);
  process.exit(1);
}

function requireFile(path) {
  if (!fs.existsSync(path)) fail(`missing required file: ${path}`);
}

requireFile('lib/features/camera/gauss_controlled_ocr_activation_evidence_capture_entry_q373_policy.dart');
requireFile('lib/features/camera/gauss_controlled_ocr_activation_evidence_capture_entry_q373.dart');
requireFile('test/v172_q373_controlled_ocr_activation_evidence_capture_entry_test.dart');
requireFile('docs/audit/V172_Q373_CONTROLLED_OCR_ACTIVATION_EVIDENCE_CAPTURE_ENTRY_AUDIT.md');
requireFile('docs/audit/V172_Q373_CHANGED_FILES.md');

if (manifest.cameraOcrLatestPhase !== q363) fail('Q373 must preserve Q363 cameraOcrLatestPhase');
if (manifest.activeProductDevelopmentLatestPhase !== q363) fail('Q373 must preserve Q363 activeProductDevelopmentLatestPhase');
if (manifest.controlledOcrActivationEvidenceCaptureEntryLatestPhase !== phase) fail('missing Q373 latest phase metadata');
const q373 = manifest.v172Q373ControlledOcrActivationEvidenceCaptureEntry;
if (!q373) fail('missing q373 manifest envelope');
if (q373.phase !== phase) fail('wrong q373 phase');
if (q373.activeProductGatePreservedPhase !== q363) fail('q373 must preserve Q363 gate');

for (const key of [
  'entryPrepared',
  'explicitUserInvocationRequired',
  'requiresModelSourcePath',
  'requiresImagePath',
  'requiresQ372FlutterHarness',
  'canRequestPrivateStorageActivation',
  'canRequestModelLoadSmoke',
  'canRequestDummyRuntimeCall',
  'canRequestImageToLatexInference',
  'canRequestReviewHandoff',
  'canRequestApprovedImportEnvelope',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'startupAutoExecutionBlocked',
  'cameraAutoExecutionBlocked',
  'workspaceAutoExecutionBlocked',
  'preservesQ363AsActiveProductPhase',
]) {
  if (q373[key] !== true) fail(`${key} must be true`);
}

for (const key of [
  'workspaceImportExecuted',
  'approvedWorkspaceImportExecuted',
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
]) {
  if (q373[key] !== false) fail(`${key} must be false`);
}

const dart = fs.readFileSync('lib/features/camera/gauss_controlled_ocr_activation_evidence_capture_entry_q373.dart', 'utf8');
for (const required of [
  'GaussControlledOcrActivationEvidenceCaptureEntryQ373Request',
  'toHarnessRequest()',
  'buildEvidenceArguments',
  'captureEvidence',
  'q373DirectOcrToWorkspaceImportBlocked',
  'q373DirectOcrToSolveGraphSolutionHistoryBlocked',
]) {
  if (!dart.includes(required)) fail(`q373 dart missing marker: ${required}`);
}

const forbiddenMainActivityChange = fs.readFileSync('docs/audit/V172_Q373_CHANGED_FILES.md', 'utf8');
if (forbiddenMainActivityChange.includes('MainActivity.kt')) fail('Q373 changed-files doc must not list MainActivity.kt as modified');

console.log('Q373 VERIFY PASS: controlled OCR activation evidence capture entry is explicit-only and protected.');
