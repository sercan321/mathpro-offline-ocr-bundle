#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q342-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR-PENDING-EVIDENCE-BLOCKED';
const status = 'ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_BLOCKED_PENDING_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_USER_APPROVAL_AND_CLEAN_FLUTTER_LOG_DEFAULT_OFF';
const method = 'actualBinaryBundlePendingEvidenceBlocked';
const q343SuccessorPhase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
const q344SuccessorPhase = 'V172-Q344-ACTUAL-BINARY-BUNDLE-JNILIBS-PADDLEPREDICTOR';
const q345SuccessorPhase = 'V172-Q345-GRADLE-ABI-PACKAGING-BUILD-TRIAL';
const q346SuccessorPhase = 'V172-Q346-NATIVE-LIBRARY-LOAD-SMOKE';
const q347SuccessorPhase = 'V172-Q347-PADDLE-LITE-PREDICTOR-INSTANTIATE-SMOKE';
const q348SuccessorPhase = 'V172-Q348-OPTIMIZED-MODEL-CONVERSION-MODEL-LOADER-EVIDENCE-GATE';
const q349SuccessorPhase = 'V172-Q349-REAL-MODEL-LOAD-SMOKE-EVIDENCE-BLOCKED';
const q350SuccessorPhase = 'V172-Q350-OPTIMIZED-MODEL-ARTIFACT-CONVERSION-EVIDENCE-INTAKE';
const q351SuccessorPhase = 'V172-Q351-OPTIMIZED-MODEL-EVIDENCE-ACCEPTANCE-REAL-MODEL-LOAD-UNLOCK-GATE';
const q351R1SuccessorPhase = 'V172-Q351R1-FLUTTER-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
const q351R2SuccessorPhase = 'V172-Q351R2-FLUTTER-RUN-KOTLIN-BUILD-HELPER-REPAIR';
const q352SuccessorPhase = 'V172-Q352-ONNX-CONVERSION-EVIDENCE-ACCEPTANCE-RUNTIME-STRATEGY-PIVOT-GATE';
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

const q344AllowedBinaryTargets = new Set([
  'android/app/libs/PaddlePredictor.jar',
  'android/app/src/main/jniLibs/arm64-v8a/libpaddle_lite_jni.so',
  'android/app/src/main/jniLibs/armeabi-v7a/libpaddle_lite_jni.so',
]);
function allowQ344OrLaterBundledBinaries() {
  return [q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase) ||
      [q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase);
}

function read(rel) { return fs.readFileSync(path.join(root, rel), 'utf8'); }
function exists(rel) { return fs.existsSync(path.join(root, rel)); }
function assert(condition, message) { if (!condition) { console.error(`[${phase}] ${message}`); process.exit(1); } }

const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
assert([phase, q343SuccessorPhase, q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `cameraOcrLatestPhase must be Q342 or accepted Q343/Q344/Q345/Q346 successor, got ${manifest.cameraOcrLatestPhase}`);
assert([phase, q343SuccessorPhase, q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `activeProductDevelopmentLatestPhase must be Q342 or accepted Q343/Q344/Q345/Q346 successor, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.actualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlockedLatestPhase === phase, 'Q342 latest key missing');
const q342 = manifest.v172Q342ActualBinaryBundleJniLibsPaddlePredictorPendingEvidenceBlocked;
assert(q342 && q342.phase === phase, 'Q342 manifest envelope missing');
assert(q342.sourcePhase === 'V172-Q341-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-BUNDLE-EVIDENCE-ACCEPTANCE', 'Q342 source phase mismatch');
assert(q342.method === method, 'Q342 method mismatch');
assert(q342.status === status, 'Q342 status mismatch');
assert(q342.bundlePermissionStatus.includes('BLOCKED_UNTIL_Q328_NATIVE_PACKAGE_HASH_EVIDENCE_JSON_IS_ACCEPTED'), 'Q342 bundle permission must remain blocked');
assert(q342.uiProtectionStatus.includes('UI_PROTECTED'), 'Q342 must declare UI protection');
assert(q342.actualBinaryBundleExecuted === false, 'Q342 must not execute actual binary bundle');
assert(q342.nativeLibraryBundled === false, 'Q342 must not bundle native library');
assert(q342.jarBundled === false, 'Q342 must not bundle jar');
assert(q342.jniLibsDirectoryCreated === false, 'Q342 must not create jniLibs');
assert(q342.androidAppLibsDirectoryCreated === false, 'Q342 must not create app libs');
assert(q342.gradleChanged === false, 'Q342 must not change Gradle');
assert(q342.pubspecChanged === false, 'Q342 must not change pubspec');
assert(q342.androidManifestChanged === false, 'Q342 must not change AndroidManifest');
assert(q342.workspaceChanged === false && q342.keyboardChanged === false && q342.mathLiveProductionBridgeChanged === false, 'Q342 must preserve UI red lines');
assert(q342.ocrPassClaimed === false, 'Q342 must not claim OCR pass');

const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
assert(mainActivity.includes(`private val q342Phase = "${phase}"`), 'MainActivity missing Q342 phase constant');
assert(mainActivity.includes('"actualBinaryBundlePendingEvidenceBlocked" -> result.success(q342ActualBinaryBundlePendingEvidenceBlocked(call.method))'), 'MainActivity missing Q342 method binding');
assert(mainActivity.includes('"q328NativePackageHashEvidenceJsonAccepted" to false'), 'Q342 bridge must keep q328 evidence accepted false');
assert(mainActivity.includes('"explicitUserBinaryBundleApprovalProvided" to false'), 'Q342 bridge must keep user approval false');
assert(mainActivity.includes('"q341OrNewerUserFlutterLogClean" to false'), 'Q342 bridge must keep user Flutter log clean false');
assert(mainActivity.includes('"actualBinaryBundleExecuted" to false'), 'Q342 bridge must keep actual bundle false');
assert(mainActivity.includes('"workspaceChanged" to false'), 'Q342 bridge must disclose workspace unchanged');
assert(mainActivity.includes('"keyboardChanged" to false'), 'Q342 bridge must disclose keyboard unchanged');
assert(mainActivity.includes('"mathLiveProductionBridgeChanged" to false'), 'Q342 bridge must disclose MathLive production bridge unchanged');
for (const forbidden of ['System.loadLibrary(', 'PaddlePredictor(', 'Predictor(', 'PaddleLite(']) {
  assert(!mainActivity.includes(forbidden), `Q342 MainActivity must not include ${forbidden}`);
}

const forbiddenBinaries = [];
function walk(dir) {
  if (!fs.existsSync(dir)) return;
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full);
    else if (/\.(so|aar|jar)$/i.test(entry.name)) forbiddenBinaries.push(path.relative(root, full).replaceAll(path.sep, '/'));
  }
}
walk(path.join(root, 'android', 'app'));
if (allowQ344OrLaterBundledBinaries()) {
  const unexpected = forbiddenBinaries.filter(rel => !q344AllowedBinaryTargets.has(rel));
  assert(unexpected.length === 0, `Q342 must allow only Q344-approved native binaries under Q344/Q345/Q346 successors: ${unexpected.join(', ')}`);
} else {
  assert(!exists('android/app/src/main/jniLibs'), 'Q342 must not create jniLibs directory');
  assert(!exists('android/app/libs'), 'Q342 must not create android/app/libs directory');
  assert(forbiddenBinaries.length === 0, `Q342 must not bundle native binaries: ${forbiddenBinaries.join(', ')}`);
}
for (const rel of [
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_q342_policy.dart',
  'lib/features/camera/gauss_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_q342.dart',
  'test/v172_q342_actual_binary_bundle_jnilibs_paddlepredictor_pending_evidence_blocked_test.dart',
  'docs/audit/V172_Q342_ACTUAL_BINARY_BUNDLE_JNILIBS_PADDLEPREDICTOR_PENDING_EVIDENCE_BLOCKED_AUDIT.md',
  'docs/audit/V172_Q342_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q342 expected file missing: ${rel}`);
}
const changed = read('docs/audit/V172_Q342_CHANGED_FILES.md');
assert(changed.includes('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt'), 'Q342 changed-files doc must disclose protected MainActivity modification');
assert(changed.includes(method), 'Q342 changed-files doc must mention bridge method');
assert(changed.includes('No workspace/keyboard/MORE/long-press/MathLive/Graph/Solution/History/splash/icon files were modified'), 'Q342 changed-files doc must disclose UI red-line preservation');
console.log(JSON.stringify({ phase, status: q342.status, uiProtected: q342.uiProtectionStatus, ok: true }, null, 2));
