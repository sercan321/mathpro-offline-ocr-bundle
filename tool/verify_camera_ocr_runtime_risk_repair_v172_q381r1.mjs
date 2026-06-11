import fs from 'fs';

const phase = 'V172-Q381R1-CAMERA-OCR-RUNTIME-RISK-REPAIR';
const q381Phase = 'V172-Q381-CAMERA-OCR-RUNTIME-FINALIZATION-CROP-MODEL-VOCAB-REVIEW-COMPLETION';
const manifest = JSON.parse(fs.readFileSync('assets/mathlive/manifest.json', 'utf8'));

function fail(message) {
  console.error(`Q381R1 VERIFY FAIL: ${message}`);
  process.exit(1);
}
function read(path) {
  if (!fs.existsSync(path)) fail(`missing file: ${path}`);
  return fs.readFileSync(path, 'utf8');
}

if (manifest.cameraOcrRuntimeFinalizationCropModelVocabReviewCompletionLatestPhase !== q381Phase) {
  fail('Q381R1 must preserve Q381 latest finalization metadata for compatibility');
}
if (manifest.cameraOcrRuntimeRiskRepairLatestPhase !== phase) fail('missing Q381R1 latest repair metadata');
const repair = manifest.v172Q381R1CameraOcrRuntimeRiskRepair;
if (!repair || repair.phase !== phase) fail('missing/wrong Q381R1 manifest envelope');
for (const key of [
  'nativeOcrBridgeRunsOffMainThread',
  'methodChannelArgumentParsingHardened',
  'cropDecodeUsesBoundedSampleSize',
  'exifOrientationAccountedBeforeCrop',
  'cropEvidenceIncludesPixelMapping',
  'nativeWorkerFailureReturnsBlockedEvidence',
  'q380BitmapRecycleAfterTensorBuild',
  'fakeLatexGenerationBlocked',
  'editableReviewRequiredBeforeImport',
  'explicitUserApprovalRequiredBeforeImport',
  'directOcrToWorkspaceImportBlockedBeforeReview',
  'solveGraphSolutionHistoryAutoTriggerBlocked',
  'keyboardProtected',
  'moreTemplateTrayProtected',
  'longPressProtected',
  'mathLiveProductionAssetsProtected',
  'graphSolutionHistoryProtected',
  'splashIconProtected',
  'solverEvaluatorProtected',
]) if (repair[key] !== true) fail(`${key} must be true`);
if (repair.onnxModelBundledInZip !== false) fail('Q381R1 must not bundle ONNX model');
if (repair.ocrPassClaimedByPackage !== false) fail('Q381R1 must not claim OCR PASS');

const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const marker of [
  'import android.media.ExifInterface',
  'import android.os.Handler',
  'import android.os.Looper',
  'q381R1WorkerThreadName',
  'Thread({',
  'Handler(Looper.getMainLooper()).post { result.success(payload) }',
  'q381StringArgument(arguments, "imagePath", "sourceImagePath")',
  'q381IntArgument(arguments, "rotationQuarterTurns")',
  'q381DoubleArgument(arguments, "cropFrameWidthFactor")',
  'q381FatalBlockedEvidence',
  'q381ComputeDecodeSampleSize',
  'inJustDecodeBounds = true',
  'inSampleSize = sampleSize',
  'q381ReadExifOrientationQuarterTurns',
  'ExifInterface.TAG_ORIENTATION',
  'totalRotationQuarterTurnsApplied',
  'cropCoordinateSpace',
  'q381R1CropPreprocessHardened',
  'decoded.recycle()',
]) if (!main.includes(marker)) fail(`MainActivity missing Q381R1 marker: ${marker}`);
const legacyDecodedRecyclePattern = 'val tensorValues = try {\n                    q380BuildImageTensorValues(decoded, tensorPlan)\n                } finally {\n                    decoded.recycle()\n                }';
const q386DecodedRecyclePattern = 'val tensorValues = try {\n                            q380BuildImageTensorValues(nonNullDecoded, tensorPlan)\n                        } finally {\n                            nonNullDecoded.recycle()';
const q387ResizedRecyclePattern = 'if (resized !== bitmap && !resized.isRecycled) {\n                resized.recycle()';
if (!main.includes(legacyDecodedRecyclePattern) && !(main.includes(q386DecodedRecyclePattern) && main.includes(q387ResizedRecyclePattern))) {
  fail('Q380 cropped image bitmap must be recycled after tensor build');
}

const policy = read('lib/features/camera/gauss_camera_ocr_runtime_finalization_q381_policy.dart');
for (const marker of [
  'latestRepairPhase',
  'nativeOcrBridgeRunsOffMainThread = true',
  'cropDecodeUsesBoundedSampleSize = true',
  'exifOrientationAccountedBeforeCrop = true',
  'cropEvidenceIncludesPixelMapping = true',
  'nativeWorkerFailureReturnsBlockedEvidence = true',
  'q380BitmapRecycleAfterTensorBuild = true',
]) if (!policy.includes(marker)) fail(`Q381 policy missing repair marker: ${marker}`);

const result = read('lib/features/camera/gauss_camera_ocr_runtime_finalization_q381.dart');
for (const marker of [
  'repairPhase',
  'nativeWorkerOffMainThread',
  'exifOrientationAccounted',
  'memorySafeCropDecodeApplied',
  'cropEvidencePixelMappingRecorded',
]) if (!result.includes(marker)) fail(`Q381 result missing repair field: ${marker}`);

const test = read('test/v172_q381_camera_ocr_runtime_finalization_test.dart');
for (const marker of [
  'nativeOcrBridgeRunsOffMainThread',
  'cropDecodeUsesBoundedSampleSize',
  'exifOrientationAccountedBeforeCrop',
  'q380BitmapRecycleAfterTensorBuild',
]) if (!test.includes(marker)) fail(`Q381 test missing repair assertion: ${marker}`);

for (const forbidden of [
  'android/app/src/main/res/raw/pp_formulanet_s.onnx',
  'assets/pp_formulanet_s.onnx',
  'assets/models/pp_formulanet_s.onnx',
]) if (fs.existsSync(forbidden)) fail(`forbidden bundled ONNX model artifact found: ${forbidden}`);

console.log('Q381R1 VERIFY PASS: OCR runtime risk repair hardened native worker, crop/exif/memory evidence, and review-first safety without red-line changes or OCR PASS claim.');
