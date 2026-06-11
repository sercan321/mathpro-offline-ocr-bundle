#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const root = path.resolve(__dirname, '..');
const phase = 'V172-Q343R2-FLUTTER-ANALYZE-TEST-SYNTAX-HYGIENE-REPAIR';
const sourcePhase = 'V172-Q343R1-FLUTTER-ANALYZE-TEST-SUCCESSOR-AWARE-HYGIENE-REPAIR';
const q343Phase = 'V172-Q343-NATIVE-PACKAGE-HASH-EVIDENCE-FINAL-ACCEPTANCE-REAL-BUNDLE-UNLOCK-GATE';
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
assert([q343Phase, q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.cameraOcrLatestPhase), `Q343R2 must preserve Q343 or accept later Q344/Q345/Q346 successor phase, got ${manifest.cameraOcrLatestPhase}`);
assert([q343Phase, q344SuccessorPhase, q345SuccessorPhase, q346SuccessorPhase, q347SuccessorPhase, q348SuccessorPhase, q349SuccessorPhase, q350SuccessorPhase, q351SuccessorPhase, q351R1SuccessorPhase, q351R2SuccessorPhase, q352SuccessorPhase, q353SuccessorPhase, q354SuccessorPhase, q355SuccessorPhase, q356SuccessorPhase, q356r1SuccessorPhase, q356r2SuccessorPhase, q357SuccessorPhase, q358SuccessorPhase, q359SuccessorPhase, q360SuccessorPhase, q361SuccessorPhase, q362SuccessorPhase, q363SuccessorPhase].includes(manifest.activeProductDevelopmentLatestPhase), `Q343R2 must preserve Q343 or accept later Q344/Q345/Q346 product phase, got ${manifest.activeProductDevelopmentLatestPhase}`);
assert(manifest.q343R1FlutterAnalyzeTestSyntaxHygieneRepairLatestPhase === phase, 'Q343R2 latest repair key missing');
const q343r2 = manifest.v172Q343R2FlutterAnalyzeTestSyntaxHygieneRepair;
assert(q343r2 && q343r2.phase === phase, 'Q343R2 manifest envelope missing');
assert(q343r2.sourcePhase === sourcePhase, 'Q343R2 source phase mismatch');
assert(q343r2.cameraOcrLatestPhaseAdvanced === false, 'Q343R2 must not advance cameraOcrLatestPhase beyond Q343');
assert(q343r2.q315R1AndQ316MalformedLeadingCommaEntriesRepaired === true, 'Q343R2 must record Q315R1/Q316 malformed comma repair');
for (const key of [
  'mainActivityChanged',
  'binaryBundleExecuted',
  'nativeLibraryBundled',
  'jarBundled',
  'jniLibsDirectoryCreated',
  'androidAppLibsDirectoryCreated',
  'gradleChanged',
  'pubspecChanged',
  'androidManifestChanged',
  'workspaceChanged',
  'keyboardChanged',
  'moreTemplateTrayChanged',
  'longPressChanged',
  'mathLiveProductionBridgeChanged',
  'graphChanged',
  'solutionChanged',
  'historyChanged',
  'splashChanged',
  'iconChanged',
  'uiRuntimeChanged',
  'systemLoadLibraryAdded',
  'paddleLiteInstantiated',
  'modelLoaderAvailable',
  'runtimeStartupExecuted',
  'dummyRuntimeCallExecuted',
  'realImageToLatexInferenceExecuted',
  'ocrReviewUiAdded',
  'workspaceImportAdded',
  'ocrPassClaimed',
  'androidRealDevicePassClaimed',
]) {
  assert(q343r2[key] === false, `Q343R2 must keep ${key} false`);
}

const repairedTests = [
  'test/v172_q315r1_controlled_model_artifact_download_hash_capture_flutter_test_repair_test.dart',
  'test/v172_q316_runtime_dependency_feasibility_trial_default_off_test.dart',
];
for (const rel of repairedTests) {
  const text = read(rel);
  assert(text.includes(`const String q343SuccessorPhase = '${q343Phase}';`), `${rel} must define q343SuccessorPhase`);
  assert(text.includes('q343SuccessorPhase,'), `${rel} must use q343SuccessorPhase inside successor lists`);
  assert(!text.includes(`\n    , '${q343Phase}']`), `${rel} must not contain malformed leading-comma Q343 successor list entry`);
  assert(!text.includes(`\n    , 'V172-Q343`), `${rel} must not contain any malformed leading-comma Q343 entry`);
}

const allTests = [];
function walkTests(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walkTests(full);
    else if (entry.name.endsWith('.dart')) allTests.push(full);
  }
}
walkTests(path.join(root, 'test'));
for (const full of allTests) {
  const text = fs.readFileSync(full, 'utf8');
  const rel = path.relative(root, full).replaceAll(path.sep, '/');
  assert(!/^\s*,\s*'V172-Q343/m.test(text), `${rel} contains malformed leading comma before Q343 string`);
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
  assert(unexpected.length === 0, `Q343R2 must allow only Q344-approved native binaries under Q344/Q345/Q346 successors: ${unexpected.join(', ')}`);
} else {
  assert(!exists('android/app/src/main/jniLibs'), 'Q343R2 must not create jniLibs directory');
  assert(!exists('android/app/libs'), 'Q343R2 must not create android/app/libs directory');
  assert(forbiddenBinaries.length === 0, `Q343R2 must not bundle native binaries: ${forbiddenBinaries.join(', ')}`);
}
for (const rel of [
  'lib/features/camera/gauss_q343r1_flutter_analyze_test_syntax_hygiene_repair_policy.dart',
  'lib/features/camera/gauss_q343r1_flutter_analyze_test_syntax_hygiene_repair.dart',
  'test/v172_q343r2_flutter_analyze_test_syntax_hygiene_repair_test.dart',
  'docs/audit/V172_Q343R2_FLUTTER_ANALYZE_TEST_SYNTAX_HYGIENE_REPAIR_AUDIT.md',
  'docs/audit/V172_Q343R2_CHANGED_FILES.md',
]) {
  assert(exists(rel), `Q343R2 expected file missing: ${rel}`);
}
console.log(JSON.stringify({ phase, sourcePhase, preservedCameraOcrLatestPhase: manifest.cameraOcrLatestPhase, syntaxRepair: true, ok: true }, null, 2));
