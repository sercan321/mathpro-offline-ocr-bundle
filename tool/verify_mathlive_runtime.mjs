#!/usr/bin/env node
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_runtime.mjs', retiredPhase: 'verify_mathlive_runtime', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

/*
 * V172-Q90R4 MathLive runtime install verifier.
 *
 * This script verifies a local/offline MathLive vendor bundle after
 * tool/install_mathlive_runtime.mjs has run. It does not download anything,
 * does not enable MathLive in the main editor, and does not claim cursor PASS.
 */
import { existsSync, mkdirSync, readFileSync, statSync, writeFileSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(scriptDir, '..');
const reportPath = join(projectRoot, 'tool', 'verify_mathlive_runtime_report.json');
const vendorRoot = join(projectRoot, 'assets', 'mathlive', 'vendor', 'mathlive');
const projectManifestPath = join(projectRoot, 'assets', 'mathlive', 'manifest.json');
const runtimeManifestPath = join(vendorRoot, 'runtime_manifest.json');
const packageJsonPath = join(vendorRoot, 'package.json');

const requiredFiles = [
  'mathlive.min.js',
  'mathlive-fonts.css',
  'mathlive-static.css',
  'LICENSE.txt',
  'package.json',
  'runtime_manifest.json',
];

function readJson(path, issues, label) {
  try {
    return JSON.parse(readFileSync(path, 'utf8'));
  } catch (error) {
    issues.push(`${label} is not readable JSON: ${error.message}`);
    return {};
  }
}

function sizeOf(path) {
  try {
    return statSync(path).size;
  } catch (_) {
    return 0;
  }
}

const issues = [];
const fileEvidence = {};
for (const file of requiredFiles) {
  const path = join(vendorRoot, file);
  const present = existsSync(path);
  const bytes = present ? sizeOf(path) : 0;
  fileEvidence[file] = { present, bytes };
  if (!present) issues.push(`${file} is missing from ${vendorRoot}`);
  if (present && bytes <= 0) issues.push(`${file} is empty`);
}

const mathliveBytes = fileEvidence['mathlive.min.js']?.bytes ?? 0;
if (fileEvidence['mathlive.min.js']?.present && mathliveBytes < 1024) {
  issues.push('mathlive.min.js is too small to be treated as an official runtime bundle');
}

const packageJson = existsSync(packageJsonPath) ? readJson(packageJsonPath, issues, 'package.json') : {};
if (existsSync(packageJsonPath)) {
  if (packageJson.name !== 'mathlive') issues.push('package.json name is not mathlive');
  if (typeof packageJson.version !== 'string' || packageJson.version.trim().length === 0) {
    issues.push('package.json version is missing');
  }
}

const runtimeManifest = existsSync(runtimeManifestPath) ? readJson(runtimeManifestPath, issues, 'runtime_manifest.json') : {};
if (existsSync(runtimeManifestPath)) {
  if (runtimeManifest.packageSource !== 'npm') issues.push('runtime_manifest.json packageSource is not npm');
  if (runtimeManifest.packageName !== 'mathlive') issues.push('runtime_manifest.json packageName is not mathlive');
  if (runtimeManifest.runtimeBundled !== true) issues.push('runtime_manifest.json runtimeBundled is not true');
  if (runtimeManifest.remoteScriptLoadingAllowed !== false) {
    issues.push('runtime_manifest.json remoteScriptLoadingAllowed must be false');
  }
  if (runtimeManifest.mathLiveVirtualKeyboardEnabled !== false) {
    issues.push('runtime_manifest.json mathLiveVirtualKeyboardEnabled must be false');
  }
}

const projectManifest = existsSync(projectManifestPath) ? readJson(projectManifestPath, issues, 'assets/mathlive/manifest.json') : {};
if (!existsSync(projectManifestPath)) issues.push('assets/mathlive/manifest.json is missing');
if (existsSync(projectManifestPath)) {
  if (projectManifest.remoteScriptLoadingAllowed !== false) {
    issues.push('assets/mathlive/manifest.json remoteScriptLoadingAllowed must be false');
  }
  if (projectManifest.cdnDependencyAllowed !== false) {
    issues.push('assets/mathlive/manifest.json cdnDependencyAllowed must be false');
  }
  if (projectManifest.mathLiveVirtualKeyboardEnabled !== false) {
    issues.push('assets/mathlive/manifest.json mathLiveVirtualKeyboardEnabled must be false');
  }
  if (projectManifest.mainEditorSwitchAllowed !== false) {
    issues.push('assets/mathlive/manifest.json mainEditorSwitchAllowed must remain false');
  }
}

function writeJsonReport(path, value) {
  mkdirSync(dirname(path), { recursive: true });
  writeFileSync(path, JSON.stringify(value, null, 2) + '\n', 'utf8');
}

const ready = issues.length === 0;
const report = {
  phase: 'V172-Q90R4',
  status: ready ? 'MATHLIVE_RUNTIME_INSTALL_VERIFIED_FOR_LAB_SMOKE' : 'BLOCKED_MATHLIVE_RUNTIME_INSTALL_VERIFICATION',
  projectRoot,
  vendorRoot,
  installVerified: ready,
  q90r2SmokeMayRun: ready,
  q87CursorCourtMayRun: false,
  mainEditorSwitchAllowed: false,
  cursorPassClaimed: false,
  protectedUiMutationAllowed: false,
  fileEvidence,
  packageName: packageJson.name ?? null,
  packageVersion: packageJson.version ?? null,
  issues,
};

writeJsonReport(reportPath, report);
console.log(JSON.stringify(report, null, 2));
process.exitCode = ready ? 0 : 2;
