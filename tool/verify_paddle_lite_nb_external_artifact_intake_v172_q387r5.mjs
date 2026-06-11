#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const failures = [];
const root = process.cwd();
const read = (p) => fs.existsSync(p) ? fs.readFileSync(p, 'utf8') : '';
const mustExist = (p) => { if (!fs.existsSync(p)) failures.push(`missing ${p}`); };
const mustContain = (p, text) => { const c = read(p); if (!c.includes(text)) failures.push(`${p} missing marker: ${text}`); };
const mustNotContain = (p, text) => { const c = read(p); if (c.includes(text)) failures.push(`${p} contains forbidden marker: ${text}`); };

const dart = 'lib/features/camera/gauss_paddle_lite_nb_external_artifact_intake_q387r5.dart';
const test = 'test/v172_q387r5_paddle_lite_nb_external_artifact_intake_test.dart';
const intake = 'tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs';
const doc = 'docs/audit/V172_Q387R5_PADDLE_LITE_NB_EXTERNAL_ARTIFACT_INTAKE_CLOSURE.md';
const changed = 'docs/audit/V172_Q387R5_CHANGED_FILES.md';
const manager = 'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart';
const manifest = 'assets/mathlive/manifest.json';
const readme = 'README.md';

for (const p of [dart, test, intake, doc, changed]) mustExist(p);

mustContain(dart, 'V172-Q387R5-PADDLE-LITE-NB-EXTERNAL-ARTIFACT-INTAKE-CLOSURE');
mustContain(dart, 'q387r5-external-nb-artifact-evidence-required');
mustContain(dart, 'q387r5-mutable-download-url-rejected');
mustContain(dart, 'q387r5-local-nb-file-sha-size-mismatch');
mustContain(dart, 'GaussPaddleLiteNbExternalArtifactIntakeQ387R5Gate.evaluate');
mustContain(dart, 'GaussPaddleLiteNbProductionSourceBindingQ387R4Gate.evaluate');
mustContain(dart, 'modelBinaryBundledInBaseApp = false');
mustContain(dart, 'onnxRuntimeReintroducedInBaseApk = false');
mustContain(dart, 'productionInferencePassClaimedByQ387R5 = false');
mustContain(dart, 'fakeLatexCandidateAllowed = false');
mustContain(dart, "'/resolve/main/'");
mustContain(dart, "'/releases/latest/'");

mustContain(test, 'rejects mutable branch URLs');
mustContain(test, 'rejects non-immutable source revisions');
mustContain(test, 'verifies optional local file SHA/size evidence');
mustContain(test, 'rejects local file SHA/size mismatch');

mustContain(intake, 'q387r5-external-nb-artifact-evidence-required');
mustContain(intake, 'q387r5-mutable-download-url-rejected');
mustContain(intake, 'q387r5-local-nb-file-sha-size-mismatch');
mustContain(intake, 'Q387R5_LOCAL_NB_FILE');
mustContain(intake, 'q387r5_paddle_lite_nb_external_artifact_intake_report.json');
mustContain(intake, 'productionInferencePassClaimedByQ387R5: false');
mustContain(intake, 'modelBinaryBundledInBaseApp: false');

mustContain(manager, 'gauss_paddle_lite_nb_external_artifact_intake_q387r5.dart');
mustContain(manager, 'androidRuntimeNbExternalArtifactIntakePhase');
mustContain(manager, 'androidRuntimeNbExternalArtifactIntakeBlockedReason');
mustContain(manager, 'evaluateExternalPaddleLiteNbArtifactQ387R5');

mustContain(manifest, 'cameraOcrPaddleLiteNbExternalArtifactIntakeLatestPhase');
mustContain(manifest, 'V172-Q387R5-PADDLE-LITE-NB-EXTERNAL-ARTIFACT-INTAKE-CLOSURE');
mustContain(manifest, 'q387r5-mutable-download-url-rejected');
mustContain(manifest, 'productionInferencePassClaimedByQ387R5');

mustContain(readme, 'V172-Q387R5 — PADDLE LITE .NB EXTERNAL ARTIFACT INTAKE CLOSURE');
mustContain(doc, 'does not bundle');
mustContain(changed, dart);
mustContain(changed, intake);

// Guard against accidental bundled model artifacts in the project tree.
const forbiddenExt = ['.onnx', '.nb', '.pdmodel', '.pdiparams', '.tflite', '.safetensors', '.part', '.tmp', '.apk', '.aab'];
function walk(dir) {
  for (const name of fs.readdirSync(dir)) {
    const p = path.join(dir, name);
    const rel = path.relative(root, p).replaceAll(path.sep, '/');
    if (rel.startsWith('build/') || rel.startsWith('.dart_tool/') || rel.startsWith('.gradle/')) continue;
    const st = fs.lstatSync(p);
    if (st.isDirectory()) walk(p);
    else {
      const lower = name.toLowerCase();
      if (forbiddenExt.some((ext) => lower.endsWith(ext))) failures.push(`forbidden bundled artifact: ${rel}`);
    }
  }
}
walk(root);

for (const p of [dart, manager, manifest]) {
  mustNotContain(p, 'OCR PASS');
  mustNotContain(p, 'real-device PASS');
}

if (failures.length) {
  console.error('Q387R5 VERIFY FAIL');
  for (const f of failures) console.error(`- ${f}`);
  process.exit(1);
}
console.log('PASS verify_paddle_lite_nb_external_artifact_intake_v172_q387r5');
