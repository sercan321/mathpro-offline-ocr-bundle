#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_paddle_lite_nb_production_source_binding_v172_q387r4: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policyPath = 'lib/features/camera/gauss_paddle_lite_nb_production_source_binding_q387r4.dart';
const managerPath = 'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart';
const testPath = 'test/v172_q387r4_paddle_lite_nb_production_source_binding_test.dart';
const auditPath = 'docs/audit/V172_Q387R4_PADDLE_LITE_NB_PRODUCTION_SOURCE_BINDING_GATE.md';
const changedPath = 'docs/audit/V172_Q387R4_CHANGED_FILES.md';
const manifestPath = 'assets/mathlive/manifest.json';

for (const required of [policyPath, managerPath, testPath, auditPath, changedPath, manifestPath]) {
  check(exists(required), `missing Q387R4 required file: ${required}`);
}

const policy = read(policyPath);
const manager = read(managerPath);
const test = read(testPath);
const audit = read(auditPath);
const changed = read(changedPath);
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const buildGradle = read('android/app/build.gradle');
const manifest = JSON.parse(read(manifestPath));

for (const marker of [
  'V172-Q387R4-PADDLE-LITE-NB-PRODUCTION-SOURCE-BINDING-GATE',
  "sourcePhase = 'V172-Q387R3-PADDLE-LITE-NB-ARTIFACT-ACQUISITION-CONVERSION-PROTOCOL'",
  'PRODUCTION_NB_SOURCE_BINDING_GATE_READY_BUT_VERIFIED_SOURCE_NOT_BOUND',
  'GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate',
  "productionNbSourceNotBoundBlockedReason = 'q387r4-production-nb-source-not-bound'",
  "acquisitionEvidenceRequiredBlockedReason = 'q387r4-acquisition-evidence-required'",
  "explicitReviewerApprovalRequiredBlockedReason = 'q387r4-explicit-reviewer-approval-required'",
  "productionHostingRequiredBlockedReason = 'q387r4-production-hosting-required'",
  "placeholderDomainRejectedBlockedReason = 'q387r4-placeholder-domain-rejected'",
  "nonHttpsProductionUrlRejectedBlockedReason = 'q387r4-non-https-production-url-rejected'",
  "nbUrlExtensionRequiredBlockedReason = 'q387r4-download-url-must-end-with-nb'",
  'officialPreoptimizedNbArtifactFoundInQ387R4 = false',
  'verifiedProductionNbSourceBoundInQ387R4 = false',
  'q387R2SourceConstructionImplemented = true',
  'q387R2ProductionSourceBindingAllowedWithoutEvidence = false',
  'q388RealInferenceAllowedWithoutBoundSource = false',
  'rejectsExampleDotComPlaceholderSource = true',
  'requiresExplicitReviewerApproval = true',
  'requiresProductionHosting = true',
  'modelBinaryBundledInBaseApp = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'productionInferencePassClaimedByQ387R4 = false',
  'androidRealDevicePassClaimedByQ387R4 = false',
  'fakeLatexCandidateAllowed = false',
  'keyboardQ382Touched = false',
  'graphHistorySolutionSolverTouched = false',
  'GaussQ387R2PaddleLiteNbSource(',
]) check(policy.includes(marker), `Q387R4 policy marker missing: ${marker}`);

for (const marker of [
  "import 'gauss_paddle_lite_nb_production_source_binding_q387r4.dart';",
  'androidRuntimeNbProductionSourceBindingPhase',
  'androidRuntimeNbProductionSourceBindingBlockedReason',
  'productionPaddleLiteNbSourceBoundForAndroidRuntime = false',
  'Q387R4 production source binding gate',
]) check(manager.includes(marker), `manager Q387R4 marker missing: ${marker}`);

for (const marker of [
  'blocks production binding while no verified source evidence exists',
  'rejects complete-looking placeholder evidence from example.com before Q387R2 source construction',
  'requires explicit reviewer approval and production hosting before binding',
  'constructs a Q387R2 source only from verified production evidence',
  'preserves download-only, no fake OCR, and protected-scope claims',
]) check(test.includes(marker), `Q387R4 test marker missing: ${marker}`);

check(manifest.cameraOcrPaddleLiteNbProductionSourceBindingLatestPhase === 'V172-Q387R4-PADDLE-LITE-NB-PRODUCTION-SOURCE-BINDING-GATE', 'manifest latest Q387R4 phase missing');
const q387r4 = manifest.v172Q387R4PaddleLiteNbProductionSourceBindingGate;
check(q387r4?.phase === 'V172-Q387R4-PADDLE-LITE-NB-PRODUCTION-SOURCE-BINDING-GATE', 'manifest Q387R4 phase mismatch');
check(q387r4?.sourcePhase === 'V172-Q387R3-PADDLE-LITE-NB-ARTIFACT-ACQUISITION-CONVERSION-PROTOCOL', 'manifest Q387R4 source mismatch');
check(q387r4?.officialPreoptimizedNbArtifactFoundInQ387R4 === false, 'manifest must not claim official preoptimized .nb found');
check(q387r4?.verifiedProductionNbSourceBoundInQ387R4 === false, 'manifest must not claim source bound');
check(q387r4?.q387R2SourceConstructionImplemented === true, 'manifest must mark source construction implemented');
check(q387r4?.q387R2ProductionSourceBindingAllowedWithoutEvidence === false, 'manifest must block binding without evidence');
check(q387r4?.q388RealInferenceAllowedWithoutBoundSource === false, 'manifest must block Q388 without source');
check(q387r4?.rejectsExampleDotComPlaceholderSource === true, 'manifest must reject placeholder domains');
check(q387r4?.requiresExplicitReviewerApproval === true, 'manifest must require explicit reviewer approval');
check(q387r4?.requiresProductionHosting === true, 'manifest must require production hosting');
check(q387r4?.modelBinaryBundledInBaseApp === false, 'manifest must keep model out of base app');
check(q387r4?.fakeLatexCandidateAllowed === false, 'manifest must not allow fake OCR');

for (const marker of ['Q387R4', 'q387r4-placeholder-domain-rejected', 'production source binding gate', 'does not bind a fake URL', 'No keyboard layout/order/labels']) {
  check(`${audit}\n${changed}\n${readme}`.includes(marker), `Q387R4 docs/README marker missing: ${marker}`);
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

console.log('PASS verify_paddle_lite_nb_production_source_binding_v172_q387r4');
