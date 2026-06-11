#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const fail = (m) => { console.error(`FAIL verify_paddle_lite_nb_artifact_manifest_evidence_v172_q387r1: ${m}`); process.exit(1); };
const check = (cond, msg) => { if (!cond) fail(msg); };

const policyPath = 'lib/features/camera/gauss_paddle_lite_nb_artifact_manifest_q387r1.dart';
const testPath = 'test/v172_q387r1_paddle_lite_nb_artifact_manifest_evidence_gate_test.dart';
const auditPath = 'docs/audit/V172_Q387R1_PADDLE_LITE_NB_ARTIFACT_MANIFEST_EVIDENCE_GATE.md';
const changedPath = 'docs/audit/V172_Q387R1_CHANGED_FILES.md';
const mainPath = 'android/app/src/main/kotlin/com/mathpro/flutter/MainActivity.kt';
const managerPath = 'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart';
const manifestPath = 'assets/mathlive/manifest.json';

for (const required of [policyPath, testPath, auditPath, changedPath, mainPath, managerPath, manifestPath]) {
  check(exists(required), `missing Q387R1 required file: ${required}`);
}

const policy = read(policyPath);
const test = read(testPath);
const audit = read(auditPath);
const changed = read(changedPath);
const main = read(mainPath);
const manager = read(managerPath);
const readme = read('README.md');
const pubspec = read('pubspec.yaml');
const buildGradle = read('android/app/build.gradle');
const manifest = JSON.parse(read(manifestPath));

for (const marker of [
  'V172-Q387R1-PADDLE-LITE-NB-ARTIFACT-MANIFEST-EVIDENCE-GATE',
  "sourcePhase = 'V172-Q387-PADDLE-LITE-NB-MODEL-FORMAT-DECISION-GATE'",
  "requiredArtifactKind = 'paddle-lite-optimized-nb'",
  "requiredFileExtension = '.nb'",
  "requiredLoadMethod = 'MobileConfig.setModelFromFile(.nb)'",
  "requiredManifestFileName = 'q387r1_paddle_lite_nb_manifest.json'",
  "realNbArtifactEvidenceRequiredBlockedReason = 'q387r1-real-paddle-lite-nb-artifact-evidence-required'",
  "nbDownloadUrlRequiredBlockedReason = 'q387r1-nb-download-url-required'",
  "nbSha256RequiredBlockedReason = 'q387r1-nb-sha256-required'",
  "conversionProvenanceRequiredBlockedReason = 'q387r1-conversion-provenance-required'",
  'productionNbDownloadUrlBound = false',
  'productionNbSha256Bound = false',
  'productionNbArtifactBundledInBaseApp = false',
  'legacyInferenceDirectoryPromotedToAndroidRuntime = false',
  'onnxRuntimeReintroducedInBaseApk = false',
  'productionInferencePassClaimedByQ387R1 = false',
  'androidRealDevicePassClaimedByQ387R1 = false',
  'fakeLatexCandidateAllowed = false',
  'keyboardQ382Touched = false',
  'graphHistorySolutionSolverTouched = false',
]) check(policy.includes(marker), `Q387R1 policy marker missing: ${marker}`);

for (const marker of [
  'blocks until a real .nb URL SHA size provenance candidate exists',
  'rejects non-nb files and non-https placeholder URLs',
  'accepts only download-only .nb manifest candidates with SHA and provenance',
  'preserves download-only and no fake OCR claims',
]) check(test.includes(marker), `Q387R1 test marker missing: ${marker}`);

for (const marker of [
  'q387R1Phase = "V172-Q387R1-PADDLE-LITE-NB-ARTIFACT-MANIFEST-EVIDENCE-GATE"',
  'q387R1RequiredArtifactKind = "paddle-lite-optimized-nb"',
  'q387R1RequiredManifestFileName = "q387r1_paddle_lite_nb_manifest.json"',
  'q387R1RealNbEvidenceRequiredBlockedReason = "q387r1-real-paddle-lite-nb-artifact-evidence-required"',
  'q387R1ValidateNbManifestEvidence',
  'q387R1NbManifestEvidence',
  'q387r1NbArtifactReady',
  'q387r1-setModelFromFile-verified-paddle-lite-nb',
  'q387r1-blocked-nb-manifest-evidence-required',
  'q387R1ProductionInferencePassClaimed',
  'q387R1ProductionNbArtifactBundledInBaseApp',
  'JSONObject(manifest.readText())',
  'q318Sha256File(nbModelFile)',
]) check(main.includes(marker), `MainActivity Q387R1 marker missing: ${marker}`);

check(!main.includes('q387SelectedModelLoadStrategy = "q387-setModelFromFile-paddle-lite-nb"\n                        configClass.methods'), 'Q387R1 must not load .nb without verified manifest evidence');
check(main.includes('q387R1NbManifestEvidence["q387r1NbArtifactReady"] == true'), 'Q387R1 readiness must require native manifest evidence');
check(main.includes('nbModelFile != null && !q387R1NbArtifactReady -> (q387R1NbManifestEvidence["blockedReason"] as? String ?: q387R1RealNbEvidenceRequiredBlockedReason)'), 'Q387R1 blocked reason propagation missing');

for (const marker of [
  "import 'gauss_paddle_lite_nb_artifact_manifest_q387r1.dart';",
  'androidRuntimeRequiredArtifactKind',
  'androidRuntimeRequiredManifestFileName',
  'androidRuntimeNbEvidenceBlockedReason',
  'Android Paddle Lite OCR için ayrıca doğrulanmış .nb manifest kanıtı gerekir',
]) check(manager.includes(marker), `deferred model manager Q387R1 marker missing: ${marker}`);

check(manifest.cameraOcrPaddleLiteNbArtifactManifestEvidenceLatestPhase === 'V172-Q387R1-PADDLE-LITE-NB-ARTIFACT-MANIFEST-EVIDENCE-GATE', 'manifest latest Q387R1 phase missing');
const q387r1 = manifest.v172Q387R1PaddleLiteNbArtifactManifestEvidenceGate;
check(q387r1?.phase === 'V172-Q387R1-PADDLE-LITE-NB-ARTIFACT-MANIFEST-EVIDENCE-GATE', 'manifest Q387R1 phase mismatch');
check(q387r1?.requiredArtifactKind === 'paddle-lite-optimized-nb', 'manifest Q387R1 artifact kind mismatch');
check(q387r1?.requiredManifestFileName === 'q387r1_paddle_lite_nb_manifest.json', 'manifest Q387R1 manifest name missing');
check(q387r1?.productionNbDownloadUrlBound === false, 'manifest must not claim production .nb URL bound');
check(q387r1?.productionNbSha256Bound === false, 'manifest must not claim production .nb SHA bound');
check(q387r1?.productionNbArtifactBundledInBaseApp === false, 'manifest must keep .nb out of base app');
check(q387r1?.q387R2DownloadInstallAllowedWithoutRealNbEvidence === false, 'manifest must block Q387R2 without real .nb evidence');
check(q387r1?.productionInferencePassClaimedByQ387R1 === false, 'manifest must not claim inference PASS');
check(q387r1?.androidRealDevicePassClaimedByQ387R1 === false, 'manifest must not claim Android PASS');

for (const marker of ['Paddle Lite `.nb`', 'q387r1_paddle_lite_nb_manifest.json', 'q387r1-real-paddle-lite-nb-artifact-evidence-required', 'does **not** invent a model URL', 'No keyboard layout/order/labels']) {
  check(`${audit}\n${changed}\n${readme}`.includes(marker), `Q387R1 docs/README marker missing: ${marker}`);
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

console.log('PASS verify_paddle_lite_nb_artifact_manifest_evidence_v172_q387r1');
