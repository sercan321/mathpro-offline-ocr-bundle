import fs from 'fs';

const phase = 'V172-Q379-REAL-ONNX-OUTPUT-DECODER-CANDIDATE-EXTRACTION-BINDING';
const q363 = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const manifest = JSON.parse(fs.readFileSync('assets/mathlive/manifest.json', 'utf8'));

function fail(message) {
  console.error(`Q379 VERIFY FAIL: ${message}`);
  process.exit(1);
}
function read(path) {
  if (!fs.existsSync(path)) fail(`missing file: ${path}`);
  return fs.readFileSync(path, 'utf8');
}

for (const path of [
  'lib/features/camera/gauss_real_onnx_output_decoder_candidate_extraction_binding_q379_policy.dart',
  'lib/features/camera/gauss_real_onnx_output_decoder_candidate_extraction_binding_q379.dart',
  'test/v172_q379_real_onnx_output_decoder_candidate_extraction_binding_test.dart',
  'docs/audit/V172_Q379_REAL_ONNX_OUTPUT_DECODER_CANDIDATE_EXTRACTION_BINDING_AUDIT.md',
  'docs/audit/V172_Q379_CHANGED_FILES.md',
]) read(path);

if (manifest.cameraOcrLatestPhase !== q363) fail('Q379 must preserve Q363 cameraOcrLatestPhase');
if (manifest.activeProductDevelopmentLatestPhase !== q363) fail('Q379 must preserve Q363 activeProductDevelopmentLatestPhase');
if (manifest.realOnnxOutputDecoderCandidateExtractionBindingLatestPhase !== phase) fail('missing Q379 latest phase');
const q379 = manifest.v172Q379RealOnnxOutputDecoderCandidateExtractionBinding;
if (!q379 || q379.phase !== phase) fail('missing/wrong Q379 manifest envelope');
for (const key of [
  'genericStringOutputDecoderImplemented',
  'asciiCodepointDecoderImplemented',
  'privateVocabularyTokenDecoderImplemented',
  'q367CandidateLatexNoLongerHardcodedEmpty',
  'q367OutputDecodingImplementedTrue',
  'q378CameraFlowCanReceiveDecodedCandidate',
  'editableMathLiveReviewRequiredBeforeImport',
  'explicitUserApprovalRequiredBeforeImport',
  'directOcrToWorkspaceImportBlockedBeforeReview',
  'solveGraphSolutionHistoryAutoTriggerBlocked',
]) if (q379[key] !== true) fail(`${key} must be true`);
if (q379.ocrPassClaimedByPackage !== false) fail('Q379 must not claim OCR PASS');

const main = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
for (const marker of [
  'q379ExtractLatexCandidateFromOrtResult',
  'q379CollectReadableOutput',
  'q379DecodeAsciiLikeIntegers',
  'q379LoadDecoderVocabulary',
  'q379DecodeTokenIdsWithVocabulary',
  'realOnnxOutputDecoderCandidateExtractionBinding',
  '"candidateLatex" to decodedCandidateLatex',
  '"candidateConfidence" to decodedCandidateConfidence',
  '"outputDecodingImplemented" to outputDecoderImplemented',
]) if (!main.includes(marker)) fail(`MainActivity missing marker: ${marker}`);
if (main.includes('"candidateLatex" to "",\n            "candidateConfidence" to 0.0,\n            "candidateAlternatives" to emptyList<String>(),\n            "outputDecodingImplemented" to false')) {
  fail('Q367 must not keep hardcoded empty candidate/outputDecodingImplemented=false block');
}

for (const forbidden of [
  'android/app/src/main/res/raw/pp_formulanet_s.onnx',
  'assets/pp_formulanet_s.onnx',
  'assets/models/pp_formulanet_s.onnx',
]) if (fs.existsSync(forbidden)) fail(`forbidden bundled ONNX model artifact found: ${forbidden}`);

console.log('Q379 VERIFY PASS: ONNX output decoder candidate extraction is bound without fake OCR/import/solve claims.');
