#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const phase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const sourcePhase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const status = 'NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_Q328_JSON_INTAKE_BLOCKED_PENDING_USER_SIDE_NATIVE_PACKAGE_FILES_DEFAULT_OFF';
const q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const q343SuccessorPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function assert(condition, message) { if (!condition) { console.error(`[${phase}] ${message}`); process.exit(1); } }

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));

const q344AndLaterBinaryBundlePhases = new Set([
  'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR',
  'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL',
  'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE',
  'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE',
  'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE',
  'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED',
  'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE',
  'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE',
  'V172-Q351R1-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR',
  'V172-Q351R2-FLUTTER-RUN-KOTLIN-BUILD-HELPER-REPAIR',
  'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE', 'V172-Q353-ONNX-RUNTIME-MOBILE-DEPENDENCY-FEASIBILITY-GATE', 'V172-Q354-ONNX-RUNTIME-ANDROID-DEPENDENCY-ABI-BUILD-TRIAL', 'V172-Q355-ONNX-MODEL-PRIVATE-STORAGE-SHA-VERIFICATION', 'V172-Q356-ONNX-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED', 'V172-Q356R1-ONNX-RUNTIME-ANDROID-BUILD-EVIDENCE-INTAKE-MODEL-LOAD-UNLOCK-GUARD', 'V172-Q356R2-ONNX-RUNTIME-ANDROID-MISSING-BUILD-EVIDENCE-Q357-LOCK-GUARD',
  'V172-Q357-ONNX-REAL-MODEL-LOAD-SMOKE-BRIDGE-PREFLIGHT-EXECUTION', 'V172-Q358-ONNX-DUMMY-INPUT-RUNTIME-CALL-GUARD-PREFLIGHT', 'V172-Q359-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE-GUARD-CANDIDATE-ENVELOPE-PREFLIGHT', 'V172-Q360-OCR-REVIEW-APPROVED-IMPORT-CONTRACT', 'V172-Q361-CAMERA-OCR-RUNTIME-EXECUTION-BRIDGE',
  'V172-Q362-ACCURACY-PERFORMANCE-MULTIDEVICE-QA-GUARD', 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE',
]);
const q344AllowedBinaryTargets = new Set([
  'android/app/libs/PaddlePredictor.jar',
  'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
  'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
]);
function allowQ344OrLaterBundledBinaries() {
  return q344AndLaterBinaryBundlePhases.has(manifest.cameraOcrLatestPhase) ||
      q344AndLaterBinaryBundlePhases.has(manifest.activeProductDevelopmentLatestPhase);
}

assert([phase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase, ...q344AndLaterBinaryBundlePhases].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q336 or Q337 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase, ...q344AndLaterBinaryBundlePhases].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q336 or Q337 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativePackageHashEvidenceCaptureQ328JsonIntakeLatestPhase === phase, 'Q336 latest phase key missing');
const q336 = manifest.v172Q336NativePackageHashEvidenceCaptureQ328JsonIntake;
assert(q336 && q336.phase === phase, 'Q336 manifest envelope missing or wrong phase');
assert(q336.sourcePhase === sourcePhase, 'Q336 sourcePhase mismatch');
assert(q336.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q336 native channel mismatch');
assert(q336.nativePackageHashEvidenceCaptureQ328JsonIntakeMethod === 'nativePackageHashEvidenceCaptureQ328JsonIntake', 'Q336 method missing');
assert(q336.nativePackageHashEvidenceCaptureQ328JsonIntakeStatus === status, 'Q336 status mismatch');
assert(q336.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q336 external intake policy mismatch');
assert(q336.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q336 evidence file name mismatch');
assert(q336.q336EvidenceIntakeScript === 'tool/intake_q328_native_package_hash_evidence_v172_q336.mjs', 'Q336 intake script mismatch');
assert(q336.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q336 required jar missing');
assert(q336.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q336 required arm64 lib missing');
assert(q336.requiredNativePackageFiles.includes('armeabi-v7a/libpaddle_lite_jni.so'), 'Q336 required armeabi-v7a lib missing');
assert(q336.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q336 planned jar target missing');

for (const [key, expected] of Object.entries({
  q328NativePackageHashEvidenceJsonProvided: false,
  q328NativePackageHashEvidenceJsonReviewed: false,
  requiredNativePackageFilesAllPresentInEvidence: false,
  perFileSha256EvidenceProvidedToAssistant: false,
  nativePackageHashEvidenceAccepted: false,
  explicitUserBinaryBundleApprovalProvided: false,
  binaryBundlePermissionGranted: false,
  actualBinaryBundleExecuted: false,
  nativeLibraryBundled: false,
  jarBundled: false,
  jniLibsDirectoryCreated: false,
  androidAppLibsDirectoryCreated: false,
  systemLoadLibraryAdded: false,
  paddleLiteInstantiated: false,
  runtimeDependencyAdded: false,
  realImageToLatexInferenceExecuted: false,
  ocrPassClaimed: false,
  androidRealDevicePassClaimed: false,
  storeReadyPassClaimed: false,
  releasePassClaimed: false,
})) {
  assert(q336[key] === expected, `Q336 ${key} expected ${expected}, got ${q336[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q336Phase = "${phase}"`), 'MainActivity missing q336 phase constant');
assert(mainActivity.includes('"nativePackageHashEvidenceCaptureQ328JsonIntake" -> result.success(q336NativePackageHashEvidenceCaptureQ328JsonIntake(call.method))'), 'MainActivity missing Q336 method binding');
assert(mainActivity.includes('"q328NativePackageHashEvidenceJsonProvided" to false'), 'Q336 bridge must keep evidence-provided false');
assert(mainActivity.includes('"requiredNativePackageFilesAllPresentInEvidence" to false'), 'Q336 bridge must keep required evidence completeness false');
assert(mainActivity.includes('"actualBinaryBundleExecuted" to false'), 'Q336 bridge must keep actual bundle false');
assert(mainActivity.includes('"nativeLibraryBundled" to false'), 'Q336 bridge must keep native bundle false');
assert(mainActivity.includes('"jarBundled" to false'), 'Q336 bridge must keep jar bundle false');
for (const forbidden of ['System.loadLibrary(', 'PaddlePredictor(', 'Predictor(', 'PaddleLite(']) {
  assert(!mainActivity.includes(forbidden), `Q336 MainActivity must not include ${forbidden}`);
}

const forbiddenBinaries = [];
function walk(dir) {
  if (!fs.existsSync(dir)) return;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full);
    else if (/\.(so|aar|jar)$/i.test(entry.name)) forbiddenBinaries.push(path.relative(root, full));
  }
}
walk(path.join(root, 'android', 'app'));
if (allowQ344OrLaterBundledBinaries()) {
  const unexpected = forbiddenBinaries.map(rel => rel.replaceAll(path.sep, '/')).filter(rel => !q344AllowedBinaryTargets.has(rel));
  assert(unexpected.length === 0, `Q336 must allow only Q344-approved bundled binaries under Q344-Q352 successors: ${unexpected.join(', ')}`);
} else {
  assert(forbiddenBinaries.length === 0, `Q336 must not bundle native binaries before Q344: ${forbiddenBinaries.join(', ')}`);
  assert(!exists('android/app/src/main/jniLibs'), 'Q336 must not create jniLibs directory before Q344');
  assert(!exists('android/app/libs'), 'Q336 must not create android/app/libs directory before Q344');
}
assert(exists('tool/intake_q328_native_package_hash_evidence_v172_q336.mjs'), 'Q336 intake evidence script missing');
for (const rel of [
  'lib/features/camera/gauss_native_package_hash_evidence_capture_q328_json_intake_q336_policy.dart',
  'lib/features/camera/gauss_native_package_hash_evidence_capture_q328_json_intake_q336.dart',
  'test/v172_q336_native_package_hash_evidence_capture_q328_json_intake_test.dart',
  'docs/audit/V172_Q336_NATIVE_PACKAGE_HASH_EVIDENCE_CAPTURE_Q328_JSON_INTAKE_AUDIT.md',
  'docs/audit/V172_Q336_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q336 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q336_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q336 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes('nativePackageHashEvidenceCaptureQ328JsonIntake'), 'Q336 changed-files doc must mention bridge method');
console.log(JSON.stringify({ phase, status: q336.nativePackageHashEvidenceCaptureQ328JsonIntakeStatus, ok: true }, null, 2));
