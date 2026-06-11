#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const PHASE = 'V172-Q336-NATIVE-PACKAGE-HASH-EVIDENCE-CAPTURE-Q328-JSON-INTAKE';
const DEFAULT_NATIVE_PACKAGE_DIR_POLICY = '../MathProOcrNativePackages/Paddle_Lite_Android';
const EVIDENCE_FILE_NAME = 'q328_native_library_package_hash_evidence.json';
const REQUIRED_FILES = [
  'PaddlePredictor.jar',
  'arm64-v8a/libpaddle_lite_jni.so',
  'armeabi-v7a/libpaddle_lite_jni.so',
];
const OPTIONAL_FILES = ['x86_64/libpaddle_lite_jni.so'];

function fail(message) {
  console.error(`[${PHASE}] ${message}`);
  process.exit(1);
}

function parseArgs() {
  const args = process.argv.slice(2);
  const opts = { requireEvidence: false, nativePackageDir: path.resolve(projectRoot, DEFAULT_NATIVE_PACKAGE_DIR_POLICY) };
  for (let index = 0; index < args.length; index += 1) {
    const arg = args[index];
    if (arg === '--require-evidence') opts.requireEvidence = true;
    else if (arg === '--native-package-dir') {
      index += 1;
      if (!args[index]) fail('--native-package-dir requires a value');
      opts.nativePackageDir = path.resolve(args[index]);
    } else {
      fail(`unknown argument: ${arg}`);
    }
  }
  return opts;
}

function evidenceFileMap(evidence) {
  const files = Array.isArray(evidence.files) ? evidence.files : [];
  const map = new Map();
  for (const entry of files) {
    if (entry && typeof entry.relativePath === 'string') map.set(entry.relativePath.replaceAll('\\', '/'), entry);
    if (entry && typeof entry.path === 'string') map.set(entry.path.replaceAll('\\', '/'), entry);
    if (entry && typeof entry.file === 'string') map.set(entry.file.replaceAll('\\', '/'), entry);
  }
  return map;
}

const opts = parseArgs();
const evidencePath = path.join(opts.nativePackageDir, EVIDENCE_FILE_NAME);
const evidenceExists = fs.existsSync(evidencePath);
let evidence = null;
let parseError = '';
let requiredFilesPresentInEvidence = false;
let filesWithSha256 = [];
let missingRequiredFiles = REQUIRED_FILES.slice();

if (evidenceExists) {
  try {
    evidence = JSON.parse(fs.readFileSync(evidencePath, 'utf8'));
    const byPath = evidenceFileMap(evidence);
    missingRequiredFiles = REQUIRED_FILES.filter(file => !byPath.has(file));
    filesWithSha256 = REQUIRED_FILES.filter(file => {
      const entry = byPath.get(file);
      return entry && typeof entry.sha256 === 'string' && /^[a-fA-F0-9]{64}$/.test(entry.sha256);
    });
    requiredFilesPresentInEvidence = missingRequiredFiles.length === 0 && filesWithSha256.length === REQUIRED_FILES.length;
  } catch (error) {
    parseError = `${error.name}: ${error.message}`;
  }
}

const output = {
  phase: PHASE,
  sourcePhase: 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE',
  nativePackageDir: opts.nativePackageDir,
  defaultNativePackageDirPolicy: DEFAULT_NATIVE_PACKAGE_DIR_POLICY,
  evidenceFileName: EVIDENCE_FILE_NAME,
  evidencePath,
  evidenceExists,
  evidenceParseError: parseError,
  requiredFiles: REQUIRED_FILES,
  optionalFiles: OPTIONAL_FILES,
  requiredFilesPresentInEvidence,
  filesWithSha256,
  missingRequiredFiles,
  q328NativePackageHashEvidenceJsonProvided: evidenceExists,
  q328NativePackageHashEvidenceJsonReviewed: evidenceExists && !parseError,
  nativePackageHashEvidenceAccepted: false,
  explicitUserBinaryBundleApprovalProvided: false,
  binaryBundlePermissionGranted: false,
  nativeLibraryBundled: false,
  jarBundled: false,
  runtimeDependencyAdded: false,
  ocrPassClaimed: false,
  note: 'Q336 reviews Q328 native package hash evidence only. It does not bundle native binaries or accept runtime use.',
};

console.log(JSON.stringify(output, null, 2));

if (opts.requireEvidence && (!evidenceExists || parseError || !requiredFilesPresentInEvidence)) {
  fail('Q328 native package hash evidence JSON is missing, invalid, or incomplete for required native package files.');
}
