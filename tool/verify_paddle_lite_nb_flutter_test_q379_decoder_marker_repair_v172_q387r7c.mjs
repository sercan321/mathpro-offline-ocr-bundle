#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
const root = process.cwd();
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function check(condition, message) {
  if (!condition) {
    console.error(`Q387R7C VERIFY FAIL: ${message}`);
    process.exit(1);
  }
}
const policy = read('lib/features/camera/gauss_paddle_lite_nb_flutter_test_stale_regression_repair_q387r7c.dart');
const test = read('test/v172_q387r7c_paddle_lite_nb_flutter_test_q379_decoder_marker_repair_test.dart');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const manifest = read('assets/mathlive/manifest.json');
check(policy.includes('V172-Q387R7C-FLUTTER-TEST-Q379-DECODER-MARKER-REPAIR'), 'Q387R7C policy phase missing');
check(policy.includes('q379DecodedCandidateLatexMarkerRestored = true'), 'decodedCandidateLatex repair policy missing');
check(policy.includes('q379OutputDecoderImplementedMarkerRestored = true'), 'outputDecoderImplemented repair policy missing');
check(policy.includes('productionInferencePassClaimedByQ387R7C = false'), 'Q387R7C must not claim production inference PASS');
check(policy.includes('androidRealDevicePassClaimedByQ387R7C = false'), 'Q387R7C must not claim Android real-device PASS');
check(test.includes('"candidateLatex" to decodedCandidateLatex'), 'Q387R7C test must lock candidateLatex marker');
check(test.includes('"outputDecodingImplemented" to outputDecoderImplemented'), 'Q387R7C test must lock output decoder marker');
check(mainActivity.includes('val decodedCandidateLatex = candidateLatex'), 'MainActivity missing decodedCandidateLatex alias');
check(mainActivity.includes('val outputDecoderImplemented = true'), 'MainActivity missing outputDecoderImplemented alias');
check(mainActivity.includes('"candidateLatex" to decodedCandidateLatex'), 'MainActivity missing candidateLatex decodedCandidateLatex binding');
check(mainActivity.includes('"outputDecodingImplemented" to outputDecoderImplemented'), 'MainActivity missing outputDecoderImplemented binding');
check(mainActivity.includes('"decoderDoesNotInventLatex" to true'), 'MainActivity must preserve no-invent decoder invariant');
check(manifest.includes('v172Q387R7CFlutterTestQ379DecoderMarkerRepair'), 'manifest missing Q387R7C repair entry');
for (const rel of [
  'lib/features/camera/gauss_paddle_lite_nb_flutter_test_stale_regression_repair_q387r7c.dart',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'test/v172_q387r7c_paddle_lite_nb_flutter_test_q379_decoder_marker_repair_test.dart',
]) {
  const text = read(rel);
  check(!text.includes('ocrPassClaimed = true'), `${rel} must not claim OCR PASS`);
  check(!text.includes('androidRealDevicePassClaimed = true'), `${rel} must not claim Android real-device PASS`);
  check(!text.includes('productionInferencePassClaimedByQ387R7C = true'), `${rel} must not claim production inference PASS`);
}
console.log('PASS verify_paddle_lite_nb_flutter_test_q379_decoder_marker_repair_v172_q387r7c');
