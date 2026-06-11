import fs from 'fs';

const phase = 'V172-Q375-REAL-OCR-EXECUTION-OUTPUT-DECODER-CLOSURE';
const q363 = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const q374 = 'V172-Q374-CONTROLLED-OCR-ACTIVATION-EVIDENCE-READINESS-AGGREGATOR';
const manifest = JSON.parse(fs.readFileSync('assets/mathlive/manifest.json', 'utf8'));

function fail(message) {
  console.error(`Q375 VERIFY FAIL: ${message}`);
  process.exit(1);
}

function requireFile(path) {
  if (!fs.existsSync(path)) fail(`missing required file: ${path}`);
}

for (const path of [
  'lib/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375_policy.dart',
  'lib/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375.dart',
  'test/v172_q375_real_ocr_execution_output_decoder_closure_test.dart',
  'docs/audit/V172_Q375_REAL_OCR_EXECUTION_OUTPUT_DECODER_CLOSURE_AUDIT.md',
  'docs/audit/V172_Q375_CHANGED_FILES.md',
]) requireFile(path);

if (manifest.cameraOcrLatestPhase !== q363) fail('Q375 must preserve Q363 cameraOcrLatestPhase');
if (manifest.activeProductDevelopmentLatestPhase !== q363) fail('Q375 must preserve Q363 activeProductDevelopmentLatestPhase');
if (manifest.realOcrExecutionOutputDecoderClosureLatestPhase !== phase) fail('missing Q375 latest phase metadata');
const q375 = manifest.v172Q375RealOcrExecutionOutputDecoderClosure;
if (!q375) fail('missing q375 manifest envelope');
if (q375.phase !== phase) fail('wrong q375 phase');
if (q375.sourcePhase !== q374) fail('wrong q375 source phase');
if (q375.activeProductGatePreservedPhase !== q363) fail('q375 must preserve active product gate');

for (const key of [
  'realOcrExecutionOutputDecoderClosurePrepared',
  'q367OutputDecoderClosureExtended',
  'outputDecoderImplemented',
  'outputDecoderDoesNotInventLatex',
  'decoderRequiresReadableModelOutputOrExplicitOverride',
  'candidateLatexMustBeNonEmptyBeforeReview',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'startupAutoExecutionBlocked',
  'cameraAutoExecutionBlocked',
  'workspaceAutoExecutionBlocked',
  'mainActivityChanged',
]) if (q375[key] !== true) fail(`${key} must be true`);

for (const key of [
  'workspaceImportExecuted',
  'approvedWorkspaceImportExecuted',
  'solveGraphSolutionHistoryTouched',
  'ocrPassClaimed',
  'imageToLatexPassClaimedByPackage',
  'androidPassClaimed',
  'storeReadyPassClaimed',
  'releaseReadyPassClaimed',
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
]) if (q375[key] !== false) fail(`${key} must be false`);

const mainActivity = fs.readFileSync('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt', 'utf8');
for (const marker of [
  'q375Phase',
  'realOcrExecutionOutputDecoderClosure',
  'q375RealOcrExecutionOutputDecoderClosure',
  'outputDecoderDoesNotInventLatex',
  'decoder-vocabulary-not-available-or-empty-model-output',
  'requiresEditableMathLiveReviewBeforeImport',
]) if (!mainActivity.includes(marker)) fail(`MainActivity missing Q375 marker: ${marker}`);

const dart = fs.readFileSync('lib/features/camera/gauss_real_ocr_execution_output_decoder_closure_q375.dart', 'utf8');
for (const marker of [
  'decodeEvidence',
  'candidateLatexDecoded',
  'outputDecoderDoesNotInventLatex',
  'decoderRequiresReadableModelOutputOrExplicitOverride',
  'directOcrToWorkspaceImportBlocked',
]) if (!dart.includes(marker)) fail(`Q375 Dart missing marker: ${marker}`);

const changed = fs.readFileSync('docs/audit/V172_Q375_CHANGED_FILES.md', 'utf8');
if (!changed.includes('MainActivity.kt')) fail('Q375 changed-files must disclose intentional MainActivity change');
const modifiedSection = changed.split('## Protected Runtime/UI Files Not Modified')[0];
for (const forbidden of ['android/app/build.gradle', 'pubspec.yaml', 'AndroidManifest.xml', 'workspace_panel.dart', 'math_keyboard.dart', 'graph_card.dart']) {
  if (modifiedSection.includes(forbidden)) fail(`Q375 modified section must not list protected file: ${forbidden}`);
}

console.log('Q375 VERIFY PASS: real OCR output decoder closure is explicit-only, review-first, and protected.');
