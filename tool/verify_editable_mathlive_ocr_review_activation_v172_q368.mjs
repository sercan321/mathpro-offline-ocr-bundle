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

const phase = 'V172-Q368-EDITABLE-MATHLIVE-OCR-REVIEW-ACTIVATION';
const sourcePhase = 'V172-Q367-FIRST-REAL-IMAGE-TO-LATEX-INFERENCE';
const activeProductPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q368 = manifest.v172Q368EditableMathLiveOcrReviewActivation || {};
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const pubspec = read('pubspec.yaml');
const buildGradle = read('android/app/build.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

check(manifest.cameraOcrLatestPhase === activeProductPhase, 'Q368 must preserve Q363 as active camera OCR phase');
check(manifest.activeProductDevelopmentLatestPhase === activeProductPhase, 'Q368 must preserve Q363 as active product phase');
check(manifest.editableMathLiveOcrReviewActivationLatestPhase === phase, 'Q368 latest key missing');
check(q368.phase === phase, 'Q368 manifest phase mismatch');
check(q368.sourcePhase === sourcePhase, 'Q368 source phase mismatch');
check(q368.activeProductGatePreservedPhase === activeProductPhase, 'Q368 active gate mismatch');
check(q368.bridgeChannel === 'mathpro/ocr_runtime_bridge', 'Q368 bridge channel mismatch');
check(q368.bridgeMethod === 'editableMathLiveOcrReviewActivation', 'Q368 bridge method mismatch');

for (const key of [
  'editableMathLiveReviewActivationPrepared',
  'explicitBridgeInvocationRequired',
  'requiresQ367CandidateEnvelope',
  'requiresNonEmptyCandidateLatex',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'mathLiveProductionRoutePreserved',
  'preservesQ363AsActiveProductPhase',
]) check(q368[key] === true, `Q368 must keep ${key} true`);

for (const key of [
  'reviewUiAutoOpened',
  'workspaceImportExecuted',
  'approvedWorkspaceImportExecuted',
  'solveGraphSolutionHistoryTouched',
  'ocrPassClaimed',
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
]) check(q368[key] === false, `Q368 must keep ${key} false`);

for (const rel of [
  'lib/features/camera/gauss_editable_mathlive_ocr_review_activation_q368_policy.dart',
  'lib/features/camera/gauss_editable_mathlive_ocr_review_activation_q368.dart',
  'test/v172_q368_editable_mathlive_ocr_review_activation_test.dart',
  'tool/verify_editable_mathlive_ocr_review_activation_v172_q368.mjs',
  'docs/audit/V172_Q368_EDITABLE_MATHLIVE_OCR_REVIEW_ACTIVATION_AUDIT.md',
  'docs/audit/V172_Q368_CHANGED_FILES.md',
]) check(exists(rel), `Q368 expected file missing: ${rel}`);

check(mainActivity.includes('private val q368Phase = "V172-Q368-EDITABLE-MATHLIVE-OCR-REVIEW-ACTIVATION"'), 'Q368 MainActivity phase constant missing');
check(mainActivity.includes('editableMathLiveOcrReviewActivation'), 'Q368 method channel case missing');
check(mainActivity.includes('q368EditableMathLiveOcrReviewActivation'), 'Q368 function missing');
check(mainActivity.includes('requiresNonEmptyCandidateLatex" to true'), 'Q368 must require non-empty candidate latex');
check(mainActivity.includes('requiresExplicitUserApprovalBeforeWorkspaceImport" to true'), 'Q368 approval guard missing');
check(mainActivity.includes('workspaceImportExecuted" to false'), 'Q368 must not import workspace');
check(mainActivity.includes('solveGraphSolutionHistoryTouched" to false'), 'Q368 must not touch solve/graph/solution/history');
check(mainActivity.includes('ocrPassClaimed" to false'), 'Q368 must not claim OCR pass');
check(!pubspec.includes('ocr_review_route_dependency'), 'Q368 must not add review dependency to pubspec');
check((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q368 must preserve exactly one ONNX Runtime dependency marker');
check(!androidManifest.includes('Q368'), 'Q368 must not mutate AndroidManifest');

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
check(forbiddenModels.length === 0, `Q368 must not bundle model artifacts: ${forbiddenModels.join(', ')}`);

if (process.exitCode) {
  console.error('Q368_EDITABLE_MATHLIVE_OCR_REVIEW_ACTIVATION_FAILED');
  process.exit(process.exitCode);
}
console.log('Q368_EDITABLE_MATHLIVE_OCR_REVIEW_ACTIVATION_PASS');
