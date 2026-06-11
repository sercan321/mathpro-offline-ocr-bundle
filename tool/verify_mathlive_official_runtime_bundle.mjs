#!/usr/bin/env node
import { runRetiredHistoricalVerifier } from './mathlive_verifier_suite_hygiene_shared_v172_q204r3.mjs';
if (process.cwd()) runRetiredHistoricalVerifier({ verifier: 'tool/verify_mathlive_official_runtime_bundle.mjs', retiredPhase: 'verify_mathlive_official_runtime_bundle', reason: 'historical verifier superseded by the Q197/Q203 production-surface architecture and Q204R2/Q204R3 suite hygiene; active production verification is handled by the declared preserved verifier suite' });

/*
 * V172-Q100 Official MathLive runtime bundle closure verifier.
 *
 * This verifier is deliberately offline: it never downloads MathLive, never
 * creates placeholder runtime files, never writes smoke evidence, never switches
 * the main editor, and never permits legacy cursor deletion. It only inspects
 * the local vendor bundle and writes a closure report.
 */
import { existsSync, mkdirSync, readFileSync, statSync, writeFileSync } from 'node:fs';
import { createHash } from 'node:crypto';
import path from 'node:path';
import process from 'node:process';
import { fileURLToPath } from 'node:url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);
const projectRoot = path.resolve(__dirname, '..');
const vendorRoot = path.join(projectRoot, 'assets', 'mathlive', 'vendor', 'mathlive');
const reportDir = path.join(projectRoot, 'tool', 'reports');
const jsonReportPath = path.join(reportDir, 'mathlive_official_runtime_bundle_report.json');
const mdReportPath = path.join(reportDir, 'mathlive_official_runtime_bundle_report.md');
const q90r4ReportPath = path.join(projectRoot, 'tool', 'verify_mathlive_runtime_report.json');

const requiredRuntimeFiles = [
  'mathlive.min.js',
  'mathlive-fonts.css',
  'mathlive-static.css',
  'LICENSE.txt',
  'package.json',
  'runtime_manifest.json',
];

function rel(absolutePath) {
  return path.relative(projectRoot, absolutePath).replaceAll(path.sep, '/');
}

function sha256File(absolutePath) {
  const h = createHash('sha256');
  h.update(readFileSync(absolutePath));
  return h.digest('hex');
}

function readJson(absolutePath, label, blockers) {
  if (!existsSync(absolutePath)) return null;
  try {
    return JSON.parse(readFileSync(absolutePath, 'utf8'));
  } catch (error) {
    blockers.push(`${label} is not readable JSON: ${error.message}`);
    return { parseError: String(error.message || error) };
  }
}

function runtimeFileStatus(file) {
  const absolutePath = path.join(vendorRoot, file);
  if (!existsSync(absolutePath)) return { file, path: rel(absolutePath), exists: false, bytes: 0, sha256: null };
  const bytes = statSync(absolutePath).size;
  return { file, path: rel(absolutePath), exists: true, bytes, sha256: sha256File(absolutePath) };
}

mkdirSync(reportDir, { recursive: true });

const blockers = [];
const runtimeFiles = requiredRuntimeFiles.map(runtimeFileStatus);
for (const file of runtimeFiles) {
  if (!file.exists) blockers.push(`official runtime file missing: ${file.path}`);
  if (file.exists && file.bytes <= 0) blockers.push(`official runtime file is empty: ${file.path}`);
}
const mathliveMin = runtimeFiles.find(file => file.file === 'mathlive.min.js');
if (mathliveMin?.exists && mathliveMin.bytes < 1024) {
  blockers.push('mathlive.min.js is too small to be treated as an official bundled runtime');
}

const packageJsonPath = path.join(vendorRoot, 'package.json');
const runtimeManifestPath = path.join(vendorRoot, 'runtime_manifest.json');
const projectManifestPath = path.join(projectRoot, 'assets', 'mathlive', 'manifest.json');
const packageJson = readJson(packageJsonPath, 'package.json', blockers);
const runtimeManifest = readJson(runtimeManifestPath, 'runtime_manifest.json', blockers);
const projectManifest = readJson(projectManifestPath, 'assets/mathlive/manifest.json', blockers);
const q90r4Report = readJson(q90r4ReportPath, 'tool/verify_mathlive_runtime_report.json', blockers);

if (!packageJson) blockers.push('package.json is missing');
if (packageJson && packageJson.name !== 'mathlive') blockers.push('package.json name is not mathlive');
if (packageJson && (typeof packageJson.version !== 'string' || packageJson.version.trim() === '')) {
  blockers.push('package.json version is missing');
}

if (!runtimeManifest) blockers.push('runtime_manifest.json is missing');
if (runtimeManifest) {
  if (runtimeManifest.packageSource !== 'npm') blockers.push('runtime_manifest.json packageSource is not npm');
  if (runtimeManifest.packageName !== 'mathlive') blockers.push('runtime_manifest.json packageName is not mathlive');
  if (runtimeManifest.runtimeBundled !== true) blockers.push('runtime_manifest.json runtimeBundled is not true');
  if (runtimeManifest.remoteScriptLoadingAllowed !== false) blockers.push('runtime_manifest.json remoteScriptLoadingAllowed must be false');
  if (runtimeManifest.mathLiveVirtualKeyboardEnabled !== false) blockers.push('runtime_manifest.json mathLiveVirtualKeyboardEnabled must be false');

  const manifestHashes = runtimeManifest.fileSha256 || runtimeManifest.fileHashes || null;
  if (!manifestHashes || typeof manifestHashes !== 'object' || Array.isArray(manifestHashes)) {
    blockers.push('runtime_manifest.json is missing fileSha256 hash evidence');
  } else {
    for (const file of runtimeFiles.filter(item => item.exists && item.file !== 'runtime_manifest.json')) {
      const expected = manifestHashes[file.file];
      if (typeof expected !== 'string' || expected.trim() === '') {
        blockers.push(`runtime_manifest.json missing sha256 for ${file.file}`);
      } else if (expected !== file.sha256) {
        blockers.push(`runtime_manifest.json sha256 mismatch for ${file.file}`);
      }
    }
  }
}

if (!projectManifest) blockers.push('assets/mathlive/manifest.json is missing');
if (projectManifest) {
  if (projectManifest.remoteScriptLoadingAllowed !== false) blockers.push('project manifest allows remote script loading');
  if (projectManifest.cdnDependencyAllowed !== false) blockers.push('project manifest allows CDN dependency');
  if (projectManifest.mathLiveVirtualKeyboardEnabled !== false) blockers.push('project manifest enables MathLive virtual keyboard');
  if (projectManifest.mainEditorSwitchAllowed !== false) blockers.push('project manifest allows main editor switch');
  if (projectManifest.legacyCursorPhysicalDeletionAllowed === true) blockers.push('project manifest allows legacy cursor physical deletion');
}

if (!q90r4Report || q90r4Report.installVerified !== true) {
  blockers.push('Q90R4 runtime verification report is not PASS');
}
if (q90r4Report?.mainEditorSwitchAllowed === true) blockers.push('Q90R4 report illegally allows main editor switch');
if (q90r4Report?.cursorPassClaimed === true) blockers.push('Q90R4 report illegally claims cursor PASS');

const ready = blockers.length === 0;
const report = {
  phase: 'V172-Q100',
  status: ready
    ? 'MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSED_FOR_SMOKE_EVIDENCE'
    : 'BLOCKED_MATHLIVE_OFFICIAL_RUNTIME_BUNDLE_CLOSURE',
  generatedAt: new Date().toISOString(),
  officialRuntimeBundleClosed: ready,
  mayRunLabSmokeEvidence: ready,
  mayClaimCursorPass: false,
  maySwitchMainEditor: false,
  mayEnableMathLiveByDefault: false,
  mayDeleteLegacyCursor: false,
  remoteScriptLoadingAllowed: false,
  mathLiveVirtualKeyboardEnabled: false,
  protectedUiSurfaceMutationAllowed: false,
  graphHistorySolutionUiMutationAllowed: false,
  blockers,
  vendorRoot: rel(vendorRoot),
  runtimeFiles,
  packageJson: packageJson ? { name: packageJson.name ?? null, version: packageJson.version ?? null } : null,
  runtimeManifest: runtimeManifest ? {
    packageName: runtimeManifest.packageName ?? null,
    packageVersion: runtimeManifest.packageVersion ?? null,
    packageSource: runtimeManifest.packageSource ?? null,
    runtimeBundled: runtimeManifest.runtimeBundled ?? null,
    remoteScriptLoadingAllowed: runtimeManifest.remoteScriptLoadingAllowed ?? null,
    mathLiveVirtualKeyboardEnabled: runtimeManifest.mathLiveVirtualKeyboardEnabled ?? null,
    hasFileSha256: Boolean(runtimeManifest.fileSha256 || runtimeManifest.fileHashes),
  } : null,
  q90r4RuntimeReport: q90r4Report,
};

writeFileSync(jsonReportPath, `${JSON.stringify(report, null, 2)}\n`, 'utf8');
const md = [
  '# V172-Q100 MathLive Official Runtime Bundle Closure Report',
  '',
  `- Status: ${report.status}`,
  `- Generated: ${report.generatedAt}`,
  `- officialRuntimeBundleClosed: ${ready}`,
  '- mayRunLabSmokeEvidence: ' + String(ready),
  '- mayClaimCursorPass: false',
  '- maySwitchMainEditor: false',
  '- mayEnableMathLiveByDefault: false',
  '- mayDeleteLegacyCursor: false',
  '',
  '## Blockers',
  ...(blockers.length ? blockers.map(item => `- ${item}`) : ['- none']),
  '',
  '## Runtime files',
  ...runtimeFiles.map(file => `- ${file.path}: ${file.exists ? `PRESENT (${file.bytes} bytes)` : 'MISSING'}`),
  '',
].join('\n');
writeFileSync(mdReportPath, md, 'utf8');

console.log(JSON.stringify({
  phase: report.phase,
  status: report.status,
  jsonReportPath: rel(jsonReportPath),
  mdReportPath: rel(mdReportPath),
  blockers: blockers.length,
  mayRunLabSmokeEvidence: ready,
  mayClaimCursorPass: false,
  maySwitchMainEditor: false,
  mayDeleteLegacyCursor: false,
}, null, 2));

process.exit(ready ? 0 : 2);
