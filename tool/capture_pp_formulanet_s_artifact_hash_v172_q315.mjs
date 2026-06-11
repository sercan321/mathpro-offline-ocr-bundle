#!/usr/bin/env node
import crypto from 'node:crypto';
import fs from 'node:fs';
import https from 'node:https';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');

const PHASE = 'V172-Q315-CONTROLLED-MODEL-ARTIFACT-DOWNLOAD-HASH-CAPTURE';
const MODEL_NAME = 'PP-FormulaNet-S';
const ARTIFACT_FILE = 'inference.pdiparams';
const EXPECTED_SHA256 = 'b6392296d16e2a9f414c0a751d7ccbd1bd9d8272b68aab72df1d3875f35a7489';
const DOWNLOAD_URL = 'https://huggingface.co/PaddlePaddle/PP-FormulaNet-S/resolve/main/inference.pdiparams?download=true';
const DEFAULT_OUTPUT_DIR_POLICY = '../MathProOcrArtifacts/PP-FormulaNet-S';
const DEFAULT_OUTPUT_DIR = path.resolve(projectRoot, DEFAULT_OUTPUT_DIR_POLICY);

function fail(message) {
  console.error(`[${PHASE}] ${message}`);
  process.exit(1);
}

function ensureOutsideProjectRoot(targetPath) {
  const resolved = path.resolve(targetPath);
  const relative = path.relative(projectRoot, resolved);
  if (!relative.startsWith('..') && !path.isAbsolute(relative)) {
    fail(`refusing to write model artifact inside project root: ${resolved}`);
  }
  return resolved;
}

function sha256File(filePath) {
  return new Promise((resolve, reject) => {
    const hash = crypto.createHash('sha256');
    const stream = fs.createReadStream(filePath);
    stream.on('data', chunk => hash.update(chunk));
    stream.on('error', reject);
    stream.on('end', () => resolve(hash.digest('hex')));
  });
}

function download(url, destination) {
  return new Promise((resolve, reject) => {
    const request = https.get(url, { headers: { 'User-Agent': 'MathPro-Q315-artifact-hash-capture' } }, response => {
      if ([301, 302, 303, 307, 308].includes(response.statusCode ?? 0)) {
        const location = response.headers.location;
        response.resume();
        if (!location) reject(new Error(`redirect without location from ${url}`));
        else resolve(download(location, destination));
        return;
      }
      if (response.statusCode !== 200) {
        response.resume();
        reject(new Error(`download failed with HTTP ${response.statusCode}`));
        return;
      }
      const file = fs.createWriteStream(destination, { flags: 'wx' });
      response.pipe(file);
      file.on('finish', () => file.close(resolve));
      file.on('error', reject);
    });
    request.on('error', reject);
    request.setTimeout(120000, () => {
      request.destroy(new Error('download timed out'));
    });
  });
}

function parseArgs() {
  const args = process.argv.slice(2);
  const opts = { download: false, verify: false, outputDir: DEFAULT_OUTPUT_DIR };
  for (let index = 0; index < args.length; index += 1) {
    const arg = args[index];
    if (arg === '--download') opts.download = true;
    else if (arg === '--verify') opts.verify = true;
    else if (arg === '--output-dir') {
      index += 1;
      if (!args[index]) fail('--output-dir requires a value');
      opts.outputDir = args[index];
    } else {
      fail(`unknown argument: ${arg}`);
    }
  }
  return opts;
}

const opts = parseArgs();
const outputDir = ensureOutsideProjectRoot(opts.outputDir);
const artifactPath = path.join(outputDir, ARTIFACT_FILE);
const artifactRelativeToProject = path.relative(projectRoot, artifactPath);
const evidencePath = path.join(outputDir, 'q315_artifact_hash_evidence.json');

fs.mkdirSync(outputDir, { recursive: true });

if (opts.download) {
  if (fs.existsSync(artifactPath)) fail(`artifact already exists; remove it before re-download: ${artifactPath}`);
  const tempPath = `${artifactPath}.part`;
  if (fs.existsSync(tempPath)) fs.rmSync(tempPath, { force: true });
  console.log(`[${PHASE}] downloading ${DOWNLOAD_URL}`);
  await download(DOWNLOAD_URL, tempPath);
  fs.renameSync(tempPath, artifactPath);
}

if (!fs.existsSync(artifactPath)) {
  fail(`artifact file not found: ${artifactPath}. Run with --download or place ${ARTIFACT_FILE} there first.`);
}

const actualSha256 = await sha256File(artifactPath);
const stat = fs.statSync(artifactPath);
const evidence = {
  phase: PHASE,
  modelName: MODEL_NAME,
  artifactFile: ARTIFACT_FILE,
  artifactPath,
  defaultOutputDirPolicy: DEFAULT_OUTPUT_DIR_POLICY,
  downloadUrl: DOWNLOAD_URL,
  expectedSha256: EXPECTED_SHA256,
  actualSha256,
  sha256MatchesExpected: actualSha256 === EXPECTED_SHA256,
  sizeBytes: stat.size,
  capturedAt: new Date().toISOString(),
  projectRoot,
  artifactStoredOutsideProjectRoot: artifactRelativeToProject.startsWith('..') || path.isAbsolute(artifactRelativeToProject),
  runtimeAccepted: false,
  note: 'Q315 captures artifact hash evidence only. It does not accept the model for runtime use.',
};
fs.writeFileSync(evidencePath, `${JSON.stringify(evidence, null, 2)}\n`);

console.log(JSON.stringify(evidence, null, 2));
if (opts.verify && actualSha256 !== EXPECTED_SHA256) fail('local artifact SHA256 does not match the published HF large-file SHA256');
