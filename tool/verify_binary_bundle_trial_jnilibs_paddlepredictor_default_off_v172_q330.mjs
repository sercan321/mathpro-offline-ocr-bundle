#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const phase = 'V172-Q330-BINARY-BUNDLE-TRIAL-JNILIBS-PADDLEPREDICTOR-DEFAULT-OFF';
const sourcePhase = 'V172-Q329-NATIVE-PACKAGE-HASH-EVIDENCE-REVIEW-BINARY-BUNDLE-APPROVAL-GATE';
const q331SuccessorPhase = 'V172-Q331-NATIVE-PACKAGE-HASH-EVIDENCE-ACCEPTANCE-BUNDLE-PERMISSION-GATE';
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
assert([phase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q330 or Q331 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q331SuccessorPhase, q332SuccessorPhase, q333SuccessorPhase, q334SuccessorPhase, q335SuccessorPhase, q336SuccessorPhase, q337SuccessorPhase, q338SuccessorPhase, q339SuccessorPhase, q340SuccessorPhase, q341SuccessorPhase, q342SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q330 or Q331 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.binaryBundleTrialJniLibsPaddlePredictorDefaultOffLatestPhase === phase, 'Q330 latest phase key missing');
assert(manifest.cameraOcrLatestPhase !== q331SuccessorPhase || manifest.v172Q331NativePackageHashEvidenceAcceptanceBundlePermissionGate, 'Q331 successor envelope missing');
assert(manifest.nativePackageHashEvidenceReviewBinaryBundleApprovalGateLatestPhase === sourcePhase, 'Q329 source latest phase key must remain recorded');
assert(manifest.v172Q329NativePackageHashEvidenceReviewBinaryBundleApprovalGate, 'Q329 source envelope missing');
const q330 = manifest.v172Q330BinaryBundleTrialJniLibsPaddlePredictorDefaultOff;
assert(q330 && q330.phase === phase, 'Q330 manifest envelope missing or wrong phase');
assert(q330.sourcePhase === sourcePhase, 'Q330 sourcePhase mismatch');
assert(q330.nativeChannelName === 'mathpro/ocr_runtime_bridge', 'Q330 native channel mismatch');
assert(q330.binaryBundleTrialMethod === 'binaryBundleTrialDefaultOff', 'Q330 method missing');
assert(q330.binaryBundleTrialStatus === 'BINARY_BUNDLE_TRIAL_BLOCKED_PENDING_NATIVE_PACKAGE_HASH_EVIDENCE_AND_USER_APPROVAL_DEFAULT_OFF', 'Q330 status mismatch');
assert(q330.externalNativePackageEvidencePolicy === '../MathProOcrNativePackages/Paddle_Lite_Android', 'Q330 external evidence policy mismatch');
assert(q330.nativePackageEvidenceFileName === 'q328_native_library_package_hash_evidence.json', 'Q330 evidence file mismatch');
assert(Array.isArray(q330.requiredNativePackageFiles) && q330.requiredNativePackageFiles.includes('PaddlePredictor.jar'), 'Q330 required jar missing');
assert(q330.requiredNativePackageFiles.includes('arm64-v8a/libpaddle_lite_jni.so'), 'Q330 required arm64 library missing');
assert(q330.plannedBundleTargets.includes('android/app/libs/PaddlePredictor.jar'), 'Q330 planned jar target missing');
assert(q330.plannedBundleTargets.includes('android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so'), 'Q330 planned arm64 target missing');
for (const [key, expected] of Object.entries({
  q315HashEvidenceProvidedToAssistant: true,
  q315Sha256MatchesExpected: true,
  q329NativePackageHashEvidenceReviewRecorded: true,
  binaryBundleTrialMethodAdded: true,
  mainActivityChanged: true,
  protectedMainActivityChangeDeclared: true,
  methodChannelBindingExtended: true,
  featureFlagDefaultEnabled: false,
  perFileSha256EvidenceProvidedToAssistant: false,
  nativePackageHashEvidenceAccepted: false,
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
  abiPackagingTrialExecuted: false,
  buildTrialExecuted: false,
  buildTrialPassed: false,
  modelConversionExecuted: false,
  nativeModelLoaderAdded: false,
  modelLoaderAvailable: false,
  modelArtifactAcceptedForRuntime: false,
  runtimeStartupExecuted: false,
  dummyRuntimeCallExecuted: false,
  realImageToLatexInferenceExecuted: false,
  editableMathLiveReviewOpened: false,
  workspaceImportExecuted: false,
  ocrPassClaimed: false,
  androidRealDevicePassClaimed: false,
  storeReadyPassClaimed: false,
  releasePassClaimed: false,
})) {
  assert(q330[key] === expected, `Q330 ${key} expected ${expected}, got ${q330[key]}`);
}

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q330Phase = "${phase}"`), 'MainActivity missing Q330 phase constant');
assert(mainActivity.includes('private val q330BinaryBundleTrialFeatureEnabled = false'), 'MainActivity missing Q330 feature flag');
assert(mainActivity.includes('"binaryBundleTrialDefaultOff" -> result.success(q330BinaryBundleTrialDefaultOff(call.method))'), 'MainActivity missing Q330 method channel binding');
assert(mainActivity.includes('private fun q330BinaryBundleTrialDefaultOff(method: String): Map<String, Any>'), 'MainActivity missing Q330 method implementation');
assert(mainActivity.includes('"binaryBundleApproved" to false'), 'Q330 bridge must keep binary bundle approval false');
assert(mainActivity.includes('"systemLoadLibraryAdded" to false'), 'Q330 bridge must not add System.loadLibrary');
for (const forbidden of ['System.loadLibrary', 'PaddlePredictor(', 'MobileConfig', 'PaddleOCR', 'OnnxRuntime', 'loadModel(', 'runInference(']) {
  assert(!mainActivity.includes(forbidden), `Q330 must not introduce runtime marker ${forbidden}`);
}
const pubspec = read('pubspec.yaml').toLowerCase();
for (const forbidden of ['paddleocr', 'paddle_lite', 'onnxruntime', 'tflite_flutter']) {
  assert(!pubspec.includes(forbidden), `Q330 must not mutate pubspec with ${forbidden}`);
}
for (const rel of ['android/app/src/main/jniLibs', 'android/app/libs']) {
  assert(!exists(rel), `Q330 must not create binary bundle directory ${rel}`);
}
for (const file of walk(path.join(projectRoot, 'android/app'))) {
  assert(!file.endsWith('.so') && !file.endsWith('.aar') && !file.endsWith('.jar'), `Q330 must not bundle native binary package artifact: ${file}`);
}
const changed = read('docs/audit/V172_Q330_CHANGED_FILES.md');
assert(changed.includes('Protected Runtime File Intentionally Modified'), 'Q330 changed-files doc must declare protected MainActivity modification');
assert(changed.includes('binaryBundleTrialDefaultOff'), 'Q330 changed-files doc must mention binaryBundleTrialDefaultOff');
console.log(JSON.stringify({
  phase,
  status: q330.binaryBundleTrialStatus,
  externalNativePackageEvidencePolicy: q330.externalNativePackageEvidencePolicy,
  perFileSha256EvidenceProvidedToAssistant: q330.perFileSha256EvidenceProvidedToAssistant,
  binaryBundleApproved: q330.binaryBundleApproved,
  nativeLibraryBundled: q330.nativeLibraryBundled,
  jarBundled: q330.jarBundled,
  jniLibsDirectoryCreated: q330.jniLibsDirectoryCreated,
  runtimeDependencyAdded: q330.runtimeDependencyAdded,
  realImageToLatexInferenceExecuted: q330.realImageToLatexInferenceExecuted,
  ocrPassClaimed: q330.ocrPassClaimed,
}, null, 2));
