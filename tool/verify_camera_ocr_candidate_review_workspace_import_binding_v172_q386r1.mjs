#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_camera_ocr_candidate_review_workspace_import_binding_v172_q386r1: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policyPath = 'lib/features/camera/gauss_camera_ocr_candidate_review_workspace_import_binding_q386r1.dart';
const testPath = 'test/v172_q386r1_camera_ocr_candidate_review_workspace_import_binding_test.dart';
const auditPath = 'docs/audit/V172_Q386R1_OCR_CANDIDATE_REVIEW_WORKSPACE_IMPORT_BINDING.md';
const changedPath = 'docs/audit/V172_Q386R1_CHANGED_FILES.md';
for (const required of [policyPath, testPath, auditPath, changedPath]) check(exists(required), `missing Q386R1 file: ${required}`);

const policy = read(policyPath);
const test = read(testPath);
const review = read('lib/features/camera/gauss_mathlive_ocr_review_surface.dart');
const appShell = read('lib/app/app_shell.dart');
const buildGradle = read('android/app/build.gradle');
const pubspec = read('pubspec.yaml');
const manifest = JSON.parse(read('assets/mathlive/manifest.json'));
const audit = read(auditPath);
const changed = read(changedPath);

for (const marker of [
  'V172-Q386R1-OCR-CANDIDATE-REVIEW-WORKSPACE-IMPORT-BINDING',
  "sourcePhase = 'V172-Q386-REAL-PADDLE-OCR-INFERENCE-BRIDGE'",
  'requiresRealDecodedCandidate = true',
  'requiresEditableReviewDraft = true',
  'requiresNonEmptyReviewedLatex = true',
  'requiresExplicitUserApproval = true',
  'requiresWorkspaceImportCallback = true',
  'importButtonDisabledUntilReady = true',
  'directCameraToWorkspaceImportBlocked = true',
  'autoEvaluateBlocked = true',
  'autoGraphBlocked = true',
  'autoSolutionHistoryBlocked = true',
  'fakeOcrCandidateAllowed = false',
  'workspaceImportPassClaimedByQ386R1 = false',
  'ocrPassClaimedByQ386R1 = false',
  'keyboardQ382Touched = false',
]) check(policy.includes(marker), `Q386R1 policy marker missing: ${marker}`);

for (const marker of [
  "import 'gauss_camera_ocr_candidate_review_workspace_import_binding_q386r1.dart';",
  '_reviewTextHasContent',
  '_reviewController.addListener(_handleReviewTextChanged)',
  'GaussQ386R1WorkspaceImportGate.evaluate',
  'widget.onApprovedLatexImport != null',
  '_q386r1WorkspaceImportGate.canSubmit',
  'Future<void> Function() onQueueModel',
  'semanticsLabel: downloadActionSemantics',
]) check(review.includes(marker), `review surface Q386R1 marker missing: ${marker}`);

for (const marker of [
  '_handleApprovedOcrWorkspaceImport',
  'q378-approved-ocr-workspace-import',
  'setLatexFromApprovedOcrImport',
  '_flushQ382R31ResultSolutionIdlePipelineForExplicitAction',
  '_stepsPanelState = SolutionStepsPanelState.closed',
  '_graphPreviewVisible = false',
]) check(appShell.includes(marker), `AppShell approved import marker missing: ${marker}`);

for (const marker of [
  'gate enables import only after reviewed non-empty candidate and callback',
  'manifest records Q386R1 without OCR/workspace PASS claim',
  'workspaceImportPassClaimedByPackage',
]) check(test.includes(marker), `Q386R1 test marker missing: ${marker}`);

check(manifest.cameraOcrCandidateReviewWorkspaceImportBindingLatestPhase === 'V172-Q386R1-OCR-CANDIDATE-REVIEW-WORKSPACE-IMPORT-BINDING', 'manifest latest Q386R1 phase missing');
const q386r1 = manifest.v172Q386R1CameraOcrCandidateReviewWorkspaceImportBinding;
check(q386r1?.requiresRealDecodedCandidate === true, 'manifest Q386R1 requires real candidate missing');
check(q386r1?.requiresEditableReviewDraft === true, 'manifest Q386R1 requires review draft missing');
check(q386r1?.requiresWorkspaceImportCallback === true, 'manifest Q386R1 callback marker missing');
check(q386r1?.directCameraToWorkspaceImportBlocked === true, 'manifest Q386R1 direct import must be blocked');
check(q386r1?.autoEvaluateBlocked === true, 'manifest Q386R1 auto evaluate must be blocked');
check(q386r1?.autoGraphBlocked === true, 'manifest Q386R1 auto graph must be blocked');
check(q386r1?.autoSolutionHistoryBlocked === true, 'manifest Q386R1 auto solution/history must be blocked');
check(q386r1?.workspaceImportPassClaimedByPackage === false, 'manifest Q386R1 must not claim workspace import PASS');
check(q386r1?.ocrPassClaimedByPackage === false, 'manifest Q386R1 must not claim OCR PASS');

for (const marker of ['reviewed non-empty candidate', 'explicit user approval', 'No OCR or workspace PASS', 'Q382 keyboard untouched']) {
  check(`${audit}\n${changed}`.includes(marker), `Q386R1 audit/changed marker missing: ${marker}`);
}

for (const forbidden of ['onnxruntime-android', 'com.microsoft.onnxruntime']) check(!buildGradle.includes(forbidden), `ONNX Runtime must remain absent: ${forbidden}`);
for (const regex of [/^\s*google_mlkit_text_recognition\s*:/m, /^\s*onnxruntime/m, /^\s*pix2text/m]) check(!regex.test(pubspec), `forbidden OCR/runtime dependency returned: ${regex}`);
const forbiddenModelExt = /\.(onnx|nb|pdmodel|pdiparams|tflite|safetensors)$/i;
const modelArtifacts = [];
const walk = (dir) => {
  for (const entry of fs.readdirSync(path.join(root, dir), { withFileTypes: true })) {
    const rel = path.posix.join(dir, entry.name);
    if (rel.includes('/build/') || rel.includes('/.dart_tool/') || rel.startsWith('docs/evidence/')) continue;
    if (entry.isDirectory()) walk(rel);
    else if (forbiddenModelExt.test(rel)) modelArtifacts.push(rel);
  }
};
walk('.');
check(modelArtifacts.length === 0, `base project must not bundle OCR model artifacts: ${modelArtifacts.join(', ')}`);

console.log('PASS verify_camera_ocr_candidate_review_workspace_import_binding_v172_q386r1');
