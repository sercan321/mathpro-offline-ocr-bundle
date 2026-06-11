#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (rel) => fs.readFileSync(path.join(root, rel), 'utf8');
const exists = (rel) => fs.existsSync(path.join(root, rel));
const check = (condition, message) => {
  if (!condition) {
    console.error(message);
    process.exitCode = 1;
  }
};

const phase = 'V172-Q372-CONTROLLED-OCR-ACTIVATION-FLUTTER-EVIDENCE-HARNESS';
const sourcePhase = 'V172-Q371-CONTROLLED-OCR-ACTIVATION-RUNTIME-EVIDENCE-CAPTURE';
const activeProductPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const expectedSha = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const expectedSize = 308743097;
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q372 = manifest.v172Q372ControlledOcrActivationFlutterEvidenceHarness || {};
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const pubspec = read('pubspec.yaml');
const buildGradle = read('android/app/build.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');
const dartHarness = read('lib/features/camera/gauss_controlled_ocr_activation_flutter_evidence_harness_q372.dart');
const dartPolicy = read('lib/features/camera/gauss_controlled_ocr_activation_flutter_evidence_harness_q372_policy.dart');

check(manifest.cameraOcrLatestPhase === activeProductPhase, 'Q372 must preserve Q363 as active camera OCR phase');
check(manifest.activeProductDevelopmentLatestPhase === activeProductPhase, 'Q372 must preserve Q363 as active product phase');
check(manifest.controlledOcrActivationRuntimeEvidenceCaptureLatestPhase === sourcePhase, 'Q372 must preserve Q371 metadata');
check(manifest.controlledOcrActivationFlutterEvidenceHarnessLatestPhase === phase, 'Q372 latest key missing');
check(q372.phase === phase, 'Q372 manifest phase mismatch');
check(q372.sourcePhase === sourcePhase, 'Q372 source phase mismatch');
check(q372.activeProductGatePreservedPhase === activeProductPhase, 'Q372 active gate mismatch');
check(q372.status === 'CONTROLLED_OCR_ACTIVATION_FLUTTER_EVIDENCE_HARNESS_EXPLICIT_ONLY_NO_AUTO_CAMERA_NO_AUTO_IMPORT_NO_AUTO_SOLVE', 'Q372 status mismatch');
check(q372.bridgeChannel === 'mathpro/ocr_runtime_bridge', 'Q372 bridge channel mismatch');
check(q372.nativeBridgeMethod === 'controlledOcrActivationRuntimeEvidenceCapture', 'Q372 native bridge method mismatch');
check(q372.harnessVersion === 'q372-controlled-ocr-activation-flutter-evidence-harness-v1', 'Q372 harness version mismatch');
check(q372.expectedOnnxModelFileName === 'pp_formulanet_s.onnx', 'Q372 expected filename mismatch');
check(q372.expectedOnnxModelSizeBytes === expectedSize, 'Q372 expected size mismatch');
check(q372.expectedOnnxModelSha256 === expectedSha, 'Q372 expected sha mismatch');

for (const key of [
  'flutterHarnessPrepared',
  'explicitUserInvocationRequired',
  'requiresQ371NativeEvidenceCapture',
  'canRequestQ364PrivateStorageActivation',
  'canRequestQ365ModelLoadSmoke',
  'canRequestQ366DummyRuntimeCall',
  'canRequestQ367ImageToLatexInference',
  'canRequestQ368EditableMathLiveReview',
  'canRequestQ369ApprovedWorkspaceImport',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'startupAutoExecutionBlocked',
  'cameraAutoExecutionBlocked',
  'workspaceAutoExecutionBlocked',
  'preservesQ363AsActiveProductPhase',
]) check(q372[key] === true, `Q372 must keep ${key} true`);

for (const key of [
  'workspaceImportExecuted',
  'approvedWorkspaceImportExecuted',
  'solveGraphSolutionHistoryTouched',
  'ocrPassClaimed',
  'androidPassClaimed',
  'storeReadyPassClaimed',
  'releaseReadyPassClaimed',
  'mainActivityChanged',
  'pubspecChanged',
  'gradleChanged',
  'androidManifestChanged',
  'keyboardChanged',
  'moreTemplateTrayChanged',
  'longPressChanged',
  'mathLiveProductionBridgeChanged',
  'workspaceChanged',
  'graphChanged',
  'solutionChanged',
  'historyChanged',
  'splashChanged',
  'iconChanged',
]) check(q372[key] === false, `Q372 must keep ${key} false`);

for (const rel of [
  'lib/features/camera/gauss_controlled_ocr_activation_flutter_evidence_harness_q372_policy.dart',
  'lib/features/camera/gauss_controlled_ocr_activation_flutter_evidence_harness_q372.dart',
  'test/v172_q372_controlled_ocr_activation_flutter_evidence_harness_test.dart',
  'tool/verify_controlled_ocr_activation_flutter_evidence_harness_v172_q372.mjs',
  'docs/audit/V172_Q372_CONTROLLED_OCR_ACTIVATION_FLUTTER_EVIDENCE_HARNESS_AUDIT.md',
  'docs/audit/V172_Q372_CHANGED_FILES.md',
]) check(exists(rel), `Q372 expected file missing: ${rel}`);

check(dartHarness.includes('MethodChannel'), 'Q372 Dart harness must use MethodChannel');
check(dartPolicy.includes("nativeBridgeMethod = 'controlledOcrActivationRuntimeEvidenceCapture'"), 'Q372 Dart policy must target Q371 native bridge');
check(dartHarness.includes('executePrivateStorageActivation'), 'Q372 must expose private-storage activation flag');
check(dartHarness.includes('executeModelLoadSmoke'), 'Q372 must expose model-load flag');
check(dartHarness.includes('executeDummyRuntimeCall'), 'Q372 must expose dummy-call flag');
check(dartHarness.includes('executeImageToLatex'), 'Q372 must expose image-to-LaTeX flag');
check(dartHarness.includes('explicitUserApproval'), 'Q372 must pass explicit user approval alias');
check(!mainActivity.includes('q372Phase'), 'Q372 must not mutate MainActivity');
check(!mainActivity.includes('controlledOcrActivationFlutterEvidenceHarness'), 'Q372 must not add native Q372 bridge');
check((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q372 must preserve exactly one ONNX Runtime dependency marker');
check(!pubspec.includes('q372_dependency'), 'Q372 must not add pubspec dependencies');
check(!androidManifest.includes('Q372'), 'Q372 must not mutate AndroidManifest');

const forbiddenModels = [];
const scan = (dir) => {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    const abs = path.join(dir, entry.name);
    const rel = path.relative(root, abs).replaceAll('\\', '/');
    if (rel.startsWith('build/') || rel.includes('/build/')) continue;
    if (entry.isDirectory()) scan(abs);
    else if (/\.(onnx|nb|pdmodel|pdiparams|tflite)$/i.test(entry.name)) forbiddenModels.push(rel);
  }
};
scan(root);
check(forbiddenModels.length === 0, `Q372 must not bundle model artifacts: ${forbiddenModels.join(', ')}`);

if (process.exitCode) {
  console.error('Q372_CONTROLLED_OCR_ACTIVATION_FLUTTER_EVIDENCE_HARNESS_FAILED');
  process.exit(process.exitCode);
}
console.log('Q372_CONTROLLED_OCR_ACTIVATION_FLUTTER_EVIDENCE_HARNESS_PASS');
