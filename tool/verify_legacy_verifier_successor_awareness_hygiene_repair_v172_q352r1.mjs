#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q352R1-LEGACY-VERIFIER-SUCCESSOR-AWARENESS-HYGIENE-REPAIR';
const sourcePhase = 'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
const q353SuccessorPhase = 'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE';
const q354SuccessorPhase = 'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL';
const q355SuccessorPhase = 'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION';
const q356SuccessorPhase = 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
const q356r1SuccessorPhase = 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD';
const q356r2SuccessorPhase = 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD';
const q357SuccessorPhase = 'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION';
const q358SuccessorPhase = 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT';
const q359SuccessorPhase = 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT';
const q360SuccessorPhase = 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT';
const q361SuccessorPhase = 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE';
const q362SuccessorPhase = 'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD';
const q363SuccessorPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const status = 'LEGACY_Q336_Q343_VERIFIER_SUCCESSOR_AWARENESS_REPAIRED_FOR_Q352_NO_RUNTIME_NO_UI_CHANGE';
const expectedTargets = new Map([
  ['android/app/libs/PaddlePredictor.jar', { size: 9167, sha256: '81c8f73729123fd4b65b1b0d01ad58f9a0f0fe61274d49179910696cc68959f2' }],
  ['android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so', { size: 4531976, sha256: '2eb3cd0f1d3d01c2199ee79d28f5bef7180a699f7bd9cbb183743f3031277fe2' }],
  ['android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so', { size: 2877288, sha256: '261de17f07130118962226f451a9a75aae84ff15bfe4e4b6b2ed942b5a7b121f' }],
]);
const repairedVerifierFiles = [
  'tool/verify_native_package_hash_evidence_capture_q328_json_intake_v172_q336.mjs',
  'tool/verify_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_v172_q337.mjs',
  'tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_no_evidence_blocked_gate_v172_q338.mjs',
  'tool/verify_native_package_hash_evidence_capture_actual_bundle_permission_final_check_v172_q339.mjs',
  'tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_evidence_blocked_gate_v172_q340.mjs',
  'tool/verify_native_package_hash_evidence_capture_bundle_evidence_acceptance_v172_q341.mjs',
  'tool/verify_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_v172_q342.mjs',
  'tool/verify_native_package_hash_evidence_final_acceptance_real_bundle_unlock_gate_v172_q343.mjs',
  'tool/verify_q343_flutter_analyze_test_successor_aware_hygiene_repair_v172_q343r1.mjs',
  'tool/verify_q343r1_flutter_analyze_test_syntax_hygiene_repair_v172_q343r2.mjs',
];
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function assert(condition, message) { if (!condition) { console.error(`[${phase}] ${message}`); process.exit(1); } }
function sha256File(rel) { return crypto.createHash('sha256').update(fs.readFileSync(path.join(root, rel))).digest('hex'); }
function walk(dir, out = []) {
  if (!fs.existsSync(dir)) return out;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full, out); else out.push(path.relative(root, full).replaceAll(path.sep, '/'));
  }
  return out;
}
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([sourcePhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `Q352R1 must preserve Q352 or accept Q353 successor cameraOcrLatestPhase, got ${manifest.cameraOcrLatestPhase}`);
assert([sourcePhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `Q352R1 must preserve Q352 or accept Q353 successor activeProductDevelopmentLatestPhase, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.legacyVerifierSuccessorAwarenessHygieneRepairLatestPhase === phase, 'Q352R1 latest key missing');
const q352r1 = manifest.v172Q352R1LegacyVerifierSuccessorAwarenessHygieneRepair;
assert(q352r1 && q352r1.phase === phase, 'Q352R1 manifest envelope missing');
assert(q352r1.sourcePhase === sourcePhase, 'Q352R1 source phase mismatch');
assert(q352r1.status === status, 'Q352R1 status mismatch');
for (const key of ['legacyQ336ToQ343VerifiersAcceptQ352','q344ApprovedBinaryAllowancePreserved','q352RuntimeStrategyPivotPreserved','q352OnnxEvidencePreserved']) {
  assert(q352r1[key] === true, `Q352R1 must keep ${key} true`);
}
for (const key of ['cameraOcrLatestPhaseAdvanced','activeProductDevelopmentLatestPhaseAdvanced','onnxRuntimeDependencyAdded','onnxModelBundledIntoFlutterProject','onnxModelCopiedToAppPrivateStorage','onnxModelLoadAttempted','onnxModelLoaded','runtimeStartupExecuted','dummyRuntimeCallExecuted','realImageToLatexInferenceExecuted','editableMathLiveReviewOpened','workspaceImportExecuted','mainActivityChanged','gradleChanged','pubspecChanged','androidManifestChanged','workspaceChanged','keyboardChanged','moreTemplateTrayChanged','longPressChanged','mathLiveProductionBridgeChanged','graphChanged','solutionChanged','historyChanged','splashChanged','iconChanged','ocrPassClaimed','androidRealDevicePassClaimedByPackage']) {
  assert(q352r1[key] === false, `Q352R1 must keep ${key} false`);
}
for (const rel of repairedVerifierFiles) {
  assert(exists(rel), `Q352R1 repaired verifier missing: ${rel}`);
  const text = read(rel);
  assert(text.includes(sourcePhase), `${rel} must explicitly accept Q352 successor phase`);
  assert(!text.includes('Unexpected string'), `${rel} must not contain syntax-error residue`);
}
for (const rel of [
  'lib/features/camera/gauss_legacy_verifier_successor_awareness_hygiene_repair_q352r1_policy.dart',
  'lib/features/camera/gauss_legacy_verifier_successor_awareness_hygiene_repair_q352r1.dart',
  'test/v172_q352r1_legacy_verifier_successor_awareness_hygiene_repair_test.dart',
  'tool/verify_legacy_verifier_successor_awareness_hygiene_repair_v172_q352r1.mjs',
  'docs/audit/V172_Q352R1_LEGACY_VERIFIER_SUCCESSOR_AWARENESS_HYGIENE_REPAIR_AUDIT.md',
  'docs/audit/V172_Q352R1_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q352R1 expected file missing: ${rel}`);
}
assert(read('android/app/build.gradle').includes("implementation files('libs/PaddlePredictor.jar')"), 'Q352R1 must preserve Q345 jar dependency');
if ([q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase)) {
  assert(read('android/app/build.gradle').includes("implementation 'com.microsoft.onnxruntime:onnxruntime-android:1.26.0'"), 'Q352R1 successor Q354 must contain selected ONNX Runtime dependency');
} else {
  assert(!read('android/app/build.gradle').toLowerCase().includes('onnxruntime'), 'Q352R1 must not add ONNX Runtime dependency');
}
assert(!read('pubspec.yaml').toLowerCase().includes('onnx'), 'Q352R1 must not add ONNX dependency to pubspec');
assert(!read('android/app/src/main/AndroidManifest.xml').includes('ONNX'), 'Q352R1 must not mutate AndroidManifest for ONNX');
for (const [rel, expected] of expectedTargets.entries()) {
  assert(exists(rel), `Q352R1 expected Q344 bundled target missing: ${rel}`);
  const stat = fs.statSync(path.join(root, rel));
  assert(stat.size === expected.size, `${rel} size mismatch: ${stat.size}`);
  assert(sha256File(rel) === expected.sha256, `${rel} sha256 mismatch`);
}
const unexpectedBinaries = walk(path.join(root, 'android', 'app')).filter(rel => /\.(so|jar|aar)$/i.test(rel) && !expectedTargets.has(rel));
assert(unexpectedBinaries.length === 0, `Q352R1 unexpected binary artifacts: ${unexpectedBinaries.join(', ')}`);
const forbiddenModelFiles = walk(root).filter(rel => !rel.startsWith('docs/evidence/') && /\.(pdmodel|pdiparams|nb|onnx|tflite|pt|pth|pdparams|safetensors|bin)$/i.test(rel));
assert(forbiddenModelFiles.length === 0, `Q352R1 must not bundle model artifacts: ${forbiddenModelFiles.join(', ')}`);
console.log(JSON.stringify({ phase, sourcePhase, status, repairedVerifierFiles: repairedVerifierFiles.length, cameraOcrLatestPhase: manifest.cameraOcrLatestPhase, onnxRuntimeDependencyAdded: q352r1.onnxRuntimeDependencyAdded, ocrPassClaimed: q352r1.ocrPassClaimed, ok: true }, null, 2));
