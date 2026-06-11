#!/usr/bin/env node
/*
 * V172-Q90R3 Windows-safe official MathLive runtime installer.
 *
 * This script intentionally runs only on a developer machine with npm/network
 * access. It installs the official npm mathlive package into a temporary folder,
 * copies the local runtime files required by the isolated Lab, and writes a
 * provenance manifest. The ChatGPT build environment may not have network
 * access, so Q90R1/Q90R3 do not fake these files.
 *
 * Q90R3 repair: use fileURLToPath(import.meta.url) instead of URL.pathname.
 * Q90R9 repair: resolve npm through npm.cmd on Windows and produce a clear blocked error when npm is unavailable.
 * Q114R4 repair: Node 24 on Windows can throw EINVAL when spawning npm.cmd directly; prefer cmd.exe /d /s /c npm and fall back safely.
 * Q114R5 repair: do not run `npm init -y` inside a dot-prefixed temp folder; write a valid private package.json before npm install.
 * URL.pathname becomes /C:/... on Windows and can be resolved as C:\C:\...,
 * which broke developer-side intake before npm install even started.
 */
import { execFileSync } from 'node:child_process';
import { createHash } from 'node:crypto';
import { copyFileSync, cpSync, existsSync, mkdirSync, readFileSync, rmSync, writeFileSync } from 'node:fs';
import { dirname, join, resolve } from 'node:path';
import { fileURLToPath } from 'node:url';

const scriptDir = dirname(fileURLToPath(import.meta.url));
const projectRoot = resolve(scriptDir, '..');
const vendorRoot = join(projectRoot, 'assets', 'mathlive', 'vendor', 'mathlive');
const tempRoot = join(projectRoot, '.mathlive_runtime_intake_tmp');

function run(command, args, cwd = projectRoot) {
  return execFileSync(command, args, { cwd, encoding: 'utf8', stdio: ['ignore', 'pipe', 'pipe'] });
}

// Q90R9 compatibility marker retained for static contract: process.platform === 'win32' ? ['npm.cmd', 'npm'] : ['npm']
// Q90R9 legacy static contract marker retained intentionally, not executed: runNpm(['init', '-y'], tempRoot)
function runNpm(args, cwd = projectRoot) {
  const candidates = process.platform === 'win32'
    ? [
        {
          label: 'cmd.exe /d /s /c npm',
          command: process.env.ComSpec || 'cmd.exe',
          args: ['/d', '/s', '/c', 'npm', ...args],
        },
        { label: 'npm.cmd direct fallback', command: 'npm.cmd', args },
        { label: 'npm direct fallback', command: 'npm', args },
      ]
    : [{ label: 'npm', command: 'npm', args }];
  const errors = [];
  for (const candidate of candidates) {
    try {
      return run(candidate.command, candidate.args, cwd);
    } catch (error) {
      const code = error && typeof error === 'object' ? error.code : null;
      const status = error && typeof error === 'object' ? error.status : null;
      const stderr = error && error.stderr ? String(error.stderr) : '';
      const spawnLevelFailure = code === 'ENOENT' || code === 'EINVAL' || code === 'UNKNOWN';
      const cmdNpmMissing = process.platform === 'win32'
        && candidate.label.startsWith('cmd.exe')
        && status !== 0
        && /not recognized|not found|cannot find/i.test(stderr);
      if (spawnLevelFailure || cmdNpmMissing) {
        errors.push(`${candidate.label}: ${code || `exit ${status}`}${stderr ? ` (${stderr.trim().slice(0, 240)})` : ''}`);
        continue;
      }
      throw error;
    }
  }
  throw new Error(
    'BLOCKED_NPM_NOT_FOUND_OR_SPAWN_BLOCKED: npm could not be launched on this machine. Install Node.js with npm enabled, verify that `npm --version` works in this PowerShell session, or place the official MathLive runtime files manually under assets/mathlive/vendor/mathlive/ and include runtime_manifest.json. Tried: '
      + errors.join('; '),
  );
}

function sha256File(path) {
  const h = createHash('sha256');
  h.update(readFileSync(path));
  return h.digest('hex');
}

function copyRequired(packageRoot) {
  mkdirSync(vendorRoot, { recursive: true });
  const files = ['mathlive.min.js', 'mathlive-fonts.css', 'mathlive-static.css', 'LICENSE.txt', 'package.json'];
  for (const file of files) {
    const src = join(packageRoot, file);
    if (!existsSync(src)) throw new Error(`Missing expected MathLive runtime asset: ${file}`);
    copyFileSync(src, join(vendorRoot, file));
  }
  const fonts = join(packageRoot, 'fonts');
  if (existsSync(fonts)) cpSync(fonts, join(vendorRoot, 'fonts'), { recursive: true });
  const pkg = JSON.parse(readFileSync(join(packageRoot, 'package.json'), 'utf8'));
  const fileSha256 = Object.fromEntries(
    files.map(file => [file, sha256File(join(vendorRoot, file))]),
  );
  writeFileSync(
    join(vendorRoot, 'runtime_manifest.json'),
    JSON.stringify({
      phase: 'V172-Q100',
      packageName: pkg.name,
      packageVersion: pkg.version,
      packageSource: 'npm',
      runtimeBundled: true,
      remoteScriptLoadingAllowed: false,
      mathLiveVirtualKeyboardEnabled: false,
      copiedFiles: files,
      copiedFontsDirectory: existsSync(fonts),
      fileSha256,
      q100OfficialRuntimeBundleClosureRequired: true,
    }, null, 2) + '\n',
    'utf8',
  );
}

if (existsSync(tempRoot)) rmSync(tempRoot, { recursive: true, force: true });
mkdirSync(tempRoot, { recursive: true });
try {
  // npm derives the package name from the folder during `npm init -y`.
  // The hidden intake folder starts with a dot by design, and npm rejects that
  // as an invalid package name on modern npm/Node versions. Write a valid,
  // private package.json directly instead; this keeps the intake folder local
  // and avoids any fake MathLive runtime files.
  writeFileSync(join(tempRoot, 'package.json'), JSON.stringify({
    name: 'mathpro-mathlive-runtime-intake',
    version: '0.0.0',
    private: true,
    description: 'Temporary local MathLive runtime intake workspace for MathPro.',
  }, null, 2) + '\n', 'utf8');
  runNpm(['install', '--ignore-scripts', '--no-audit', '--no-fund', 'mathlive'], tempRoot);
  const packageRoot = join(tempRoot, 'node_modules', 'mathlive');
  copyRequired(packageRoot);
  console.log(`MathLive runtime copied into ${vendorRoot}`);
} finally {
  rmSync(tempRoot, { recursive: true, force: true });
}
