#!/usr/bin/env node
import fs from 'fs';
import path from 'path';
import crypto from 'crypto';

const phase = 'V172-Q387R5-PADDLE-LITE-NB-EXTERNAL-ARTIFACT-INTAKE-CLOSURE';
const reportPath = path.join('tool', 'reports', 'q387r5_paddle_lite_nb_external_artifact_intake_report.json');

function fail(reason, details = {}) {
  const report = {
    phase,
    status: 'BLOCKED',
    blockedReason: reason,
    details,
    productionInferencePassClaimedByQ387R5: false,
    androidRealDevicePassClaimedByQ387R5: false,
    modelBinaryBundledInBaseApp: false,
    onnxRuntimeReintroducedInBaseApk: false,
    fakeLatexCandidateAllowed: false,
  };
  fs.mkdirSync(path.dirname(reportPath), { recursive: true });
  fs.writeFileSync(reportPath, `${JSON.stringify(report, null, 2)}\n`);
  console.error(`Q387R5 INTAKE BLOCKED: ${reason}`);
  process.exit(1);
}

function sha256File(filePath) {
  const hash = crypto.createHash('sha256');
  const data = fs.readFileSync(filePath);
  hash.update(data);
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

function mutableUrl(url) {
  try {
    const parsed = new URL(url);
    const p = parsed.pathname.toLowerCase();
    return ['/resolve/main/', '/resolve/master/', '/resolve/latest/', '/raw/main/', '/raw/master/', '/releases/latest/'].some((token) => p.includes(token)) ||
      ['main', 'master', 'latest', 'head'].includes((parsed.searchParams.get('ref') || '').toLowerCase());
  } catch (_) {
    return true;
  }
}

const evidencePath = process.argv[2] || process.env.Q387R5_EVIDENCE_JSON;
const localNbPath = process.argv[3] || process.env.Q387R5_LOCAL_NB_FILE;

if (!evidencePath) {
  fail('q387r5-external-nb-artifact-evidence-required', { usage: 'node tool/intake_q387r5_paddle_lite_nb_external_artifact.mjs <evidence.json> [local.nb]' });
}
if (!fs.existsSync(evidencePath)) {
  fail('q387r5-evidence-json-not-found', { evidencePath });
}

let evidence;
try {
  evidence = JSON.parse(fs.readFileSync(evidencePath, 'utf8'));
} catch (error) {
  fail('q387r5-evidence-json-parse-failed', { evidencePath, error: String(error) });
}

const requiredFiles = ['config.json', 'inference.json', 'inference.yml', 'inference.pdiparams'];
const sourceFiles = new Set(Array.isArray(evidence.sourceInferenceFiles) ? evidence.sourceInferenceFiles.map((item) => String(item).trim()) : []);

if (evidence.sourceModelId !== 'pp_formulanet_s') fail('q387r5-source-model-id-rejected', { sourceModelId: evidence.sourceModelId });
if (!hasImmutableRevision(evidence.sourceModelRevision)) fail('q387r5-immutable-source-revision-required', { sourceModelRevision: evidence.sourceModelRevision });
if (!requiredFiles.every((file) => sourceFiles.has(file))) fail('q387r5-source-inference-files-required', { requiredFiles, sourceInferenceFiles: [...sourceFiles] });
if (evidence.conversionTool !== 'paddle_lite_opt') fail('q387r5-conversion-tool-evidence-required', { conversionTool: evidence.conversionTool });
if (!evidence.conversionToolVersion) fail('q387r5-conversion-tool-version-required');
if (evidence.androidTarget !== 'android-arm64-v8a') fail('q387r5-android-target-rejected', { androidTarget: evidence.androidTarget });
if (!String(evidence.conversionCommand || '').includes('paddle_lite_opt') || !String(evidence.conversionCommand || '').includes('--optimize_out')) fail('q387r5-conversion-command-required');
if (!is64Hex(evidence.conversionLogDigest)) fail('q387r5-conversion-log-digest-required');
if (!String(evidence.outputFileName || '').toLowerCase().endsWith('.nb')) fail('q387r5-nb-output-file-required', { outputFileName: evidence.outputFileName });
if (!is64Hex(evidence.outputSha256)) fail('q387r5-nb-output-sha256-required', { outputSha256: evidence.outputSha256 });
if (!Number.isInteger(evidence.outputSizeBytes) || evidence.outputSizeBytes < 1024 * 1024) fail('q387r5-nb-output-size-required', { outputSizeBytes: evidence.outputSizeBytes });
if (evidence.bundledInBaseApp === true) fail('q387r5-base-apk-model-bundling-rejected');
if (!evidence.conversionProvenance) fail('q387r5-conversion-provenance-required');

let parsedUrl;
try { parsedUrl = new URL(evidence.downloadUrl); } catch (_) { fail('q387r5-download-url-invalid', { downloadUrl: evidence.downloadUrl }); }
if (parsedUrl.protocol !== 'https:') fail('q387r5-non-https-production-url-rejected', { downloadUrl: evidence.downloadUrl });
if (!parsedUrl.pathname.toLowerCase().endsWith('.nb')) fail('q387r5-download-url-must-end-with-nb', { downloadUrl: evidence.downloadUrl });
if (mutableUrl(evidence.downloadUrl)) fail('q387r5-mutable-download-url-rejected', { downloadUrl: evidence.downloadUrl });
if (evidence.explicitReviewerApproval !== true) fail('q387r5-explicit-reviewer-approval-required');
if (evidence.productionHostedSource !== true) fail('q387r5-production-hosting-required');

let localFile = null;
if (localNbPath) {
  if (!fs.existsSync(localNbPath)) fail('q387r5-local-nb-file-not-found', { localNbPath });
  const stat = fs.statSync(localNbPath);
  const actualSha = sha256File(localNbPath);
  if (actualSha.toLowerCase() !== String(evidence.outputSha256).toLowerCase() || stat.size !== evidence.outputSizeBytes) {
    fail('q387r5-local-nb-file-sha-size-mismatch', { localNbPath, actualSha, actualSizeBytes: stat.size, expectedSha: evidence.outputSha256, expectedSizeBytes: evidence.outputSizeBytes });
  }
  localFile = { path: localNbPath, sha256: actualSha, sizeBytes: stat.size };
}

const q387r2Source = {
  fileName: evidence.outputFileName,
  downloadUrl: evidence.downloadUrl,
  sha256: String(evidence.outputSha256).toLowerCase(),
  sizeBytes: evidence.outputSizeBytes,
  conversionProvenance: evidence.conversionProvenance,
  sourceRevision: evidence.sourceModelRevision,
};

const report = {
  phase,
  sourcePhase: 'V172-Q387R4-PADDLE-LITE-NB-PRODUCTION-SOURCE-BINDING-GATE',
  status: 'Q387R2_SOURCE_READY_FOR_DOWNLOAD_INSTALL_WORKER_STATIC_INTAKE_ONLY',
  blockedReason: '',
  q387r2Source,
  localFile,
  modelBinaryBundledInBaseApp: false,
  onnxRuntimeReintroducedInBaseApk: false,
  productionInferencePassClaimedByQ387R5: false,
  androidRealDevicePassClaimedByQ387R5: false,
  fakeLatexCandidateAllowed: false,
};
fs.mkdirSync(path.dirname(reportPath), { recursive: true });
fs.writeFileSync(reportPath, `${JSON.stringify(report, null, 2)}\n`);
console.log('Q387R5 INTAKE STATIC READY: q387r2 source evidence accepted; no OCR/device/build PASS claimed.');
