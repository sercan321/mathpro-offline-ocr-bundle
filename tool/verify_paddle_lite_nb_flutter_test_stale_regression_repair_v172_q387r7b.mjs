#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
const root = process.cwd();
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function check(condition, message) {
  if (!condition) {
    console.error(`Q387R7B VERIFY FAIL: ${message}`);
    process.exit(1);
  }
}
const policy = read('lib/features/camera/gauss_paddle_lite_nb_flutter_test_stale_regression_repair_q387r7b.dart');
const test = read('test/v172_q387r7b_paddle_lite_nb_flutter_test_stale_regression_repair_test.dart');
const manager = read('lib/features/camera/gauss_deferred_math_ocr_model_manager.dart');
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const q387r4Test = read('test/v172_q387r4_paddle_lite_nb_production_source_binding_test.dart');
const q387Test = read('test/v172_q387_paddle_lite_nb_model_format_decision_gate_test.dart');
const manifest = read('assets/mathlive/manifest.json');
check(policy.includes('V172-Q387R7B-FLUTTER-TEST-STALE-REGRESSION-REPAIR'), 'Q387R7B policy phase missing');
check(policy.includes('q380PrivateStorageEvidenceCompatibilityAliasRestored = true'), 'Q380 compatibility alias repair policy missing');
check(policy.includes('q385R4QueuedCopyLegacySubstringRestored = true'), 'Q385R4 queued copy repair policy missing');
check(policy.includes('q387ManifestGatePreserved = true'), 'Q387 manifest gate preservation policy missing');
check(test.includes('Model doğrulanmadan OCR çalıştırılmayacak'), 'Q387R7B test must lock the legacy queued-copy substring');
check(test.includes('privateStorageActivationEvidence'), 'Q387R7B test must lock privateStorageActivationEvidence marker');
check(manager.includes('Model doğrulanmadan OCR çalıştırılmayacak'), 'model manager queued copy still misses exact legacy substring expected by Q239D/Q385R4 tests');
check(!manager.includes('Doğrulama tamamlanmadan OCR çalıştırılmayacak'), 'model manager still uses stale queued copy that misses legacy substring');
check(mainActivity.includes('"privateStorageActivationEvidence" to modelBindingEvidence'), 'MainActivity must expose privateStorageActivationEvidence compatibility alias');
check(mainActivity.includes('"modelBindingEvidence" to modelBindingEvidence'), 'MainActivity must preserve modelBindingEvidence');
check(q387r4Test.includes('input: const GaussQ387R4PaddleLiteNbProductionSourceBindingInput(\n          acquisitionEvidence: placeholder,'), 'Q387R4 analyzer info repair missing const constructor');
check(q387r4Test.includes('const placeholder = GaussQ387R3PaddleLiteNbAcquisitionEvidence('), 'Q387R4 placeholder fixture must remain const');
check(q387Test.includes('q387R1NbArtifactReady && supportsSetModelFromFile'), 'Q387 stale test expectation must preserve Q387R1 manifest gate');
check(manifest.includes('v172Q387R7BFlutterTestStaleRegressionRepair'), 'manifest missing Q387R7B repair entry');
for (const rel of [
  'lib/features/camera/gauss_paddle_lite_nb_flutter_test_stale_regression_repair_q387r7b.dart',
  'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
  'test/v172_q387r7b_paddle_lite_nb_flutter_test_stale_regression_repair_test.dart',
]) {
  const text = read(rel);
  check(!text.includes('ocrPassClaimed = true'), `${rel} must not claim OCR PASS`);
  check(!text.includes('androidRealDevicePassClaimed = true'), `${rel} must not claim Android real-device PASS`);
  check(!text.includes('productionInferencePassClaimedByQ387R7B = true'), `${rel} must not claim production inference PASS`);
}
console.log('PASS verify_paddle_lite_nb_flutter_test_stale_regression_repair_v172_q387r7b');
