#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const q338SuccessorPhase = 'V172-Q338-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-NO-EVIDENCE-BLOCKED-GATE';
const q339SuccessorPhase = 'V172-Q339-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-ACTUAL-BUNDLE-PERMISSION-FINAL-CHECK';
const q340SuccessorPhase = 'V172-Q340-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-EVIDENCE-BLOCKED-GATE';
const q341SuccessorPhase = 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE';
const q342SuccessorPhase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const phase = 'V172-Q334-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED-GATE';
const sourcePhase = 'V172-Q333-NATIVE-PACKAGE-HASH-EVIDENCE-INTAKE-REAL-BUNDLE-PERMISSION-REVIEW';
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
assert([phase, 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE', 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE', 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE', q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q334 or successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE', 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE', 'V172-Q337-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-EXPLICIT-BUNDLE-APPROVAL-GATE', q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q334 or successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.actualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGateLatestPhase === phase, 'Q334 latest phase key missing');
assert(manifest.nativePackageHashEvidenceIntakeRealBundlePermissionReviewLatestPhase === sourcePhase, 'Q333 source latest phase key must remain recorded');
assert(manifest.v172Q333NativePackageHashEvidenceIntakeRealBundlePermissionReview, 'Q333 source envelope missing');
const q334 = manifest.v172Q334ActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedGate;
assert(q334 && q334.phase === phase, 'Q334 manifest envelope missing or wrong phase');
assert(q334.sourcePhase === sourcePhase, 'Q334 sourcePhase mismatch');
assert(q334.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q334 native channel mismatch');
assert(q334.actualBinaryBundlePlacementGateMethod === 'actualBinaryBundlePlacementGate', 'Q334 method missing');
assert(q334.actualBinaryBundlePlacementGateStatus === 'ACTUAL_BINARY_BUNDLE_PLACEMENT_BLOCKED_PENDING_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_AND_EXPLICIT_USER_APPROVAL_DEFAULT_OFF', 'Q334 status mismatch');
assert(q334.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q334 external evidence policy mismatch');
assert(q334.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q334 evidence file mismatch');
assert(Array.isArray(q334.requiredNativePackageFiles) && q334.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q334 required jar missing');
assert(q334.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q334 required arm64 library missing');
assert(q334.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q334 planned jar target missing');
assert(q334.plannedBundleTargets.includes('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'), 'Q334 planned arm64 target missing');
for (const [key, expected] of Object.entries({
  q315HashEvidenceProvidedToAssistant: true,
  q315Sha256MatchesExpected: true,
  q333NativePackageHashEvidenceIntakeReviewRecorded: true,
  mainActivityChanged: true,
  protectedMainActivityChangeDeclared: true,
  methodChannelBindingExtended: true,
  featureFlagDefaultEnabled: false,
  perFileSha256EvidenceProvidedToAssistant: false,
  nativePackageHashEvidenceReviewed: false,
  requiredNativePackageHashEvidenceAccepted: false,
  nativePackageHashEvidenceAccepted: false,
  explicitUserBinaryBundleApprovalProvided: false,
  binaryBundlePermissionGranted: false,
  binaryBundleApproved: false,
  actualBinaryBundlePlacementAttempted: false,
  actualBinaryBundleExecuted: false,
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
  assert(q334[key] === expected, `Q334 ${key} expected ${expected}, got ${q334[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q334Phase = "${phase}"`), 'MainActivity missing q334 phase constant');
assert(mainActivity.includes('private val q334ActualBinaryBundlePlacementGateFeatureEnabled = false'), 'MainActivity missing q334 default-off flag');
assert(mainActivity.includes('"actualBinaryBundlePlacementGate" -> result.success(q334ActualBinaryBundlePlacementGate(call.method))'), 'MainActivity missing q334 channel method binding');
assert(mainActivity.includes('private fun q334ActualBinaryBundlePlacementGate(method: String): Map<String, Any>'), 'MainActivity missing q334 method');
assert(mainActivity.includes('"actualBinaryBundlePlacementAttempted" to false'), 'Q334 bridge must keep actualBinaryBundlePlacementAttempted false');
assert(mainActivity.includes('"actualBinaryBundleExecuted" to false'), 'Q334 bridge must keep actualBinaryBundleExecuted false');
assert(mainActivity.includes('"nativeLibraryBundled" to false'), 'Q334 bridge must keep nativeLibraryBundled false');
assert(mainActivity.includes('"jarBundled" to false'), 'Q334 bridge must keep jarBundled false');
assert(mainActivity.includes('"systemLoadLibraryAdded" to false'), 'Q334 bridge must keep systemLoadLibraryAdded false');
for (const forbidden of ['System.loadLibrary', 'PaddlePredictor(', 'MobileConfig', 'PaddleOCR', 'OnnxRuntime', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q334 MainActivity must not include ${forbidden}`);
}

const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr', 'paddle_lite', 'onnxruntime', 'tflite_flutter']) {
  assert(!pubspec.includes(forbidden), `Q334 must not add pubspec dependency marker ${forbidden}`);
}
const androidFiles = exists('android/app') ? walk(path.join(projectRoot, 'android/app')) : [];
const forbiddenBinaries = androidFiles.filter((file) => ['.so', '.aar', '.jar'].some((suffix) => file.endsWith(suffix)));
assert(forbiddenBinaries.length === 0, `Q334 must not bundle native binaries: ${forbiddenBinaries.join(', ')}`);
assert(!exists('android/app/src/main/jniLibs'), 'Q334 must not create jniLibs directory');
assert(!exists('android/app/libs'), 'Q334 must not create android/app/libs directory');

for (const rel of [
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_gate_q334_policy.dart',
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_gate_q334.dart',
  'test/v172_q334_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_gate_test.dart',
  'docs/audit/V172_Q334_ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_PENDING_EVIDENCE_BLOCKED_GATE_AUDIT.md',
  'docs/audit/V172_Q334_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q334 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q334_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q334 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes('actualBinaryBundlePlacementGate'), 'Q334 changed-files doc must mention actualBinaryBundlePlacementGate');
console.log(JSON.stringify({
  phase,
  status: q334.actualBinaryBundlePlacementGateStatus,
  externalNativePackageEvidencePolicy: q334.externalNativePackageEvidencePolicy,
  perFileSha256EvidenceProvidedToAssistant: q334.perFileSha256EvidenceProvidedToAssistant,
  nativePackageHashEvidenceReviewed: q334.nativePackageHashEvidenceReviewed,
  nativePackageHashEvidenceAccepted: q334.nativePackageHashEvidenceAccepted,
  explicitUserBinaryBundleApprovalProvided: q334.explicitUserBinaryBundleApprovalProvided,
  actualBinaryBundlePlacementAttempted: q334.actualBinaryBundlePlacementAttempted,
  actualBinaryBundleExecuted: q334.actualBinaryBundleExecuted,
  nativeLibraryBundled: q334.nativeLibraryBundled,
  jarBundled: q334.jarBundled,
  jniLibsDirectoryCreated: q334.jniLibsDirectoryCreated,
  runtimeDependencyAdded: q334.runtimeDependencyAdded,
  realImageToLatexInferenceExecuted: q334.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q334.ocrPassClaimed,
}, null, 2));
