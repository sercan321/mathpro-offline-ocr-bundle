import fs from 'fs';

const phase = 'V172-Q377-CAMERA-OCR-END-TO-END-FINAL-DEVICE-CLOSURE';
const q363 = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const q376 = 'V172-Q376-REAL-EDITABLE-REVIEW-APPROVED-WORKSPACE-IMPORT-BINDING';
const manifest = JSON.parse(fs.readFileSync('assets/mathlive/manifest.json', 'utf8'));

function fail(message) {
  console.error(`Q377 VERIFY FAIL: ${message}`);
  process.exit(1);
}

function requireFile(path) {
  if (!fs.existsSync(path)) fail(`missing required file: ${path}`);
}

for (const path of [
  'lib/features/camera/gauss_camera_ocr_end_to_end_final_device_closure_q377_policy.dart',
  'lib/features/camera/gauss_camera_ocr_end_to_end_final_device_closure_q377.dart',
  'test/v172_q377_camera_ocr_end_to_end_final_device_closure_test.dart',
  'docs/audit/V172_Q377_CAMERA_OCR_END_TO_END_FINAL_DEVICE_CLOSURE_AUDIT.md',
  'docs/audit/V172_Q377_CHANGED_FILES.md',
]) requireFile(path);

if (manifest.cameraOcrLatestPhase !== q363) fail('Q377 must preserve Q363 cameraOcrLatestPhase');
if (manifest.activeProductDevelopmentLatestPhase !== q363) fail('Q377 must preserve Q363 activeProductDevelopmentLatestPhase');
if (manifest.cameraOcrEndToEndFinalDeviceClosureLatestPhase !== phase) fail('missing Q377 latest phase metadata');
const q377 = manifest.v172Q377CameraOcrEndToEndFinalDeviceClosure;
if (!q377) fail('missing q377 manifest envelope');
if (q377.phase !== phase) fail('wrong q377 phase');
if (q377.sourcePhase !== q376) fail('wrong q377 source phase');
if (q377.activeProductGatePreservedPhase !== q363) fail('q377 must preserve active product gate');

for (const key of [
  'finalClosureContractPrepared',
  'requiresFinalUserSideEvidence',
  'requiresFlutterAnalyzePass',
  'requiresFlutterTestPass',
  'requiresFlutterRunPass',
  'requiresPrivateStorageEvidence',
  'requiresModelLoadSmokeEvidence',
  'requiresDummyRuntimeCallEvidence',
  'requiresImageToLatexEvidence',
  'requiresEditableMathLiveReviewEvidence',
  'requiresApprovedWorkspaceImportEvidence',
  'directOcrToWorkspaceBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'keyboardProtected',
  'mathLiveProductionRouteProtected',
  'workspaceUiProtected',
]) if (q377[key] !== true) fail(`${key} must be true`);

for (const key of [
  'workspaceImportAutoExecuted',
  'solveGraphSolutionHistoryTouched',
  'ocrPassClaimedByPackage',
  'androidPassClaimedByPackage',
  'storeReadyPassClaimedByPackage',
  'releaseReadyPassClaimedByPackage',
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
]) if (q377[key] !== false) fail(`${key} must be false`);

const dart = fs.readFileSync('lib/features/camera/gauss_camera_ocr_end_to_end_final_device_closure_q377.dart', 'utf8');
for (const marker of [
  'GaussCameraOcrEndToEndEvidenceQ377',
  'cameraOcrEndToEndEvidenceComplete',
  'q364-private-storage-evidence-missing',
  'q367-image-to-latex-candidate-evidence-missing',
  'direct-ocr-to-workspace-block-broken',
  'ocrPassClaimedByPackage: false',
]) if (!dart.includes(marker)) fail(`Q377 Dart missing marker: ${marker}`);

const changed = fs.readFileSync('docs/audit/V172_Q377_CHANGED_FILES.md', 'utf8');
for (const marker of [
  'gauss_camera_ocr_end_to_end_final_device_closure_q377.dart',
  'verify_camera_ocr_end_to_end_final_device_closure_v172_q377.mjs',
  'Protected Runtime/UI Files Not Modified',
]) if (!changed.includes(marker)) fail(`Q377 changed-files missing marker: ${marker}`);

const mainActivity = fs.readFileSync('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt', 'utf8');
if (mainActivity.includes('cameraOcrEndToEndFinalDeviceClosure') || mainActivity.includes('q377Phase')) {
  fail('Q377 must not mutate MainActivity or add native bridge markers');
}

console.log('Q377 VERIFY PASS: camera OCR end-to-end final device closure requires real evidence and preserves protected surfaces.');
