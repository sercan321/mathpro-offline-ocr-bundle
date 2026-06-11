#!/usr/bin/env node
import crypto from 'node:crypto';
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');

const PHASE = 'V172-Q328-NATIVE-LIBRARY-PACKAGE-FILE-HASH-INTAKE-NO-BUNDLE-EVIDENCE-GATE';
const DEFAULT_INPUT_DIR_POLICY = '../MathProOcrNativePackages/Paddle_Lite_Android';
const DEFAULT_INPUT_DIR = path.resolve(projectRoot, DEFAULT_INPUT_DIR_POLICY);
const EVIDENCE_FILE = 'q328_native_library_package_hash_evidence.json';
const REQUIRED_FILES = [
  'PaddlePredictor.jar',
  'arm64-v8a/libpaddle_lite_jni.so',
  'armeabi-v7a/libpaddle_lite_jni.so',
];
const OPTIONAL_FILES = [
  'x86_64/libpaddle_lite_jni.so',
];

function fail(message) {
  console.error(`[${PHASE}] ${message}`);
  process.exit(1);
}

function ensureOutsideProjectRoot(targetPath) {
  const resolved = path.resolve(targetPath);
  const relative = path.relative(projectRoot, resolved);
  if (!relative.startsWith('..') && !path.isAbsolute(relative)) {
    fail(`refusing to read/write native package evidence inside project root: ${resolved}`);
  }
  return resolved;
}

function parseArgs() {
  const args = process.argv.slice(2);
  const opts = { inputDir: DEFAULT_INPUT_DIR, verifyOnly: false };
  for (let index = 0; index < args.length; index += 1) {
    const arg = args[index];
    if (arg === '--input-dir') {
      index += 1;
      if (!args[index]) fail('--input-dir requires a value');
      opts.inputDir = args[index];
    } else if (arg === '--verify-only') {
      opts.verifyOnly = true;
    } else {
      fail(`unknown argument: ${arg}`);
    }
  }
  return opts;
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

async function describeFile(root, rel, required) {
  const filePath = path.join(root, rel);
  const exists = fs.existsSync(filePath) && fs.statSync(filePath).isFile();
  if (!exists) {
    return { relativePath: rel, required, exists: false, sizeBytes: 0, sha256: '' };
  }
  const stat = fs.statSync(filePath);
  const sha256 = await sha256File(filePath);
  return { relativePath: rel, required, exists: true, sizeBytes: stat.size, sha256 };
}

const opts = parseArgs();
const inputDir = ensureOutsideProjectRoot(opts.inputDir);
const evidencePath = path.join(inputDir, EVIDENCE_FILE);

if (!fs.existsSync(inputDir)) {
  fail(`native package input directory not found: ${inputDir}. Place PaddlePredictor.jar and ABI .so files there first.`);
}

const fileEvidence = [];
for (const rel of REQUIRED_FILES) fileEvidence.push(await describeFile(inputDir, rel, true));
for (const rel of OPTIONAL_FILES) fileEvidence.push(await describeFile(inputDir, rel, false));

const missingRequiredFiles = fileEvidence.filter(item => item.required && !item.exists).map(item => item.relativePath);
const requiredFilesAllPresent = missingRequiredFiles.length === 0;
const requiredFilesAllHaveSha256 = fileEvidence.filter(item => item.required).every(item => item.exists && item.sha256.length === 64);

const evidence = {
  phase: PHASE,
  sourcePhase: 'V172-Q327-NATIVE-LIBRARY-SOURCE-PACKAGE-APPROVAL-ABI-MATRIX-LOCK',
  selectedRuntimeDependencyCandidate: 'PADDLE_LITE_ANDROID_NATIVE_LIBRARY_MANUAL_TRIAL_PENDING',
  defaultInputDirPolicy: DEFAULT_INPUT_DIR_POLICY,
  inputDir,
  evidencePath,
  requiredFiles: REQUIRED_FILES,
  optionalFiles: OPTIONAL_FILES,
  files: fileEvidence,
  missingRequiredFiles,
  requiredFilesAllPresent,
  requiredFilesAllHaveSha256,
  evidenceStoredOutsideProjectRoot: true,
  nativePackageFilesBundledIntoProject: false,
  runtimeDependencyAdded: false,
  nativeLoaderAdded: false,
  runtimeAccepted: false,
  note: 'Q328 captures native package file hash evidence only. It does not bundle .so/.jar/.aar files into the project.',
  capturedAt: new Date().toISOString(),
  projectRoot,
};

if (!opts.verifyOnly) {
  fs.writeFileSync(evidencePath, `${JSON.stringify(evidence, null, 2)}\n`);
}

console.log(JSON.stringify(evidence, null, 2));
if (!requiredFilesAllPresent) fail(`missing required native package file(s): ${missingRequiredFiles.join(', ')}`);
if (!requiredFilesAllHaveSha256) fail('required native package file hash capture failed');
