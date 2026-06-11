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

const phase = 'V172-Q371-CONTROLLED-OCR-ACTIVATION-RUNTIME-EVIDENCE-CAPTURE';
const sourcePhase = 'V172-Q370-CAMERA-OCR-FINAL-REAL-DEVICE-QA-RELEASE-CLOSURE';
const activeProductPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const expectedSha = '6d24333f86478d765fe6fa6fc3bd8061c52044433aafda18399f49cde3fe4d6a';
const expectedSize = 308743097;
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q371 = manifest.v172Q371ControlledOcrActivationRuntimeEvidenceCapture || {};
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const pubspec = read('pubspec.yaml');
const buildGradle = read('android/app/build.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

check(manifest.cameraOcrLatestPhase === activeProductPhase, 'Q371 must preserve Q363 as active camera OCR phase');
check(manifest.activeProductDevelopmentLatestPhase === activeProductPhase, 'Q371 must preserve Q363 as active product phase');
check(manifest.controlledOcrActivationRuntimeEvidenceCaptureLatestPhase === phase, 'Q371 latest key missing');
check(q371.phase === phase, 'Q371 manifest phase mismatch');
check(q371.sourcePhase === sourcePhase, 'Q371 source phase mismatch');
check(q371.activeProductGatePreservedPhase === activeProductPhase, 'Q371 active gate mismatch');
check(q371.status === 'CONTROLLED_OCR_ACTIVATION_RUNTIME_EVIDENCE_CAPTURE_EXPLICIT_INVOCATION_ONLY_NO_AUTO_IMPORT_NO_AUTO_SOLVE', 'Q371 status mismatch');
check(q371.bridgeChannel === 'mathpro/ocr_runtime_bridge', 'Q371 bridge channel mismatch');
check(q371.bridgeMethod === 'controlledOcrActivationRuntimeEvidenceCapture', 'Q371 bridge method mismatch');
check(q371.evidenceEnvelopeVersion === 'q371-controlled-ocr-activation-evidence-envelope-v1', 'Q371 evidence envelope mismatch');
check(q371.expectedOnnxModelFileName === 'pp_formulanet_s.onnx', 'Q371 expected filename mismatch');
check(q371.expectedOnnxModelSizeBytes === expectedSize, 'Q371 expected size mismatch');
check(q371.expectedOnnxModelSha256 === expectedSha, 'Q371 expected sha mismatch');

for (const key of [
  'controlledOcrActivationRuntimeEvidenceCapturePrepared',
  'explicitBridgeInvocationRequired',
  'requiresQ364PrivateStorageActivation',
  'requiresQ365ModelLoadSmoke',
  'requiresQ366DummyRuntimeCall',
  'requiresQ367ImageToLatexInference',
  'requiresQ368EditableMathLiveReview',
  'requiresQ369ApprovedWorkspaceImport',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'startupAutoExecutionBlocked',
  'cameraAutoExecutionBlocked',
  'workspaceAutoExecutionBlocked',
  'preservesQ363AsActiveProductPhase',
]) check(q371[key] === true, `Q371 must keep ${key} true`);

for (const key of [
  'workspaceImportExecuted',
  'approvedWorkspaceImportExecuted',
  'solveGraphSolutionHistoryTouched',
  'ocrPassClaimed',
  'modelPrivateStoragePassClaimedByPackage',
  'modelLoadPassClaimedByPackage',
  'dummyRuntimeCallPassClaimedByPackage',
  'imageToLatexPassClaimedByPackage',
  'ocrReviewPassClaimedByPackage',
  'workspaceImportPassClaimedByPackage',
  'androidPassClaimed',
  'storeReadyPassClaimed',
  'releaseReadyPassClaimed',
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
]) check(q371[key] === false, `Q371 must keep ${key} false`);

for (const rel of [
  'lib/features/camera/gauss_controlled_ocr_activation_runtime_evidence_capture_q371_policy.dart',
  'lib/features/camera/gauss_controlled_ocr_activation_runtime_evidence_capture_q371.dart',
  'test/v172_q371_controlled_ocr_activation_runtime_evidence_capture_test.dart',
  'tool/verify_controlled_ocr_activation_runtime_evidence_capture_v172_q371.mjs',
  'docs/audit/V172_Q371_CONTROLLED_OCR_ACTIVATION_RUNTIME_EVIDENCE_CAPTURE_AUDIT.md',
  'docs/audit/V172_Q371_CHANGED_FILES.md',
]) check(exists(rel), `Q371 expected file missing: ${rel}`);

check(mainActivity.includes('private val q371Phase = "V172-Q371-CONTROLLED-OCR-ACTIVATION-RUNTIME-EVIDENCE-CAPTURE"'), 'Q371 MainActivity phase constant missing');
check(mainActivity.includes('controlledOcrActivationRuntimeEvidenceCapture'), 'Q371 method channel case missing');
check(mainActivity.includes('q371ControlledOcrActivationRuntimeEvidenceCapture'), 'Q371 function missing');
for (const marker of [
  'q364OnnxModelArtifactPrivateStorageActivation("q371-private-storage-activation"',
  'q365OnnxRealModelLoadSmokeExecution("q371-model-load-smoke")',
  'q366OnnxDummyInputRuntimeCallExecution("q371-dummy-runtime-call")',
  'q367FirstRealImageToLatexInferenceExecution("q371-image-to-latex-inference"',
  'q368EditableMathLiveOcrReviewActivation(',
  'q369ApprovedOcrWorkspaceImportActivation(',
  'directOcrToWorkspaceImportBlocked" to true',
  'directOcrToSolveGraphSolutionHistoryBlocked" to true',
  'workspaceImportExecuted" to false',
  'solveGraphSolutionHistoryTouched" to false',
  'ocrPassClaimed" to false',
]) check(mainActivity.includes(marker), `Q371 MainActivity marker missing: ${marker}`);
check(!pubspec.includes('q371_dependency'), 'Q371 must not add pubspec dependencies');
check((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q371 must preserve exactly one ONNX Runtime dependency marker');
check(!androidManifest.includes('Q371'), 'Q371 must not mutate AndroidManifest');

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
check(forbiddenModels.length === 0, `Q371 must not bundle model artifacts: ${forbiddenModels.join(', ')}`);

if (process.exitCode) {
  console.error('Q371_CONTROLLED_OCR_ACTIVATION_RUNTIME_EVIDENCE_CAPTURE_FAILED');
  process.exit(process.exitCode);
}
console.log('Q371_CONTROLLED_OCR_ACTIVATION_RUNTIME_EVIDENCE_CAPTURE_PASS');
