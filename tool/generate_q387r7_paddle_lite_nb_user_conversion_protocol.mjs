#!/usr/bin/env node
import fs from 'fs';
import path from 'path';

const phase = 'V172-Q387R7-PADDLE-LITE-NB-USER-SIDE-CONVERSION-PROTOCOL';
const defaultOut = path.join('tool', 'reports', 'run_q387r7_paddle_lite_nb_conversion_protocol.ps1');
const defaultReport = path.join('tool', 'reports', 'q387r7_paddle_lite_nb_user_conversion_protocol_report.json');
const defaultEvidenceOut = path.join('tool', 'reports', 'q387r6_paddle_lite_nb_conversion_evidence.json');

function usage() {
  return [
    'Usage:',
    'node tool/generate_q387r7_paddle_lite_nb_user_conversion_protocol.mjs \\',
    '  --source-dir <PP-FormulaNet-S inference directory> \\',
    '  --paddle-lite-opt <path to paddle_lite_opt or paddle_lite_opt.exe> \\',
    '  --output-dir <directory for converted .nb and log> \\',
    '  --source-revision <immutable source revision sha> \\',
    '  --conversion-tool-version <paddle_lite_opt version> \\',
    '  --download-url <immutable https .nb URL after hosting> \\',
    '  --provenance "<who/where/how conversion was produced>" \\',
    '  --reviewer-approved --production-hosted \\',
    '  [--nb-name pp_formulanet_s_arm64.nb] \\',
    '  [--out tool/reports/run_q387r7_paddle_lite_nb_conversion_protocol.ps1] \\',
    '  [--evidence-out tool/reports/q387r6_paddle_lite_nb_conversion_evidence.json]',
  ].join('\n');
}

function parseArgs(argv) {
  const result = { reviewerApproved: false, productionHosted: false, nbName: 'pp_formulanet_s_arm64.nb' };
  for (let i = 2; i < argv.length; i += 1) {
    const arg = argv[i];
    if (arg === '--reviewer-approved') { result.reviewerApproved = true; continue; }
    if (arg === '--production-hosted') { result.productionHosted = true; continue; }
    if (!arg.startsWith('--')) fail('q387r7-cli-argument-rejected', { arg, usage: usage() });
    const key = arg.slice(2).replace(/-([a-z])/g, (_, c) => c.toUpperCase());
    const value = argv[i + 1];
    if (!value || value.startsWith('--')) fail('q387r7-cli-argument-value-required', { arg, usage: usage() });
    result[key] = value;
    i += 1;
  }
  return result;
}

function writeReport(report, stderr = false) {
  fs.mkdirSync(path.dirname(defaultReport), { recursive: true });
  fs.writeFileSync(defaultReport, `${JSON.stringify(report, null, 2)}\n`);
  if (stderr) console.error(JSON.stringify(report, null, 2));
}

function fail(reason, details = {}) {
  const report = {
    phase,
    status: 'BLOCKED',
    blockedReason: reason,
    details,
    protocolGeneratorImplemented: true,
    writesPowerShellProtocol: true,
    modelBinaryBundledInBaseApp: false,
    onnxRuntimeReintroducedInBaseApk: false,
    productionInferencePassClaimedByQ387R7: false,
    androidRealDevicePassClaimedByQ387R7: false,
    fakeLatexCandidateAllowed: false,
  };
  writeReport(report, true);
  process.exit(1);
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

function psSingle(value) {
  return String(value).replace(/'/g, "''");
}

const args = parseArgs(process.argv);
const required = ['sourceDir', 'paddleLiteOpt', 'outputDir', 'sourceRevision', 'conversionToolVersion', 'downloadUrl', 'provenance'];
for (const key of required) {
  if (!args[key] || String(args[key]).trim().isEmpty) fail('q387r7-required-cli-arguments-missing', { missing: key, usage: usage() });
}
if (!args.reviewerApproved) fail('q387r7-explicit-reviewer-approval-required', { usage: usage() });
if (!args.productionHosted) fail('q387r7-production-hosting-required', { usage: usage() });
if (!hasImmutableRevision(args.sourceRevision)) fail('q387r7-immutable-source-revision-required', { sourceRevision: args.sourceRevision });
if (!String(args.nbName).toLowerCase().endsWith('.nb')) fail('q387r7-output-nb-file-required', { nbName: args.nbName });
if (!immutableHttpsNbUrl(args.downloadUrl)) fail('q387r7-immutable-https-nb-download-url-required', { downloadUrl: args.downloadUrl });

const outPath = path.resolve(args.out || defaultOut);
const evidenceOut = path.resolve(args.evidenceOut || defaultEvidenceOut);
const nbName = path.basename(args.nbName);
const nbStem = nbName.replace(/\.nb$/i, '');
const logName = `${nbStem}_conversion.log`;
const sourceDir = args.sourceDir;
const outputDir = args.outputDir;
const nbPathExpression = `Join-Path $OutputDir '${psSingle(nbName)}'`;
const logPathExpression = `Join-Path $OutputDir '${psSingle(logName)}'`;
const optimizeOutExpression = `Join-Path $OutputDir '${psSingle(nbStem)}'`;

const conversionCommand = `& $PaddleLiteOpt --model_dir=$SourceDir --optimize_out=$OptimizeOutPrefix --valid_targets=arm --optimize_out_type=naive_buffer`;
const script = `# ${phase}
# Static user-side conversion protocol. This script is generated but not executed by the Flutter app.
# It does not claim OCR/device/build PASS. It must be run only after paddle_lite_opt and source files are present.
Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ProjectRoot = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
$SourceDir = '${psSingle(sourceDir)}'
$PaddleLiteOpt = '${psSingle(args.paddleLiteOpt)}'
$OutputDir = '${psSingle(outputDir)}'
$SourceRevision = '${psSingle(args.sourceRevision)}'
$ConversionToolVersion = '${psSingle(args.conversionToolVersion)}'
$DownloadUrl = '${psSingle(args.downloadUrl)}'
$Provenance = '${psSingle(args.provenance)}'
$EvidenceOut = '${psSingle(evidenceOut)}'
$NbOutput = ${nbPathExpression}
$ConversionLog = ${logPathExpression}
$OptimizeOutPrefix = ${optimizeOutExpression}

$RequiredSourceFiles = @('config.json', 'inference.json', 'inference.yml', 'inference.pdiparams')
foreach ($FileName in $RequiredSourceFiles) {
  $FilePath = Join-Path $SourceDir $FileName
  if (-not (Test-Path -LiteralPath $FilePath -PathType Leaf)) {
    throw "Q387R7 required PP-FormulaNet-S source file missing: $FilePath"
  }
}
if (-not (Test-Path -LiteralPath $PaddleLiteOpt -PathType Leaf)) {
  throw "Q387R7 paddle_lite_opt executable missing: $PaddleLiteOpt"
}
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null
New-Item -ItemType Directory -Force -Path (Split-Path -Parent $EvidenceOut) | Out-Null

# Expected command core for Q387R6 evidence:
# paddle_lite_opt --model_dir <source> --optimize_out <out-prefix> --valid_targets=arm --optimize_out_type=naive_buffer
& $PaddleLiteOpt --model_dir=$SourceDir --optimize_out=$OptimizeOutPrefix --valid_targets=arm --optimize_out_type=naive_buffer 2>&1 | Tee-Object -FilePath $ConversionLog
if (-not (Test-Path -LiteralPath $NbOutput -PathType Leaf)) {
  throw "Q387R7 conversion finished but .nb output was not found: $NbOutput"
}

$ExactCommand = '${psSingle(conversionCommand)}'
node tool/generate_q387r6_paddle_lite_nb_conversion_evidence.mjs \
  --source-dir $SourceDir \
  --output-nb $NbOutput \
  --conversion-log $ConversionLog \
  --source-revision $SourceRevision \
  --conversion-tool-version $ConversionToolVersion \
  --conversion-command $ExactCommand \
  --download-url $DownloadUrl \
  --provenance $Provenance \
  --reviewer-approved \
  --production-hosted \
  --out $EvidenceOut

node tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs $EvidenceOut $NbOutput
Write-Host 'Q387R7 USER-SIDE CONVERSION PROTOCOL COMPLETED: Q387R6 evidence generated and Q387R5 intake checked. No OCR/device/build PASS claimed.'
`;

fs.mkdirSync(path.dirname(outPath), { recursive: true });
fs.writeFileSync(outPath, script);

const report = {
  phase,
  status: 'Q387R7_USER_SIDE_CONVERSION_PROTOCOL_WRITTEN_STATIC_ONLY',
  blockedReason: '',
  powerShellScriptPath: outPath,
  expectedEvidenceJsonPath: evidenceOut,
  outputNbFileName: nbName,
  requiredNextTools: [
    'tool/generate_q387r6_paddle_lite_nb_conversion_evidence.mjs',
    'tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs',
  ],
  protocolGeneratorImplemented: true,
  writesPowerShellProtocol: true,
  writesQ387R6GeneratorInvocation: true,
  writesQ387R5IntakeInvocation: true,
  conversionRunsOutsideFlutterApp: true,
  modelBinaryBundledInBaseApp: false,
  onnxRuntimeReintroducedInBaseApk: false,
  productionInferencePassClaimedByQ387R7: false,
  androidRealDevicePassClaimedByQ387R7: false,
  fakeLatexCandidateAllowed: false,
};
writeReport(report, false);
console.log('Q387R7 USER-SIDE CONVERSION PROTOCOL WRITTEN: PowerShell script generated; no OCR/device/build PASS claimed.');
