#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const phase = 'V172-Q387R6-PADDLE-LITE-NB-CONVERSION-EVIDENCE-GENERATOR';
const reportPath = path.join('tool', 'reports', 'q387r6_paddle_lite_nb_conversion_evidence_report.json');
const requiredSourceFiles = ['config.json', 'inference.json', 'inference.yml', 'inference.pdiparams'];

function usage() {
  return [
    'Usage:',
    'node tool/generate_q387r6_paddle_lite_nb_conversion_evidence.mjs \\',
    '  --source-dir <PP-FormulaNet-S inference directory> \\',
    '  --output-nb <converted .nb file> \\',
    '  --conversion-log <conversion log file> \\',
    '  --source-revision <immutable revision sha> \\',
    '  --conversion-tool-version <paddle_lite_opt version> \\',
    '  --conversion-command "<exact command used>" \\',
    '  --download-url <immutable https .nb URL> \\',
    '  --provenance "<who/where/how conversion was produced>" \\',
    '  --reviewer-approved --production-hosted \\',
    '  [--out tool/reports/q387r6_paddle_lite_nb_conversion_evidence.json]',
  ].join('\n');
}

function parseArgs(argv) {
  const result = { reviewerApproved: false, productionHosted: false };
  for (let i = 2; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === '--reviewer-approved') { result.reviewerApproved = true; continue; }
    if (arg === '--production-hosted') { result.productionHosted = true; continue; }
    if (!arg.startsWith('--')) fail('q387r6-cli-argument-rejected', { arg, usage: usage() });
    const key = arg.slice(2).replace(/-([a-z])/g, (_, c) => c.toUpperCase());
    const value = argv[i + 1];
    if (!value || value.startsWith('--')) fail('q387r6-cli-argument-value-required', { arg, usage: usage() });
    result[key] = value;
    i += 1;
  }
  return result;
}

function writeReport(report, stderr = false) {
  fs.mkdirSync(path.dirname(reportPath), { recursive: true });
  fs.writeFileSync(reportPath, `${JSON.stringify(report, null, 2)}\n`);
  if (stderr) console.error(JSON.stringify(report, null, 2));
}

function fail(reason, details = {}) {
  const report = {
    phase,
    status: 'BLOCKED',
    blockedReason: reason,
    details,
    conversionEvidenceGeneratorImplemented: true,
    modelBinaryBundledInBaseApp: false,
    onnxRuntimeReintroducedInBaseApk: false,
    productionInferencePassClaimedByQ387R6: false,
    androidRealDevicePassClaimedByQ387R6: false,
    fakeLatexCandidateAllowed: false,
  };
  writeReport(report, true);
  process.exit(1);
}

function sha256File(filePath) {
  const hash = crypto.createHash('sha256');
  const streamData = fs.readFileSync(filePath);
  hash.update(streamData);
  return hash.digest('hex');
}

function is64Hex(value) {
  return typeof value === 'string' && /^[a-fA-F0-9]{64}$/.test(value.trim());
}

function hasImmutableRevision(value) {
  if (typeof value !== 'string') return false;
  const raw = value.trim().toLowerCase();
  if (!raw || ['main', 'master', 'latest', 'head'].includes(raw)) return false;
  const hex = raw.startsWith('hf-') ? raw.slice(3) : raw;
  return /^[a-f0-9]{12,64}$/.test(hex);
}

function immutableHttpsNbUrl(url) {
  try {
    const parsed = new URL(url);
    const pathname = parsed.pathname.toLowerCase();
    const mutablePath = ['/resolve/main/', '/resolve/master/', '/resolve/latest/', '/raw/main/', '/raw/master/', '/releases/latest/']
      .some((token) => pathname.includes(token));
    const ref = (parsed.searchParams.get('ref') || '').toLowerCase();
    return parsed.protocol === 'https:' && pathname.endsWith('.nb') && !mutablePath && !['main', 'master', 'latest', 'head'].includes(ref);
  } catch (_) {
    return false;
  }
}

const args = parseArgs(process.argv);
if (!args.sourceDir || !args.outputNb || !args.conversionLog || !args.sourceRevision || !args.conversionToolVersion || !args.conversionCommand || !args.downloadUrl || !args.provenance) {
  fail('q387r6-required-cli-arguments-missing', { usage: usage() });
}
if (!args.reviewerApproved) fail('q387r6-explicit-reviewer-approval-required', { usage: usage() });
if (!args.productionHosted) fail('q387r6-production-hosting-required', { usage: usage() });
if (!hasImmutableRevision(args.sourceRevision)) fail('q387r6-source-model-revision-required', { sourceRevision: args.sourceRevision });
if (!immutableHttpsNbUrl(args.downloadUrl)) fail('q387r6-immutable-https-nb-download-url-required', { downloadUrl: args.downloadUrl });

const sourceDir = path.resolve(args.sourceDir);
const outputNb = path.resolve(args.outputNb);
const conversionLog = path.resolve(args.conversionLog);
if (!fs.existsSync(sourceDir) || !fs.statSync(sourceDir).isDirectory()) fail('q387r6-source-dir-not-found', { sourceDir });
if (!fs.existsSync(outputNb) || !fs.statSync(outputNb).isFile()) fail('q387r6-output-nb-not-found', { outputNb });
if (!outputNb.toLowerCase().endsWith('.nb')) fail('q387r6-nb-output-file-required', { outputNb });
if (!fs.existsSync(conversionLog) || !fs.statSync(conversionLog).isFile()) fail('q387r6-conversion-log-not-found', { conversionLog });

const sourceInferenceFileSha256 = {};
const sourceInferenceFileSizeBytes = {};
for (const file of requiredSourceFiles) {
  const fullPath = path.join(sourceDir, file);
  if (!fs.existsSync(fullPath) || !fs.statSync(fullPath).isFile()) fail('q387r6-source-inference-files-required', { missing: file, sourceDir });
  sourceInferenceFileSha256[file] = sha256File(fullPath);
  sourceInferenceFileSizeBytes[file] = fs.statSync(fullPath).size;
  if (sourceInferenceFileSizeBytes[file] <= 0) fail('q387r6-source-inference-file-empty', { file });
}

const outputStat = fs.statSync(outputNb);
const outputSha256 = sha256File(outputNb);
if (outputStat.size < 1024 * 1024) fail('q387r6-nb-output-size-required', { outputNb, outputSizeBytes: outputStat.size });
if (!is64Hex(outputSha256)) fail('q387r6-nb-output-sha256-required', { outputSha256 });

const command = String(args.conversionCommand || '');
if (!command.includes('paddle_lite_opt') || !command.includes('--optimize_out') || !command.includes('--valid_targets=arm') || !(command.includes('--model_dir') || (command.includes('--model_file') && command.includes('--param_file')))) {
  fail('q387r6-conversion-command-required', { conversionCommand: command });
}

const conversionLogDigest = sha256File(conversionLog);
const outputFileName = path.basename(outputNb);
const evidence = {
  schemaVersion: 'q387r6-conversion-evidence-v1',
  phase,
  sourcePhase: 'V172-Q387R5-PADDLE-LITE-NB-EXTERNAL-ARTIFACT-INTAKE-CLOSURE',
  targetIntakeTool: 'tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs',
  sourceModelId: 'pp_formulanet_s',
  sourceModelRevision: args.sourceRevision.trim(),
  sourceInferenceFiles: requiredSourceFiles,
  sourceInferenceFileSha256,
  sourceInferenceFileSizeBytes,
  conversionTool: 'paddle_lite_opt',
  conversionToolVersion: args.conversionToolVersion.trim(),
  androidTarget: 'android-arm64-v8a',
  conversionCommand: command.trim(),
  conversionLogDigest,
  outputFileName,
  outputSha256,
  outputSizeBytes: outputStat.size,
  downloadUrl: args.downloadUrl.trim(),
  conversionProvenance: args.provenance.trim(),
  bundledInBaseApp: false,
  explicitReviewerApproval: true,
  productionHostedSource: true,
  productionInferencePassClaimedByQ387R6: false,
  androidRealDevicePassClaimedByQ387R6: false,
  fakeLatexCandidateAllowed: false,
};

const outPath = path.resolve(args.out || path.join('tool', 'reports', 'q387r6_paddle_lite_nb_conversion_evidence.json'));
fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, `${JSON.stringify(evidence, null, 2)}\n`);

const report = {
  phase,
  status: 'Q387R5_INTAKE_EVIDENCE_JSON_READY_STATIC_ONLY',
  blockedReason: '',
  evidenceJsonPath: outPath,
  outputFileName,
  outputSha256,
  outputSizeBytes: outputStat.size,
  modelBinaryBundledInBaseApp: false,
  onnxRuntimeReintroducedInBaseApk: false,
  productionInferencePassClaimedByQ387R6: false,
  androidRealDevicePassClaimedByQ387R6: false,
  fakeLatexCandidateAllowed: false,
};
writeReport(report, false);
console.log('Q387R6 CONVERSION EVIDENCE READY: JSON written for Q387R5 intake; no OCR/device/build PASS claimed.');
