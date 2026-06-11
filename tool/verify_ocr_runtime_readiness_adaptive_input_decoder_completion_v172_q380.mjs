import fs from 'fs';

const phase = 'V172-Q380-OCR-RUNTIME-READINESS-ADAPTIVE-INPUT-DECODER-COMPLETION';
const q363 = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const manifest = JSON.parse(fs.readFileSync('assets/mathlive/manifest.json', 'utf8'));

function fail(message) {
  console.error(`Q380 VERIFY FAIL: ${message}`);
  process.exit(1);
}
function read(path) {
  if (!fs.existsSync(path)) fail(`missing file: ${path}`);
  return fs.readFileSync(path, 'utf8');
}

for (const path of [
  'lib/features/camera/gauss_ocr_runtime_readiness_adaptive_input_decoder_completion_q380_policy.dart',
  'lib/features/camera/gauss_ocr_runtime_readiness_adaptive_input_decoder_completion_q380.dart',
  'test/v172_q380_ocr_runtime_readiness_adaptive_input_decoder_completion_test.dart',
  'docs/audit/V172_Q380_OCR_RUNTIME_READINESS_ADAPTIVE_INPUT_DECODER_COMPLETION_AUDIT.md',
  'docs/audit/V172_Q380_CHANGED_FILES.md',
]) read(path);

if (manifest.cameraOcrLatestPhase !== q363) fail('Q380 must preserve Q363 cameraOcrLatestPhase');
if (manifest.activeProductDevelopmentLatestPhase !== q363) fail('Q380 must preserve Q363 activeProductDevelopmentLatestPhase');
if (manifest.ocrRuntimeReadinessAdaptiveInputDecoderCompletionLatestPhase !== phase) fail('missing Q380 latest phase metadata');
const q380 = manifest.v172Q380OcrRuntimeReadinessAdaptiveInputDecoderCompletion;
if (!q380 || q380.phase !== phase) fail('missing/wrong Q380 manifest envelope');
for (const key of [
  'q378CameraFlowUsesQ380Bridge',
  'privateStoragePreflightBeforeInference',
  'explicitModelSourcePathCanActivatePrivateStorage',
  'adaptiveOnnxInputMetadataShapeEnabled',
  'nchwNhwcChwImageTensorLayoutsSupported',
  'floatLogitVocabularyArgmaxDecoderImplemented',
  'integerTokenVocabularyDecoderPreserved',
  'readableOutputDecoderPreserved',
  'fakeLatexGenerationBlocked',
  'editableMathLiveReviewRequiredBeforeImport',
  'explicitUserApprovalRequiredBeforeImport',
  'directOcrToWorkspaceImportBlockedBeforeReview',
  'solveGraphSolutionHistoryAutoTriggerBlocked',
]) if (q380[key] !== true) fail(`${key} must be true`);
if (q380.onnxModelBundledInZip !== false) fail('Q380 must not bundle ONNX model');
if (q380.ocrPassClaimedByPackage !== false) fail('Q380 must not claim OCR PASS');

const q378Policy = read('lib/features/camera/gauss_real_camera_ocr_user_flow_binding_q378_policy.dart');
if (!q378Policy.includes("decoderBridgeMethod = 'ocrRuntimeReadinessAdaptiveInputDecoderCompletion'")) {
  fail('Q378 camera flow must route to Q380 adaptive decoder bridge');
}

const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const marker of [
  'ocrRuntimeReadinessAdaptiveInputDecoderCompletion',
  'q380OcrRuntimeReadinessAdaptiveInputDecoderCompletion',
  'q380ResolveInputTensorPlan',
  'q380BuildImageTensorValues',
  'q380ExtractShapeFromNodeInfo',
  'q380DecodeLogitOrTokenOutputs',
  'q380DecodeFloatLogitsWithVocabulary',
  'privateStorageActivationEvidence',
  'adaptiveInputLayout',
  'adaptiveTensorShape',
  'decoder-vocabulary-not-available-or-empty-model-output',
  'directOcrToSolveGraphSolutionHistoryBlocked',
]) if (!main.includes(marker)) fail(`MainActivity missing marker: ${marker}`);

for (const forbidden of [
  'android/app/src/main/res/raw/pp_formulanet_s.onnx',
  'assets/pp_formulanet_s.onnx',
  'assets/models/pp_formulanet_s.onnx',
]) if (fs.existsSync(forbidden)) fail(`forbidden bundled ONNX model artifact found: ${forbidden}`);

console.log('Q380 VERIFY PASS: adaptive OCR runtime readiness + decoder completion is wired without fake OCR/import/solve claims.');
