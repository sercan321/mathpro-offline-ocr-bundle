#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const phase = 'V172-Q387R6-PADDLE-LITE-NB-CONVERSION-EVIDENCE-GENERATOR';
const dartPath = 'lib/features/camera/gauss_paddle_lite_nb_conversion_evidence_generator_q387r6.dart';
const managerPath = 'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart';
const testPath = 'test/v172_q387r6_paddle_lite_nb_conversion_evidence_generator_test.dart';
const toolPath = 'tool/generate_q387r6_paddle_lite_nb_conversion_evidence.mjs';
const docPath = 'docs/audit/V172_Q387R6_PADDLE_LITE_NB_CONVERSION_EVIDENCE_GENERATOR.md';
const changedPath = 'docs/audit/V172_Q387R6_CHANGED_FILES.md';
const manifestPath = 'assets/mathlive/manifest.json';
const readmePath = 'README.md';

function read(file) {
  if (!fs.existsSync(file)) fail(`missing:${file}`);
  return fs.readFileSync(file, 'utf8');
}

function mustContain(text, token, label) {
  if (!text.includes(token)) fail(`missing-token:${label || token}`);
}

function mustNotContain(text, token, label) {
  if (text.includes(token)) fail(`forbidden-token:${label || token}`);
}

function fail(reason) {
  console.error('Q387R6 VERIFY FAIL');
  console.error(reason);
  process.exit(1);
}

const dart = read(dartPath);
const manager = read(managerPath);
const test = read(testPath);
const tool = read(toolPath);
const doc = read(docPath);
const changed = read(changedPath);
const readme = read(readmePath);
const manifestRaw = read(manifestPath);
const manifest = JSON.parse(manifestRaw);

mustContain(dart, phase, 'phase marker');
mustContain(dart, 'GaussPaddleLiteNbConversionEvidenceGeneratorQ387R6Gate.evaluate', 'gate marker');
mustContain(dart, 'q387r6-conversion-evidence-required');
mustContain(dart, '--valid_targets=arm');
mustContain(dart, 'productionInferencePassClaimedByQ387R6 = false');
mustContain(dart, 'androidRealDevicePassClaimedByQ387R6 = false');
mustContain(dart, 'fakeLatexCandidateAllowed = false');
mustContain(dart, 'modelBinaryBundledInBaseApp = false');
mustContain(dart, 'onnxRuntimeReintroducedInBaseApk = false');

mustContain(test, 'Q387R6 blocks missing conversion evidence');
mustContain(test, 'Q387R6 emits Q387R3 acquisition evidence');

mustContain(tool, phase, 'tool phase');
mustContain(tool, '--source-dir');
mustContain(tool, '--output-nb');
mustContain(tool, 'sha256File(outputNb)');
mustContain(tool, 'sha256File(conversionLog)');
mustContain(tool, 'sourceInferenceFileSha256');
mustContain(tool, 'explicitReviewerApproval: true');
mustContain(tool, 'productionHostedSource: true');
mustContain(tool, 'productionInferencePassClaimedByQ387R6: false');
mustContain(tool, 'androidRealDevicePassClaimedByQ387R6: false');

mustContain(manager, "import 'gauss_paddle_lite_nb_conversion_evidence_generator_q387r6.dart';", 'manager import');
mustContain(manager, 'androidRuntimeNbConversionEvidencePhase');
mustContain(manager, 'paddleLiteNbConversionEvidenceGeneratorReadyForAndroidRuntime');
mustContain(manager, 'evaluatePaddleLiteNbConversionEvidenceQ387R6');
mustContain(manager, 'static Future<GaussMathOcrModelSnapshot> installVerifiedPaddleLiteNbModelQ387R2({', 'restored q387r2 install signature');
mustNotContain(manager, '  }\n    required GaussQ387R2PaddleLiteNbSource source', 'broken q387r2 signature splice');
if (manager.includes("return 'PP-FormulaNet-S modeli ana uygulamaya gömülü değil.") || manager.includes("return 'Model indirme isteği alındı.")) fail('unsafe single-quoted product copy remains');

mustContain(doc, 'Q387R6');
mustContain(doc, 'does **not** convert');
mustContain(doc, 'No `.nb` file is included.');
mustContain(changed, dartPath);
mustContain(readme, 'V172-Q387R6 — PADDLE LITE .NB CONVERSION EVIDENCE GENERATOR');

if (manifest.cameraOcrPaddleLiteNbConversionEvidenceGeneratorLatestPhase !== phase) fail('manifest latest phase mismatch');
const q = manifest.v172Q387R6PaddleLiteNbConversionEvidenceGenerator;
if (!q || q.phase !== phase) fail('manifest q387r6 object missing');
if (q.modelBinaryBundledInBaseApp !== false) fail('manifest model bundling false missing');
if (q.onnxRuntimeReintroducedInBaseApk !== false) fail('manifest onnx false missing');
if (q.productionInferencePassClaimedByQ387R6 !== false) fail('manifest production pass false missing');
if (q.androidRealDevicePassClaimedByQ387R6 !== false) fail('manifest device pass false missing');
if (q.fakeLatexCandidateAllowed !== false) fail('manifest fake latex false missing');
for (const file of [dartPath, testPath, toolPath, 'tool/verify_paddle_lite_nb_conversion_evidence_generator_v172_q387r6.mjs', docPath, changedPath]) {
  if (!manifest.assets.includes(file)) fail(`manifest asset missing:${file}`);
}

const forbiddenArtifacts = ['.onnx', '.pdmodel', '.pdiparams', '.tflite', '.safetensors', '.part', '.tmp', '.apk', '.aab'];
const allProjectFiles = [];
function walk(dir) {
  for (const entry of fs.readdirSync(dir, { withFileTypes: true })) {
    if (['.git', '.dart_tool', 'build', '.gradle', '.idea'].includes(entry.name)) continue;
    const full = path.join(dir, entry.name);
    if (entry.isDirectory()) walk(full);
    else allProjectFiles.push(full);
  }
}
walk('.');
for (const file of allProjectFiles) {
  const base = path.basename(file).toLowerCase();
  for (const ext of forbiddenArtifacts) {
    if (base.endsWith(ext)) fail(`forbidden artifact bundled:${file}`);
  }
}

const hash = crypto.createHash('sha256').update(dart + tool + manager).digest('hex');
console.log(`PASS verify_paddle_lite_nb_conversion_evidence_generator_v172_q387r6 ${hash}`);
