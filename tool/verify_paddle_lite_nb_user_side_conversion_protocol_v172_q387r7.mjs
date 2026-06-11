#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';
import { execFileSync } from 'child_process';

const phase = 'V172-Q387R7-PADDLE-LITE-NB-USER-SIDE-CONVERSION-PROTOCOL';
const dartPath = 'lib/features/camera/gauss_paddle_lite_nb_user_side_conversion_protocol_q387r7.dart';
const managerPath = 'lib/features/camera/gauss_deferred_math_ocr_model_manager.dart';
const testPath = 'test/v172_q387r7_paddle_lite_nb_user_side_conversion_protocol_test.dart';
const generatorPath = 'tool/generate_q387r7_paddle_lite_nb_user_conversion_protocol.mjs';
const docPath = 'docs/audit/V172_Q387R7_PADDLE_LITE_NB_USER_SIDE_CONVERSION_PROTOCOL.md';
const changedPath = 'docs/audit/V172_Q387R7_CHANGED_FILES.md';
const manifestPath = 'assets/mathlive/manifest.json';
const readmePath = 'README.md';

function read(file) {
  if (!fs.existsSync(file)) fail(`missing:${file}`);
  return fs.readFileSync(file, 'utf8');
}

function mustContain(text, token, label = token) {
  if (!text.includes(token)) fail(`missing-token:${label}`);
}

function mustNotContain(text, token, label = token) {
  if (text.includes(token)) fail(`forbidden-token:${label}`);
}

function fail(reason) {
  console.error('Q387R7 VERIFY FAIL');
  console.error(reason);
  process.exit(1);
}

const dart = read(dartPath);
const manager = read(managerPath);
const test = read(testPath);
const generator = read(generatorPath);
const doc = read(docPath);
const changed = read(changedPath);
const readme = read(readmePath);
const manifest = JSON.parse(read(manifestPath));

mustContain(dart, phase, 'phase marker');
mustContain(dart, 'GaussPaddleLiteNbUserSideConversionProtocolQ387R7Gate.evaluate', 'gate marker');
mustContain(dart, 'q387r7-user-side-conversion-protocol-input-required');
mustContain(dart, 'q387r7-immutable-source-revision-required');
mustContain(dart, 'q387r7-conversion-command-sequence-required');
mustContain(dart, 'Set-StrictMode -Version Latest');
mustContain(dart, 'generate_q387r6_paddle_lite_nb_conversion_evidence.mjs');
mustContain(dart, 'intake_q387r5_paddle_lite_nb_external_artifact.mjs');
mustContain(dart, 'productionInferencePassClaimedByQ387R7 = false');
mustContain(dart, 'androidRealDevicePassClaimedByQ387R7 = false');
mustContain(dart, 'fakeLatexCandidateAllowed = false');
mustContain(dart, 'modelBinaryBundledInBaseApp = false');
mustContain(dart, 'onnxRuntimeReintroducedInBaseApk = false');

mustContain(test, 'Q387R7 blocks missing protocol input');
mustContain(test, 'Q387R7 accepts complete PowerShell conversion protocol package');
mustContain(test, 'Q387R7 rejects command sequences without Q387R5 intake');

mustContain(generator, phase, 'generator phase');
mustContain(generator, '--paddle-lite-opt');
mustContain(generator, 'Set-StrictMode -Version Latest');
mustContain(generator, 'paddle_lite_opt --model_dir');
mustContain(generator, '--valid_targets=arm');
mustContain(generator, 'generate_q387r6_paddle_lite_nb_conversion_evidence.mjs');
mustContain(generator, 'intake_q387r5_paddle_lite_nb_external_artifact.mjs');
mustContain(generator, 'productionInferencePassClaimedByQ387R7: false');
mustContain(generator, 'androidRealDevicePassClaimedByQ387R7: false');
mustContain(generator, 'fakeLatexCandidateAllowed: false');

mustContain(manager, "gauss_paddle_lite_nb_user_side_conversion_protocol_q387r7.dart");
mustContain(manager, 'androidRuntimeNbUserSideConversionProtocolPhase');
mustContain(manager, 'evaluatePaddleLiteNbUserSideConversionProtocolQ387R7');
mustContain(manager, 'paddleLiteNbUserSideConversionProtocolReadyForAndroidRuntime');

mustContain(doc, 'does not claim Flutter, Android, camera, OCR, APK/AAB, or real-device PASS');
mustContain(changed, 'V172-Q387R7 Changed Files');
mustContain(readme, 'V172-Q387R7 — PADDLE LITE .NB USER-SIDE CONVERSION PROTOCOL');

if (manifest.cameraOcrPaddleLiteNbUserSideConversionProtocolLatestPhase !== phase) fail('manifest latest phase mismatch');
if (!manifest.v172Q387R7PaddleLiteNbUserSideConversionProtocol) fail('manifest q387r7 block missing');
if (manifest.v172Q387R7PaddleLiteNbUserSideConversionProtocol.modelBinaryBundledInBaseApp !== false) fail('manifest model bundle false missing');
if (manifest.v172Q387R7PaddleLiteNbUserSideConversionProtocol.productionInferencePassClaimedByQ387R7 !== false) fail('manifest pass claim false missing');

const assets = manifest.assets || [];
for (const asset of [dartPath, testPath, generatorPath, 'tool/verify_paddle_lite_nb_user_side_conversion_protocol_v172_q387r7.mjs', docPath, changedPath]) {
  if (!assets.includes(asset)) fail(`manifest asset missing:${asset}`);
}

const tmpRoot = fs.mkdtempSync(path.join('/tmp', 'q387r7-'));
const psOut = path.join(tmpRoot, 'run_q387r7_paddle_lite_nb_conversion_protocol.ps1');
execFileSync('node', [
  generatorPath,
  '--source-dir', 'C:/MathProOcr/PP-FormulaNet-S',
  '--paddle-lite-opt', 'C:/PaddleLite/paddle_lite_opt.exe',
  '--output-dir', 'C:/MathProOcr/out',
  '--source-revision', '0572450e501be9eb1b1cdb7e00fccf4b22fab4df',
  '--conversion-tool-version', '2.14',
  '--download-url', 'https://models.examplecdn.com/releases/0572450e501be9eb1b1cdb7e00fccf4b22fab4df/pp_formulanet_s_arm64.nb',
  '--provenance', 'q387r7 verifier smoke protocol only',
  '--reviewer-approved',
  '--production-hosted',
  '--out', psOut,
  '--evidence-out', path.join(tmpRoot, 'q387r6_evidence.json'),
], { stdio: 'pipe' });
const ps = read(psOut);
mustContain(ps, 'Set-StrictMode -Version Latest', 'generated ps strict mode');
mustContain(ps, 'paddle_lite_opt --model_dir', 'generated ps conversion comment');
mustContain(ps, 'generate_q387r6_paddle_lite_nb_conversion_evidence.mjs', 'generated ps q387r6');
mustContain(ps, 'intake_q387r5_paddle_lite_nb_external_artifact.mjs', 'generated ps q387r5');
mustContain(ps, 'No OCR/device/build PASS claimed', 'generated ps no pass claim');

const hash = crypto.createHash('sha256').update(dart + generator + test).digest('hex');
console.log(`PASS verify_paddle_lite_nb_user_side_conversion_protocol_v172_q387r7 ${hash}`);
