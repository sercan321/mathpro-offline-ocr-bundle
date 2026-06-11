#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';

const root = process.cwd();
const read = (p) => fs.readFileSync(path.join(root, p), 'utf8');
const exists = (p) => fs.existsSync(path.join(root, p));
const blockers = [];
function requireFile(p) { if (!exists(p)) blockers.push(`Missing required file: ${p}`); }
function requireContains(p, needle) {
  const body = read(p);
  if (!body.includes(needle)) blockers.push(`${p} missing marker: ${needle}`);
}
function requireNotContains(p, needle) {
  const body = read(p);
  if (body.includes(needle)) blockers.push(`${p} contains forbidden marker: ${needle}`);
}

const files = [
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'assets/mathlive/main_editor.html',
  'assets/mathlive/mathlive_bridge.js',
  'lib/app/app_shell.dart',
  'lib/features/workspace/workspace_panel.dart',
  'lib/features/workspace/editor_viewport.dart',
];
files.forEach(requireFile);

if (blockers.length === 0) {
  requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', "static const String phase = 'V172-Q134'");
  requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', 'mathpro-main-mathlive-runtime-blocked-panel');
  requireContains('lib/features/mathlive/mathlive_main_editor_surface.dart', 'Q134 — Main Editor MathLive Hard-Mount Runtime Surface');
  requireContains('assets/mathlive/main_editor.html', 'MathLive runtime bekleniyor');
  requireContains('assets/mathlive/main_editor.html', 'contenteditable="false"');
  requireNotContains('assets/mathlive/main_editor.html', 'contenteditable="true"');
  requireContains('assets/mathlive/mathlive_bridge.js', 'function focusMathfield()');
  requireContains('assets/mathlive/mathlive_bridge.js', 'MathLive runtime eksik');
  requireContains('assets/mathlive/mathlive_bridge.js', 'mathLiveMountedInMainWorkspaceByDefault: mainEditorMode');
  requireContains('assets/mathlive/mathlive_bridge.js', 'mainEditorSwitchAllowed: mainEditorMode');
  requireContains('lib/app/app_shell.dart', 'bool _useMathLiveMainEditor = true;');
  requireContains('lib/features/workspace/workspace_panel.dart', 'MathLiveMainEditorSurface(');
  requireContains('lib/features/workspace/workspace_panel.dart', ': EditorViewport(');
  requireContains('lib/features/workspace/editor_viewport.dart', 'class EditorViewport');
}

const status = blockers.length === 0
  ? 'Q134_MAIN_EDITOR_MATHLIVE_HARD_MOUNT_PACKAGE_READY_BUT_DEVICE_EVIDENCE_REQUIRED'
  : 'BLOCKED_Q134_MAIN_EDITOR_MATHLIVE_HARD_MOUNT';
const report = {
  phase: 'V172-Q134',
  status,
  packageReady: blockers.length === 0,
  evidenceComplete: false,
  blockers,
  activeVisibleEditor: 'mathliveMainEditorHardMount',
  fallbackLegacyEditorStillPresent: exists('lib/features/workspace/editor_viewport.dart'),
  legacyCursorPhysicalDeletionImplemented: false,
  mathLiveEnabledByDefaultForMainSurface: true,
  runtimeMustBeInstalledBeforeDeviceValidation: true,
  ifOfficialRuntimeMissingExpectedVisibleState: 'MathLive runtime eksik — node tool/install_mathlive_runtime.mjs çalıştırılmalı',
  mayClaimCursorPass: false,
  mayClaimReleasePass: false,
};
fs.mkdirSync(path.join(root, 'tool/reports'), { recursive: true });
fs.writeFileSync(path.join(root, 'tool/reports/main_editor_mathlive_hard_mount_v172_q134_report.json'), JSON.stringify(report, null, 2) + '\n');
console.log(JSON.stringify(report, null, 2));
process.exit(blockers.length === 0 ? 0 : 1);
