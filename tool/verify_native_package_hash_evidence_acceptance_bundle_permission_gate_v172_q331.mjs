#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
const sourcePhase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const q332SuccessorPhase = 'V172-Q332-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-BLOCKED-GATE';
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
assert([phase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q331 or Q332 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q331 or Q332 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.nativePackageHashEvidenceAcceptanceBundlePermissionGateLatestPhase === phase, 'Q331 latest phase key missing');
if (manifest.cameraOcrLatestPhase === q332SuccessorPhase) assert(manifest.v172Q332ActualBinaryBundleJniLibsPaddlePredictorBlockedGate, 'Q332 successor envelope missing');
assert(manifest.binaryBundleTrialJniLibsPaddlePredictorDefaultOffLatestPhase === sourcePhase, 'Q330 source latest phase key must remain recorded');
assert(manifest.v172Q330BinaryBundleTrialJniLibsPaddlePredictorDefaultOff, 'Q330 source envelope missing');
const q331 = manifest.v172Q331NativePackageHashEvidenceAcceptanceBundlePermissionGate;
assert(q331 && q331.phase === phase, 'Q331 manifest envelope missing or wrong phase');
assert(q331.sourcePhase === sourcePhase, 'Q331 sourcePhase mismatch');
assert(q331.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q331 native channel mismatch');
assert(q331.nativePackageHashEvidenceAcceptanceMethod === 'nativePackageHashEvidenceAcceptance', 'Q331 method missing');
assert(q331.nativePackageHashEvidenceAcceptanceStatus === 'NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_BLOCKED_PENDING_USER_NATIVE_PACKAGE_HASH_EVIDENCE_DEFAULT_OFF', 'Q331 status mismatch');
assert(q331.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q331 external evidence policy mismatch');
assert(q331.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q331 evidence file mismatch');
assert(Array.isArray(q331.requiredNativePackageFiles) && q331.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q331 required jar missing');
assert(q331.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q331 required arm64 library missing');
assert(q331.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q331 planned jar target missing');
assert(q331.plannedBundleTargets.includes('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'), 'Q331 planned arm64 target missing');
for (const [key, expected] of Object.entries({
  q315HashEvidenceProvidedToAssistant: true,
  q315Sha256MatchesExpected: true,
  q330BinaryBundleTrialRecorded: true,
  mainActivityChanged: true,
  protectedMainActivityChangeDeclared: true,
  methodChannelBindingExtended: true,
  featureFlagDefaultEnabled: false,
  perFileSha256EvidenceProvidedToAssistant: false,
  requiredNativePackageHashEvidenceAccepted: false,
  nativePackageHashEvidenceAccepted: false,
  binaryBundlePermissionGranted: false,
  binaryBundleApproved: false,
  pubspecChanged: false,
  gradleChanged: false,
  androidManifestChanged: false,
  runtimeDependencyAdded: false,
  nativePackageFilesProvidedToProject: false,
  nativeLibraryBundled: false,
  aarBundled: false,
  jarBundled: false,
  jniLibsDirectoryCreated: false,
  androidAppLibsDirectoryCreated: false,
  systemLoadLibraryAdded: false,
  paddleLiteInstantiated: false,
  buildTrialExecuted: false,
  buildTrialPassed: false,
  modelConversionExecuted: false,
  nativeModelLoaderAdded: false,
  modelLoaderAvailable: false,
  modelArtifactAcceptedForRuntime: false,
  runtimeStartupExecuted: false,
  modelLoaded: false,
  dummyRuntimeCallExecuted: false,
  realImageToLatexInferenceExecuted: false,
  editableMathLiveReviewOpened: false,
  workspaceImportExecuted: false,
  ocrPassClaimed: false,
  androidRealDevicePassClaimed: false,
  storeReadyPassClaimed: false,
  releasePassClaimed: false,
})) {
  assert(q331[key] === expected, `Q331 ${key} expected ${expected}, got ${q331[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q331Phase = "${phase}"`), 'MainActivity missing q331 phase constant');
assert(mainActivity.includes('private val q331NativePackageHashEvidenceAcceptanceFeatureEnabled = false'), 'MainActivity missing q331 default-off flag');
assert(mainActivity.includes('"nativePackageHashEvidenceAcceptance" -> result.success(q331NativePackageHashEvidenceAcceptance(call.method))'), 'MainActivity missing q331 channel method binding');
assert(mainActivity.includes('private fun q331NativePackageHashEvidenceAcceptance(method: String): Map<String, Any>'), 'MainActivity missing q331 method');
assert(mainActivity.includes('"binaryBundlePermissionGranted" to false'), 'Q331 bridge must keep bundle permission false');
assert(mainActivity.includes('"nativeLibraryBundled" to false'), 'Q331 bridge must keep nativeLibraryBundled false');
assert(mainActivity.includes('"jarBundled" to false'), 'Q331 bridge must keep jarBundled false');
assert(mainActivity.includes('"systemLoadLibraryAdded" to false'), 'Q331 bridge must keep systemLoadLibraryAdded false');
for (const forbidden of ['System.loadLibrary', 'PaddlePredictor(', 'MobileConfig', 'PaddleOCR', 'OnnxRuntime', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q331 MainActivity must not include ${forbidden}`);
}

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr', 'paddle_lite', 'onnxruntime', 'tflite_flutter']) {
  assert(!pubspec.includes(forbidden), `Q331 must not add pubspec dependency marker ${forbidden}`);
}
const androidFiles = exists('android/app') ? walk(path.join(projectRoot, 'android/app')) : [];
const forbiddenBinaries = androidFiles.filter((file) => ['.so', '.aar', '.jar'].some((suffix) => file.endsWith(suffix)));
assert(forbiddenBinaries.length === 0, `Q331 must not bundle native binaries: ${forbiddenBinaries.join(', ')}`);
assert(!exists('android/app/src/main/jniLibs'), 'Q331 must not create jniLibs directory');
assert(!exists('android/app/libs'), 'Q331 must not create android/app/libs directory');

for (const rel of [
  'lib/features/camera/gauss_native_package_hash_evidence_acceptance_bundle_permission_gate_q331_policy.dart',
  'lib/features/camera/gauss_native_package_hash_evidence_acceptance_bundle_permission_gate_q331.dart',
  'test/v172_q331_native_package_hash_evidence_acceptance_bundle_permission_gate_test.dart',
  'docs/audit/V172_Q331_NATIVE_PACKAGE_HASH_EVIDENCE_ACCEPTANCE_BUNDLE_PERMISSION_GATE_AUDIT.md',
  'docs/audit/V172_Q331_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q331 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q331_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q331 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes('nativePackageHashEvidenceAcceptance'), 'Q331 changed-files doc must mention nativePackageHashEvidenceAcceptance');
console.log(JSON.stringify({
  phase,
  status: q331.nativePackageHashEvidenceAcceptanceStatus,
  externalNativePackageEvidencePolicy: q331.externalNativePackageEvidencePolicy,
  perFileSha256EvidenceProvidedToAssistant: q331.perFileSha256EvidenceProvidedToAssistant,
  nativePackageHashEvidenceAccepted: q331.nativePackageHashEvidenceAccepted,
  binaryBundlePermissionGranted: q331.binaryBundlePermissionGranted,
  nativeLibraryBundled: q331.nativeLibraryBundled,
  jarBundled: q331.jarBundled,
  jniLibsDirectoryCreated: q331.jniLibsDirectoryCreated,
  runtimeDependencyAdded: q331.runtimeDependencyAdded,
  realImageToLatexInferenceExecuted: q331.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q331.ocrPassClaimed,
}, null, 2));
