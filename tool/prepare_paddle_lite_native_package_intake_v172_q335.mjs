#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const phase = 'V172-Q335-NATIVE-PACKAGE-HASH-EVIDENCE-COLLECTION-USER-SIDE-NATIVE-PACKAGE-INTAKE';
const intakeRoot = path.resolve(projectRoot, '..', 'MathProOcrNativePackages', 'Paddle_Lite_Android');
const requiredFiles = [
  'PaddlePredictor.jar',
  'arm64-v8a/libpaddle_lite_jni.so',
  'armeabi-v7a/libpaddle_lite_jni.so',
];
const optionalFiles = ['x86_64/libpaddle_lite_jni.so'];

function ensureOutsideProjectRoot(targetPath) {
  const relative = path.relative(projectRoot, targetPath);
  if (!relative.startsWith('..') && !path.isAbsolute(relative)) {
    throw new Error(`refusing to prepare native package intake inside project root: ${targetPath}`);
  }
}

ensureOutsideProjectRoot(intakeRoot);
fs.mkdirSync(intakeRoot, { recursive: true });
for (const rel of [...requiredFiles, ...optionalFiles]) {
  fs.mkdirSync(path.dirname(path.join(intakeRoot, rel)), { recursive: true });
}

const evidencePath = path.join(intakeRoot, 'q335_native_package_intake_instructions.json');
const evidence = {
  phase,
  intakeRoot,
  requiredFiles,
  optionalFiles,
  q328CaptureScript: 'tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs',
  nextCommandAfterFilesArePlaced: 'node tool/capture_paddle_lite_native_package_hashes_v172_q328.mjs --verify',
  projectRoot,
  intakeRootOutsideProjectRoot: path.relative(projectRoot, intakeRoot).startsWith('..'),
  binaryBundledIntoProject: false,
  runtimeAccepted: false,
  note: 'Place Paddle Lite Android native package files in this external folder, then run the Q328 hash capture script from the project root. Q335 does not bundle binaries into the Flutter project.',
};
fs.writeFileSync(evidencePath, `${JSON.stringify(evidence, null, 2)}
`);
console.log(JSON.stringify(evidence, null, 2));
