#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
const root = process.cwd();
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function check(condition, message) {
  if (!condition) {
    console.error(`Q387R7D VERIFY FAIL: ${message}`);
    process.exit(1);
  }
}
const policy = read('lib/features/camera/gauss_paddle_lite_nb_flutter_test_legacy_successor_repair_q387r7d.dart');
const q387r7dTest = read('test/v172_q387r7d_paddle_lite_nb_flutter_test_legacy_successor_repair_test.dart');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const q352 = read('test/v172_q352_onnx_conversion_evidence_acceptance_runtime_strategy_pivot_gate_test.dart');
const q352r1 = read('test/v172_q352r1_legacy_verifier_successor_awareness_hygiene_repair_test.dart');
const manifest = read('assets/mathlive/manifest.json');
check(policy.includes('V172-Q387R7D-FLUTTER-TEST-LEGACY-SUCCESSOR-REPAIR'), 'Q387R7D policy phase missing');
check(policy.includes('legacySetModelFromFileTestsMadeQ387Aware = true'), 'legacy setModelFromFile repair flag missing');
check(policy.includes('legacyOnnxPubspecCommentFalsePositiveRepaired = true'), 'legacy ONNX pubspec repair flag missing');
check(policy.includes('productionInferencePassClaimedByQ387R7D = false'), 'Q387R7D must not claim production inference PASS');
check(policy.includes('androidRealDevicePassClaimedByQ387R7D = false'), 'Q387R7D must not claim Android real-device PASS');
check(policy.includes('fakeLatexCandidateAllowed = false'), 'Q387R7D must not allow fake latex');
check(mainActivity.includes('q387R1NbArtifactReady && supportsSetModelFromFile'), 'MainActivity must keep .nb manifest gate before setModelFromFile');
check(mainActivity.includes('q387-paddle-lite-nb-model-required'), 'MainActivity must keep Q387 .nb blocked reason');
for (const rel of [
  'test/v172_q348_optimized_model_conversion_model_loader_evidence_gate_test.dart',
  'test/v172_q349_real_model_load_smoke_evidence_blocked_test.dart',
  'test/v172_q350_optimized_model_artifact_conversion_evidence_intake_test.dart',
  'test/v172_q351_optimized_model_evidence_acceptance_real_model_load_unlock_gate_test.dart',
  'test/v172_q351r2_flutter_run_kotlin_build_helper_repair_test.dart',
]) {
  const text = read(rel);
  check(text.includes('q387R1NbArtifactReady && supportsSetModelFromFile'), `${rel} must accept only guarded Q387 setModelFromFile successor path`);
  check(text.includes('q387-paddle-lite-nb-model-required'), `${rel} must keep Q387 .nb blocked reason`);
  check(!text.includes("expect(mainActivity, isNot(contains('setModelFromFile')));\n    expect(mainActivity, isNot(contains('loadModel(')))"), `${rel} still has stale strict setModelFromFile expectation block`);
}
for (const [name, text] of [['q352', q352], ['q352r1', q352r1]]) {
  check(text.includes('pubspecRuntimeSection'), `${name} must scope pubspec ONNX checks to runtime section`);
  check(text.includes("!line.trimLeft().startsWith('#')"), `${name} must ignore historical comments`);
  check(!text.includes("expect(pubspec.toLowerCase(), isNot(contains('onnx')));"), `${name} still has stale all-pubspec ONNX string ban`);
  check(text.includes("isNot(contains('onnxruntime'))"), `${name} must still block ONNX runtime dependency`);
  check(text.includes("isNot(contains('onnxruntime-android'))"), `${name} must still block ONNX Runtime Android dependency`);
}
check(q387r7dTest.includes('Q387R7D makes legacy setModelFromFile tests successor-aware'), 'Q387R7D test missing setModelFromFile regression coverage');
check(q387r7dTest.includes('Q387R7D scopes legacy ONNX checks'), 'Q387R7D test missing ONNX pubspec regression coverage');
check(manifest.includes('v172Q387R7DFlutterTestLegacySuccessorRepair'), 'manifest missing Q387R7D repair entry');
for (const rel of [
  'lib/features/camera/gauss_paddle_lite_nb_flutter_test_legacy_successor_repair_q387r7d.dart',
  'test/v172_q387r7d_paddle_lite_nb_flutter_test_legacy_successor_repair_test.dart',
  'assets/mathlive/manifest.json',
]) {
  const text = read(rel);
  check(!text.includes('ocrPassClaimed = true'), `${rel} must not claim OCR PASS`);
  check(!text.includes('androidRealDevicePassClaimed = true'), `${rel} must not claim Android PASS`);
  check(!text.includes('productionInferencePassClaimedByQ387R7D = true'), `${rel} must not claim production inference PASS`);
}
console.log('PASS verify_paddle_lite_nb_flutter_test_legacy_successor_repair_v172_q387r7d');
