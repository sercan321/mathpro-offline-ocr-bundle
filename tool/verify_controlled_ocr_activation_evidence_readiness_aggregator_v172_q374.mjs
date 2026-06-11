import fs from 'fs';

const phase = 'V172-Q374-CONTROLLED-OCR-ACTIVATION-EVIDENCE-READINESS-AGGREGATOR';
const q363 = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const q373 = 'V172-Q373-CONTROLLED-OCR-ACTIVATION-EVIDENCE-CAPTURE-ENTRY';
const manifestPath = 'assets/mathlive/manifest.json';
const manifest = JSON.parse(fs.readFileSync(manifestPath, 'utf8'));

function fail(message) {
  console.error(`Q374 VERIFY FAIL: ${message}`);
  process.exit(1);
}

function requireFile(path) {
  if (!fs.existsSync(path)) fail(`missing required file: ${path}`);
}

requireFile('lib/features/camera/gauss_controlled_ocr_activation_evidence_readiness_aggregator_q374_policy.dart');
requireFile('lib/features/camera/gauss_controlled_ocr_activation_evidence_readiness_aggregator_q374.dart');
requireFile('test/v172_q374_controlled_ocr_activation_evidence_readiness_aggregator_test.dart');
requireFile('docs/audit/V172_Q374_CONTROLLED_OCR_ACTIVATION_EVIDENCE_READINESS_AGGREGATOR_AUDIT.md');
requireFile('docs/audit/V172_Q374_CHANGED_FILES.md');

if (manifest.cameraOcrLatestPhase !== q363) fail('Q374 must preserve Q363 cameraOcrLatestPhase');
if (manifest.activeProductDevelopmentLatestPhase !== q363) fail('Q374 must preserve Q363 activeProductDevelopmentLatestPhase');
if (manifest.controlledOcrActivationEvidenceReadinessAggregatorLatestPhase !== phase) fail('missing Q374 latest phase metadata');
const q374 = manifest.v172Q374ControlledOcrActivationEvidenceReadinessAggregator;
if (!q374) fail('missing q374 manifest envelope');
if (q374.phase !== phase) fail('wrong q374 phase');
if (q374.sourcePhase !== q373) fail('wrong q374 source phase');
if (q374.activeProductGatePreservedPhase !== q363) fail('q374 must preserve Q363 gate');

for (const key of [
  'aggregatorPrepared',
  'requiresQ373EvidenceCaptureEntry',
  'classifiesPrivateStorageReadiness',
  'classifiesModelLoadReadiness',
  'classifiesDummyRuntimeCallReadiness',
  'classifiesImageToLatexReadiness',
  'classifiesEditableMathLiveReviewReadiness',
  'classifiesApprovedWorkspaceImportReadiness',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'startupAutoExecutionBlocked',
  'cameraAutoExecutionBlocked',
  'workspaceAutoExecutionBlocked',
  'preservesQ363AsActiveProductPhase',
]) {
  if (q374[key] !== true) fail(`${key} must be true`);
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
  if (q374[key] !== false) fail(`${key} must be false`);
}

const dart = fs.readFileSync('lib/features/camera/gauss_controlled_ocr_activation_evidence_readiness_aggregator_q374.dart', 'utf8');
for (const marker of [
  'classifyEvidence',
  'captureAndClassify',
  'private-storage-not-ready',
  'model-load-not-ready',
  'image-to-latex-candidate-not-ready',
  'cameraOcrUsableFlowReady',
  'directOcrToWorkspaceImportBlocked',
]) {
  if (!dart.includes(marker)) fail(`q374 dart missing marker: ${marker}`);
}

const changed = fs.readFileSync('docs/audit/V172_Q374_CHANGED_FILES.md', 'utf8');
const modifiedSection = changed.split('## Protected Runtime/UI Files Not Modified')[0];
for (const forbidden of ['MainActivity.kt', 'android/app/build.gradle', 'pubspec.yaml', 'AndroidManifest.xml', 'workspace_panel.dart']) {
  if (modifiedSection.includes(forbidden)) fail(`Q374 modified section must not list protected file: ${forbidden}`);
}

console.log('Q374 VERIFY PASS: controlled OCR evidence readiness aggregator is explicit-only and protected.');
