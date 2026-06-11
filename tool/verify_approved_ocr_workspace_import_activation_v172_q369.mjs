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

const phase = 'V172-Q369-APPROVED-OCR-WORKSPACE-IMPORT-ACTIVATION';
const sourcePhase = 'V172-Q368-EDITABLE-MATHLIVE-OCR-REVIEW-ACTIVATION';
const activeProductPhase = 'V172-Q363-STORE-PRIVACY-FINAL-RELEASE-GATE';
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const q369 = manifest.v172Q369ApprovedOcrWorkspaceImportActivation || {};
const mainActivity = read('android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt');
const pubspec = read('pubspec.yaml');
const buildGradle = read('android/app/build.gradle');
const androidManifest = read('android/app/src/main/AndroidManifest.xml');

check(manifest.cameraOcrLatestPhase === activeProductPhase, 'Q369 must preserve Q363 as active camera OCR phase');
check(manifest.activeProductDevelopmentLatestPhase === activeProductPhase, 'Q369 must preserve Q363 as active product phase');
check(manifest.approvedOcrWorkspaceImportActivationLatestPhase === phase, 'Q369 latest key missing');
check(q369.phase === phase, 'Q369 manifest phase mismatch');
check(q369.sourcePhase === sourcePhase, 'Q369 source phase mismatch');
check(q369.activeProductGatePreservedPhase === activeProductPhase, 'Q369 active gate mismatch');
check(q369.bridgeChannel === 'mathpro/ocr_runtime_bridge', 'Q369 bridge channel mismatch');
check(q369.bridgeMethod === 'approvedOcrWorkspaceImportActivation', 'Q369 bridge method mismatch');

for (const key of [
  'approvedWorkspaceImportActivationPrepared',
  'explicitBridgeInvocationRequired',
  'requiresQ368EditableReviewHandoff',
  'requiresEditableMathLiveReviewBeforeImport',
  'requiresExplicitUserApprovalBeforeWorkspaceImport',
  'requiresNonEmptyApprovedLatex',
  'directOcrToWorkspaceImportBlocked',
  'directOcrToSolveGraphSolutionHistoryBlocked',
  'mathLiveProductionRoutePreserved',
  'preservesQ363AsActiveProductPhase',
]) check(q369[key] === true, `Q369 must keep ${key} true`);

for (const key of [
  'workspaceImportAutoExecuted',
  'workspaceImportExecuted',
  'approvedWorkspaceImportExecuted',
  'solveGraphSolutionHistoryTouched',
  'reviewUiAutoOpened',
  'ocrPassClaimed',
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
]) check(q369[key] === false, `Q369 must keep ${key} false`);

for (const rel of [
  'lib/features/camera/gauss_approved_ocr_workspace_import_activation_q369_policy.dart',
  'lib/features/camera/gauss_approved_ocr_workspace_import_activation_q369.dart',
  'test/v172_q369_approved_ocr_workspace_import_activation_test.dart',
  'tool/verify_approved_ocr_workspace_import_activation_v172_q369.mjs',
  'docs/audit/V172_Q369_APPROVED_OCR_WORKSPACE_IMPORT_ACTIVATION_AUDIT.md',
  'docs/audit/V172_Q369_CHANGED_FILES.md',
]) check(exists(rel), `Q369 expected file missing: ${rel}`);

check(mainActivity.includes('private val q369Phase = "V172-Q369-APPROVED-OCR-WORKSPACE-IMPORT-ACTIVATION"'), 'Q369 MainActivity phase constant missing');
check(mainActivity.includes('approvedOcrWorkspaceImportActivation'), 'Q369 method channel case missing');
check(mainActivity.includes('q369ApprovedOcrWorkspaceImportActivation'), 'Q369 function missing');
check(mainActivity.includes('requiresQ368EditableReviewHandoff" to true'), 'Q369 must require Q368 review handoff');
check(mainActivity.includes('requiresExplicitUserApprovalBeforeWorkspaceImport" to true'), 'Q369 approval guard missing');
check(mainActivity.includes('workspaceImportAutoExecuted" to false'), 'Q369 must not auto import workspace');
check(mainActivity.includes('workspaceImportExecuted" to false'), 'Q369 must not mutate workspace');
check(mainActivity.includes('solveGraphSolutionHistoryTouched" to false'), 'Q369 must not touch solve/graph/solution/history');
check(mainActivity.includes('ocrPassClaimed" to false'), 'Q369 must not claim OCR pass');
check(!pubspec.includes('workspace_import_route_dependency'), 'Q369 must not add workspace import dependency to pubspec');
check((buildGradle.match(/onnxruntime-android/g) || []).length === 1, 'Q369 must preserve exactly one ONNX Runtime dependency marker');
check(!androidManifest.includes('Q369'), 'Q369 must not mutate AndroidManifest');

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
check(forbiddenModels.length === 0, `Q369 must not bundle model artifacts: ${forbiddenModels.join(', ')}`);

if (process.exitCode) {
  console.error('Q369_APPROVED_OCR_WORKSPACE_IMPORT_ACTIVATION_FAILED');
  process.exit(process.exitCode);
}
console.log('Q369_APPROVED_OCR_WORKSPACE_IMPORT_ACTIVATION_PASS');
