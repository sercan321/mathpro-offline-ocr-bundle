#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
const sourcePhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const q333SuccessorPhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
const q334SuccessorPhase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';
const q335SuccessorPhase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const q336SuccessorPhase = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const q337SuccessorPhase = 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE';
const q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const projectRoot = process.cwd();
function read(rel) { return fs.readFileSync(path.join(projectRoot, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(projectRoot, rel)); }
function fail(message) { console.error(`[${phase}] ${message}`); process.exit(1); }
function assert(condition, message) { if (!condition) fail(message); }
function walk(dir) {
  const out = [];
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) out.push(...walk(full));
    else out.push(full);
  }
  return out;
}

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([phase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q332 or Q333 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q332 or Q333 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.actualBinaryBundleJniLibsPaddlePredictorBlockedGateLatestPhase === phase, 'Q332 latest phase key missing');
if (manifest.cameraOcrLatestPhase === q333SuccessorPhase) assert(manifest.v172Q333NativePackageHashEvidenceIntakeRealBundlePermissionReview, 'Q333 successor envelope missing');
assert(manifest.nativePackageHashEvidenceAcceptanceBundlePermissionGateLatestPhase === sourcePhase, 'Q331 source latest phase key must remain recorded');
assert(manifest.v172Q331NativePackageHashEvidenceAcceptanceBundlePermissionGate, 'Q331 source envelope missing');
const q332 = manifest.v172Q332ActualBinaryBundleJniLibsPaddlePredictorBlockedGate;
assert(q332 && q332.phase === phase, 'Q332 manifest envelope missing or wrong phase');
assert(q332.sourcePhase === sourcePhase, 'Q332 sourcePhase mismatch');
assert(q332.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q332 native channel mismatch');
assert(q332.actualBinaryBundleGateMethod === 'actualBinaryBundleGate', 'Q332 method missing');
assert(q332.actualBinaryBundleGateStatus === 'ACTUAL_BINARY_BUNDLE_BLOCKED_PENDING_NATIVE_PACKAGE_HASH_EVIDENCE_AND_EXPLICIT_USER_APPROVAL_DEFAULT_OFF', 'Q332 status mismatch');
assert(q332.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q332 external evidence policy mismatch');
assert(q332.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q332 evidence file mismatch');
assert(Array.isArray(q332.requiredNativePackageFiles) && q332.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q332 required jar missing');
assert(q332.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q332 required arm64 library missing');
assert(q332.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q332 planned jar target missing');
assert(q332.plannedBundleTargets.includes('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'), 'Q332 planned arm64 target missing');
for (const [key, expected] of Object.entries({
  q315HashEvidenceProvidedToAssistant: true,
  q315Sha256MatchesExpected: true,
  q331NativePackageHashEvidenceAcceptanceRecorded: true,
  mainActivityChanged: true,
  protectedMainActivityChangeDeclared: true,
  methodChannelBindingExtended: true,
  featureFlagDefaultEnabled: false,
  perFileSha256EvidenceProvidedToAssistant: false,
  requiredNativePackageHashEvidenceAccepted: false,
  nativePackageHashEvidenceAccepted: false,
  explicitUserBinaryBundleApprovalProvided: false,
  binaryBundlePermissionGranted: false,
  binaryBundleApproved: false,
  actualBinaryBundleExecuted: false,
  nativePackageFilesProvidedToProject: false,
  pubspecChanged: false,
  gradleChanged: false,
  androidManifestChanged: false,
  runtimeDependencyAdded: false,
  nativeLibraryBundled: false,
  aarBundled: false,
  jarBundled: false,
  jniLibsDirectoryCreated: false,
  androidAppLibsDirectoryCreated: false,
  systemLoadLibraryAdded: false,
  paddleLiteInstantiated: false,
  abiPackagingTrialExecuted: false,
  buildTrialExecuted: false,
  buildTrialPassed: false,
  modelConversionExecuted: false,
  nativeModelLoaderAdded: false,
  modelLoaderAvailable: false,
  modelArtifactAcceptedForRuntime: false,
  runtimeStartupAttempted: false,
  runtimeStartupExecuted: false,
  runtimeStartupSmokePassed: false,
  modelLoadAttempted: false,
  modelLoaded: false,
  dummyRuntimeCallAttempted: false,
  dummyRuntimeCallExecuted: false,
  dummyRuntimeCallPassed: false,
  realImageToLatexInferenceAttempted: false,
  realImageToLatexInferenceExecuted: false,
  realImageToLatexInferencePassed: false,
  editableMathLiveReviewOpened: false,
  workspaceImportExecuted: false,
  ocrPassClaimed: false,
  androidRealDevicePassClaimed: false,
  storeReadyPassClaimed: false,
  releasePassClaimed: false,
})) {
  assert(q332[key] === expected, `Q332 ${key} expected ${expected}, got ${q332[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q332Phase = "${phase}"`), 'MainActivity missing q332 phase constant');
assert(mainActivity.includes('private val q332ActualBinaryBundleGateFeatureEnabled = false'), 'MainActivity missing q332 default-off flag');
assert(mainActivity.includes('"actualBinaryBundleGate" -> result.success(q332ActualBinaryBundleGate(call.method))'), 'MainActivity missing q332 channel method binding');
assert(mainActivity.includes('private fun q332ActualBinaryBundleGate(method: String): Map<String, Any>'), 'MainActivity missing q332 method');
assert(mainActivity.includes('"actualBinaryBundleExecuted" to false'), 'Q332 bridge must keep actualBinaryBundleExecuted false');
assert(mainActivity.includes('"binaryBundlePermissionGranted" to false'), 'Q332 bridge must keep bundle permission false');
assert(mainActivity.includes('"nativeLibraryBundled" to false'), 'Q332 bridge must keep nativeLibraryBundled false');
assert(mainActivity.includes('"jarBundled" to false'), 'Q332 bridge must keep jarBundled false');
assert(mainActivity.includes('"systemLoadLibraryAdded" to false'), 'Q332 bridge must keep systemLoadLibraryAdded false');
for (const forbidden of ['System.loadLibrary', 'PaddlePredictor(', 'MobileConfig', 'PaddleOCR', 'OnnxRuntime', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q332 MainActivity must not include ${forbidden}`);
}

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr', 'paddle_lite', 'onnxruntime', 'tflite_flutter']) {
  assert(!pubspec.includes(forbidden), `Q332 must not add pubspec dependency marker ${forbidden}`);
}
const androidFiles = exists('android/app') ? walk(path.join(projectRoot, 'android/app')) : [];
const forbiddenBinaries = androidFiles.filter((file) => ['.so', '.aar', '.jar'].some((suffix) => file.endsWith(suffix)));
assert(forbiddenBinaries.length === 0, `Q332 must not bundle native binaries: ${forbiddenBinaries.join(', ')}`);
assert(!exists('android/app/src/main/jniLibs'), 'Q332 must not create jniLibs directory');
assert(!exists('android/app/libs'), 'Q332 must not create android/app/libs directory');

for (const rel of [
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_blocked_gate_q332_policy.dart',
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_blocked_gate_q332.dart',
  'test/v172_q332_actual_binary_bundle_jnilibs_paddlepredictor_blocked_gate_test.dart',
  'docs/audit/V172_Q332_ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_BLOCKED_GATE_AUDIT.md',
  'docs/audit/V172_Q332_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q332 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q332_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q332 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes('actualBinaryBundleGate'), 'Q332 changed-files doc must mention actualBinaryBundleGate');
console.log(JSON.stringify({
  phase,
  status: q332.actualBinaryBundleGateStatus,
  externalNativePackageEvidencePolicy: q332.externalNativePackageEvidencePolicy,
  perFileSha256EvidenceProvidedToAssistant: q332.perFileSha256EvidenceProvidedToAssistant,
  nativePackageHashEvidenceAccepted: q332.nativePackageHashEvidenceAccepted,
  explicitUserBinaryBundleApprovalProvided: q332.explicitUserBinaryBundleApprovalProvided,
  actualBinaryBundleExecuted: q332.actualBinaryBundleExecuted,
  nativeLibraryBundled: q332.nativeLibraryBundled,
  jarBundled: q332.jarBundled,
  jniLibsDirectoryCreated: q332.jniLibsDirectoryCreated,
  runtimeDependencyAdded: q332.runtimeDependencyAdded,
  realImageToLatexInferenceExecuted: q332.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q332.ocrPassClaimed,
}, null, 2));
