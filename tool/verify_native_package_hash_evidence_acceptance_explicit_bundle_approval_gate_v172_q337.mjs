#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const q343SuccessorPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
const phase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const sourcePhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const status = 'NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_EXPLICIT_BUNDLE_APPROVAL_BLOCKED_PENDING_Q328_JSON_AND_USER_APPROVAL_DEFAULT_OFF';
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

assert([phase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase, ...q344AndLaterBinaryBundlePhases].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q337 or Q338 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase, q343SuccessorPhase, ...q344AndLaterBinaryBundlePhases].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q337 or Q338 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativePackageHashEvidenceAcceptanceExplicitBundleApprovalGateLatestPhase === phase, 'Q337 latest phase key missing');
const q337 = manifest.v172Q337NativePackageHashEvidenceAcceptanceExplicitBundleApprovalGate;
assert(q337 && q337.phase === phase, 'Q337 manifest envelope missing or wrong phase');
assert(q337.sourcePhase === sourcePhase, 'Q337 sourcePhase mismatch');
assert(q337.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q337 native channel mismatch');
assert(q337.nativePackageHashEvidenceAcceptanceExplicitBundleApprovalMethod === 'nativePackageHashEvidenceAcceptanceExplicitBundleApproval', 'Q337 method missing');
assert(q337.nativePackageHashEvidenceAcceptanceExplicitBundleApprovalStatus === status, 'Q337 status mismatch');
assert(q337.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q337 external intake policy mismatch');
assert(q337.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q337 evidence file name mismatch');
assert(q337.q337BundleApprovalGateScript === 'tool/verify_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_v172_q337.mjs', 'Q337 approval gate script mismatch');
assert(q337.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q337 required jar missing');
assert(q337.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q337 required arm64 lib missing');
assert(q337.requiredNativePackageFiles.includes('armeabi-v7a/libpaddle_lite_jni.so'), 'Q337 required armeabi-v7a lib missing');
assert(q337.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q337 planned jar target missing');

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
})) {
  assert(q337[key] === expected, `Q337 ${key} expected ${expected}, got ${q337[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q337Phase = "${phase}"`), 'MainActivity missing q337 phase constant');
assert(mainActivity.includes('"nativePackageHashEvidenceAcceptanceExplicitBundleApproval" -> result.success(q337NativePackageHashEvidenceAcceptanceExplicitBundleApproval(call.method))'), 'MainActivity missing Q337 method binding');
assert(mainActivity.includes('"explicitUserBinaryBundleApprovalProvided" to false'), 'Q337 bridge must keep user bundle approval false');
assert(mainActivity.includes('"actualBinaryBundleExecuted" to false'), 'Q337 bridge must keep actual bundle false');
assert(mainActivity.includes('"nativeLibraryBundled" to false'), 'Q337 bridge must keep native bundle false');
assert(mainActivity.includes('"jarBundled" to false'), 'Q337 bridge must keep jar bundle false');
for (const forbidden of ['System.loadLibrary(', 'PaddlePredictor(', 'Predictor(', 'PaddleLite(']) {
  assert(!mainActivity.includes(forbidden), `Q337 MainActivity must not include ${forbidden}`);
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
  assert(unexpected.length === 0, `Q337 must allow only Q344-approved bundled binaries under Q344-Q352 successors: ${unexpected.join(', ')}`);
} else {
  assert(forbiddenBinaries.length === 0, `Q337 must not bundle native binaries before Q344: ${forbiddenBinaries.join(', ')}`);
  assert(!exists('android/app/src/main/jniLibs'), 'Q337 must not create jniLibs directory before Q344');
  assert(!exists('android/app/libs'), 'Q337 must not create android/app/libs directory before Q344');
}
for (const rel of [
  'lib/features/camera/gauss_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_q337_policy.dart',
  'lib/features/camera/gauss_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_q337.dart',
  'test/v172_q337_native_package_hash_evidence_acceptance_explicit_bundle_approval_gate_test.dart',
  'docs/audit/V172_Q337_NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_EXPLICIT_BUNDLE_APPROVAL_GATE_AUDIT.md',
  'docs/audit/V172_Q337_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q337 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q337_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q337 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes('nativePackageHashEvidenceAcceptanceExplicitBundleApproval'), 'Q337 changed-files doc must mention bridge method');
console.log(JSON.stringify({ phase, status: q337.nativePackageHashEvidenceAcceptanceExplicitBundleApprovalStatus, ok: true }, null, 2));
