import fs from 'node:fs';
function read(path) { return fs.readFileSync(path, 'utf8'); }
function assert(cond, msg) { if (!cond) { console.error('FAIL:', msg); process.exit(1); } }
const overlay = read('lib/features/graph/graph_interaction_overlay.dart');
assert(overlay.includes("'$signπ'") && overlay.includes("'$sign$absNπ'") && overlay.includes("'$absNπ'"), 'pi label interpolation hardening missing');
assert(!overlay.includes("sign + 'π'") && !overlay.includes("absN.toString() + 'π'") && !overlay.includes("'${absN}π'"), 'old pi string concatenation or stale brace interpolation still present');
const pubspec = read('pubspec.yaml');
assert(pubspec.includes('version: 0.172.112+172'), 'pubspec version not aligned with MathProPackageContract');
assert(!pubspec.toLowerCase().includes('onnx'), 'pubspec must not contain stale OCR runtime wording scanned by Q276/Q277.');
assert(!/^\s*onnxruntime\s*:/m.test(pubspec.toLowerCase()), 'pubspec must not add onnxruntime dependency');
assert(pubspec.includes('http: ^1.2.2'), 'intentional deferred model download http dependency missing');
const q291 = read('lib/features/camera/gauss_private_model_download_sha_verification_runtime_policy.dart');
assert(!q291.includes("'http:'"), 'Q291 stale http blocked dependency remains');
const review = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
assert(review.includes('Gelişmiş model yöneticisi'), 'legacy OCR review model manager marker missing');
for (const file of [
  'test/v172_q240r1_ocr_benchmark_dataset_lab_runner_test.dart',
  'test/v172_q240r2_ocr_benchmark_external_lab_result_schema_test.dart',
  'test/v172_q240r3_ocr_benchmark_external_lab_intake_validation_gate_test.dart',
  'test/v172_q244_camera_regression_court_test.dart',
  'test/v172_q246_ocr_engine_real_benchmark_package_test.dart',
  'test/v172_q247_winner_engine_selection_test.dart',
]) {
  const text = read(file);
  assert(text.includes("contains('INTERNET')"), file + ' did not acknowledge Q384R1 INTERNET permission');
  assert(!text.includes("isNot(contains('INTERNET'))"), file + ' still has stale INTERNET prohibition');
}
for (const forbidden of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt',
]) {
  assert(fs.existsSync(forbidden), 'protected file missing: ' + forbidden);
}
console.log('PASS verify_analyze_test_stale_contract_hardening_q389r6l (successor-aware through Q389R6M)');
