#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const phase = 'V172-Q363R4-ANALYZER-WARNING-HYGIENE-REPAIR';
const sourcePhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const errors = [];
const check = (condition, message) => { if (!condition) errors.push(message); };

check(manifest.cameraOcrLatestPhase === sourcePhase, 'cameraOcrLatestPhase must remain Q363');
check(manifest.activeProductDevelopmentLatestPhase === sourcePhase, 'activeProductDevelopmentLatestPhase must remain Q363');
check(manifest.q363R4AnalyzerWarningHygieneRepairLatestPhase === phase, 'Q363R4 latest hygiene phase missing');
const q363r4 = manifest.v172Q363R4AnalyzerWarningHygieneRepair || {};
check(q363r4.phase === phase, 'Q363R4 manifest phase mismatch');
check(q363r4.sourcePhase === sourcePhase, 'Q363R4 manifest source phase mismatch');
check(q363r4.repairsDuplicateSetLiteralElements === true, 'Q363R4 must repair duplicate set literal elements');
check(q363r4.removesDuplicateQ363LiteralWhereQ363ConstantAlreadyExists === true, 'Q363R4 must declare duplicate Q363 literal removal');
check(q363r4.repairsAnalyzerWarningsOnly === true, 'Q363R4 must be analyzer-warning-only');
check(q363r4.modifiesMainActivity === false, 'Q363R4 must not modify MainActivity');
check(q363r4.modifiesGradle === false, 'Q363R4 must not modify Gradle');
check(q363r4.ocrPassClaimed === false, 'Q363R4 must not claim OCR PASS');

for (const rel of [
  'lib/features/camera/gauss_q363r4_analyzer_warning_hygiene_repair_policy.dart',
  'lib/features/camera/gauss_q363r4_analyzer_warning_hygiene_repair.dart',
  'test/v172_q363r4_analyzer_warning_hygiene_repair_test.dart',
]) check(exists(rel), `${rel} missing`);

const testFiles = fs.readdirSync(path.join(root, 'test')).filter((name) => name.endsWith('.dart'));
for (const name of testFiles) {
  const rel = `test/${name}`;
  const content = read(rel);
  check(!content.includes("q363SuccessorPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'"), `${rel} still has duplicate q363SuccessorPhase literal in set/list`);
  check(!content.includes("q363StorePrivacyFinalReleaseGatePhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'"), `${rel} still has duplicate q363StorePrivacyFinalReleaseGatePhase literal`);
  check(!content.includes("manifest['cameraOcrLatestPhase',"), `${rel} contains malformed cameraOcrLatestPhase map access`);
  check(!content.includes("manifest['activeProductDevelopmentLatestPhase',"), `${rel} contains malformed activeProductDevelopmentLatestPhase map access`);
  check(!content.includes("\n    ,\n"), `${rel} contains standalone leading comma line`);
  check(!content.includes("\n      ,\n"), `${rel} contains standalone indented leading comma line`);
}

const q353 = read('test/v172_q353_onnx_runtime_mobile_dependency_feasibility_gate_test.dart');
check(!q353.includes("q363SuccessorPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'"), 'Q353 test still has duplicate Q363 set element');
const q354 = read('test/v172_q354_onnx_runtime_android_dependency_abi_build_trial_test.dart');
check(!q354.includes("q363SuccessorPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'"), 'Q354 test still has duplicate Q363 set element');
const q355 = read('test/v172_q355_onnx_model_private_storage_sha_verification_test.dart');
check(!q355.includes("q363SuccessorPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'"), 'Q355 test still has duplicate Q363 set element');
const q356 = read('test/v172_q356_onnx_real_model_load_smoke_evidence_blocked_test.dart');
check(!q356.includes("q363SuccessorPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'"), 'Q356 test still has duplicate Q363 set element');
const q356r1 = read('test/v172_q356r1_onnx_runtime_android_build_evidence_intake_model_load_unlock_guard_test.dart');
check(!q356r1.includes("q363SuccessorPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'"), 'Q356R1 test still has duplicate Q363 set element');
const q356r2 = read('test/v172_q356r2_onnx_runtime_android_missing_build_evidence_q357_lock_guard_test.dart');
check(!q356r2.includes("q363SuccessorPhase, 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE'"), 'Q356R2 test still has duplicate Q363 set element');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
check(!mainActivity.includes('q363r4'), 'Q363R4 must not modify MainActivity/runtime bridge');
const gradle = read('android/app/build.gradle');
check(gradle.includes("implementation 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0'"), 'Q354 ONNX Runtime dependency must remain preserved');
const pubspec = read('pubspec.yaml').toLowerCase();
check(!pubspec.includes('onnxruntime'), 'pubspec must not gain ONNX Runtime dependency');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
check(!androidManifest.includes('ONNX'), 'AndroidManifest must not be modified for ONNX');

const forbiddenModelExtensions = /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$/i;
const walk = (dir) => {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    const rel = path.relative(root, full).replaceAll(path.sep, '/');
    if (rel.startsWith('build/') || rel.includes('/build/') || rel.startsWith('.dart_tool/') || rel.includes('/.dart_tool/')) continue;
    if (entry.isDirectory()) walk(full);
    if (entry.isFile() && forbiddenModelExtensions.test(entry.name) && !rel.startsWith('docs/evidence/')) {
      errors.push(`model artifact must not be bundled: ${rel}`);
    }
  }
};
walk(root);

if (errors.length) {
  console.error('Q363R4_ANALYZER_WARNING_HYGIENE_REPAIR_FAILED');
  for (const error of errors) console.error(` - ${error}`);
  process.exit(1);
}
console.log('Q363R4_ANALYZER_WARNING_HYGIENE_REPAIR_PASS');
