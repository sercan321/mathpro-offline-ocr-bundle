import fs from 'fs';

const phase = 'V172-Q381-CAMERA-OCR-RUNTIME-FINALIZATION-CROP-MODEL-VOCAB-REVIEW-COMPLETION';
const q363 = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const manifest = JSON.parse(fs.readFileSync('assets/mathlive/manifest.json', 'utf8'));

function fail(message) {
  console.error(`Q381 VERIFY FAIL: ${message}`);
  process.exit(1);
}
function read(path) {
  if (!fs.existsSync(path)) fail(`missing file: ${path}`);
  return fs.readFileSync(path, 'utf8');
}

for (const path of [
  'lib/features/camera/gauss_camera_ocr_runtime_finalization_q381_policy.dart',
  'lib/features/camera/gauss_camera_ocr_runtime_finalization_q381.dart',
  'test/v172_q381_camera_ocr_runtime_finalization_test.dart',
  'docs/audit/V172_Q381_CAMERA_OCR_RUNTIME_FINALIZATION_AUDIT.md',
  'docs/audit/V172_Q381_CHANGED_FILES.md',
]) read(path);

if (manifest.cameraOcrLatestPhase !== q363) fail('Q381 must preserve Q363 cameraOcrLatestPhase');
if (manifest.activeProductDevelopmentLatestPhase !== q363) fail('Q381 must preserve Q363 activeProductDevelopmentLatestPhase');
if (manifest.cameraOcrRuntimeFinalizationCropModelVocabReviewCompletionLatestPhase !== phase) fail('missing Q381 latest phase metadata');
const q381 = manifest.v172Q381CameraOcrRuntimeFinalizationCropModelVocabReviewCompletion;
if (!q381 || q381.phase !== phase) fail('missing/wrong Q381 manifest envelope');
for (const key of [
  'q378CameraFlowUsesQ381Bridge',
  'cropFrameProducesRealOcrInputImage',
  'rotationAppliedBeforeOcrInput',
  'privateModelPreflightBeforeInference',
  'vocabularySidecarProvisionSupported',
  'adaptiveInputDecoderPreserved',
  'fakeLatexGenerationBlocked',
  'userFriendlyBlockedReasonProvided',
  'editableReviewRequiredBeforeImport',
  'explicitUserApprovalRequiredBeforeImport',
  'directOcrToWorkspaceImportBlockedBeforeReview',
  'solveGraphSolutionHistoryAutoTriggerBlocked',
]) if (q381[key] !== true) fail(`${key} must be true`);
if (q381.onnxModelBundledInZip !== false) fail('Q381 must not bundle ONNX model');
if (q381.ocrPassClaimedByPackage !== false) fail('Q381 must not claim OCR PASS');

const camera = read('lib/features/camera/gauss_camera_capture_shell.dart');
for (const marker of [
  'rotationQuarterTurns: _cropRotationQuarterTurns',
  "modelSourcePath: _mathOcrModelSnapshot.installPath ?? ''",
  "userFacingMessage",
]) if (!camera.includes(marker)) fail(`camera shell missing marker: ${marker}`);

const binding = read('lib/features/camera/gauss_real_camera_ocr_user_flow_binding_q378.dart');
for (const marker of [
  'GaussCameraOcrRuntimeFinalizationQ381Policy.bridgeMethod',
  "'rotationQuarterTurns': rotationQuarterTurns",
  "'cropFrameWidthFactor': GaussCameraOcrRuntimeFinalizationQ381Policy.normalizedCropFrameWidth",
  "'modelSourcePath': modelSourcePath.trim().isEmpty ? null : modelSourcePath.trim()",
]) if (!binding.includes(marker)) fail(`Q378 binding missing Q381 marker: ${marker}`);

const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const marker of [
  'cameraOcrRuntimeFinalizationCropModelVocabReviewCompletion',
  'q381CameraOcrRuntimeFinalizationCropModelVocabReviewCompletion',
  'q381PrepareCroppedOcrInputImage',
  'q381ActivateVocabularySidecarsFromSource',
  'q381UserFacingOcrMessage',
  'q381CropAndRotationApplied',
  'modelVocabularySidecarEvidence',
  'ocr_crops/q381',
  'Bitmap.createBitmap(rotated, left, top, cropWidth, cropHeight)',
  'q380OcrRuntimeReadinessAdaptiveInputDecoderCompletion',
]) if (!main.includes(marker)) fail(`MainActivity missing Q381 marker: ${marker}`);
if (main.includes('method: String,\n        method: String')) fail('MainActivity still contains duplicate q380 method parameter syntax regression');

for (const forbidden of [
  'android/app/src/main/res/raw/pp_formulanet_s.onnx',
  'assets/pp_formulanet_s.onnx',
  'assets/models/pp_formulanet_s.onnx',
]) if (fs.existsSync(forbidden)) fail(`forbidden bundled ONNX model artifact found: ${forbidden}`);

console.log('Q381 VERIFY PASS: camera OCR runtime finalization adds crop/rotation/model/vocab preflight without fake OCR/import/solve claims.');
