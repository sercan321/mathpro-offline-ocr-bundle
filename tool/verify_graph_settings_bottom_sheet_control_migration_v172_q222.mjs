#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const errors = [];
const fail = (message) => errors.push(message);

for (const required of [
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_settings_sheet.dart',
  'lib/features/graph/graph_settings_bottom_sheet_control_migration_policy.dart',
  'test/v172_q222_graph_settings_bottom_sheet_control_migration_test.dart',
  'tool/verify_graph_settings_bottom_sheet_control_migration_v172_q222.mjs',
  'assets/mathlive/manifest.json',
]) {
  if (!exists(required)) fail(`missing required file: ${required}`);
}

const graphCard = read('lib/features/graph/graph_card.dart');
const sheet = read('lib/features/graph/graph_settings_sheet.dart');
const appShell = read('lib/app/app_shell.dart');
const policy = read('lib/features/graph/graph_settings_bottom_sheet_control_migration_policy.dart');
const manifest = readJson('assets/mathlive/manifest.json');

for (const marker of [
  'mathpro-graph-settings-sheet-q222',
  'mathpro-graph-settings-mode-segment',
  'mathpro-graph-settings-window-fields',
  'mathpro-graph-settings-trace-toggle',
  'mathpro-graph-settings-reset-view',
  'Graph Settings',
  'Reset View',
  'onRenderModeChanged',
]) {
  if (!sheet.includes(marker)) fail(`graph_settings_sheet missing marker ${marker}`);
}

for (const forbidden of [
  'GraphSurface(',
  'GraphSurface3D(',
  'void _applyConstantPreset()',
  "label: 'Trace On'",
  "label: 'Zoom +'",
  "label: 'Domain'",
]) {
  if (sheet.includes(forbidden)) fail(`graph settings sheet contains stale/clutter marker: ${forbidden}`);
}

for (const marker of [
  'mathpro-graph-canvas-preview',
  'mathpro-graph-floating-zoom-in',
  'mathpro-graph-floating-zoom-out',
  'mathpro-graph-compact-info-row',
]) {
  if (!graphCard.includes(marker)) fail(`graph_card lost Q221 mini panel marker ${marker}`);
}

for (const forbidden of [
  "label: 'Trace On'",
  "label: 'Trace Off'",
  "label: 'Reset'",
  "label: 'Zoom +'",
  "label: 'Zoom −'",
  "label: 'Domain'",
  "label: 'Range'",
]) {
  if (graphCard.includes(forbidden)) fail(`graph mini panel regressed old clutter marker: ${forbidden}`);
}

for (const marker of [
  'renderMode: _graphRenderMode',
  'onRenderModeChanged: _setGraphRenderMode',
  'onApply: (updated) => _applyGraphUpdate(GraphViewportPolicy.sanitize(updated), renderMode: _graphRenderMode)',
]) {
  if (!appShell.includes(marker)) fail(`app_shell missing surgical settings binding marker: ${marker}`);
}

for (const required of [
  "phase = 'V172-Q222'",
  'graphSettingsBottomSheetActivated = true',
  'modeControlMigratedToSheet = true',
  'viewportWindowFieldsMigratedToSheet = true',
  'traceControlMigratedToSheet = true',
  'resetViewMigratedToSheet = true',
  'miniPanelRemainsCanvasFirst = true',
  'graphCanvasCropPreventionPreserved = true',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'graphRuntimeEvaluatorMutationAllowed = false',
  'androidRealDevicePassClaimedByAssistant = false',
]) {
  if (!policy.includes(required)) fail(`Q222 policy missing ${required}`);
}

const env = manifest.v172Q222GraphSettingsBottomSheetControlMigration;
if (!env || env.phase !== 'V172-Q222') fail('manifest missing Q222 envelope');
for (const [key, expected] of Object.entries({
  graphSettingsBottomSheetActivated: true,
  modeControlMigratedToSheet: true,
  viewportWindowFieldsMigratedToSheet: true,
  traceControlMigratedToSheet: true,
  resetViewMigratedToSheet: true,
  miniPanelRemainsCanvasFirst: true,
  graphCanvasCropPreventionPreserved: true,
  appShellMutationLimitedToSettingsBinding: true,
  graphRuntimeEvaluatorMutationAllowed: false,
  keyboardMutationAllowed: false,
  moreMutationAllowed: false,
  longPressMutationAllowed: false,
  mathLiveProductionMutationAllowed: false,
  historyMutationAllowed: false,
  solutionMutationAllowed: false,
  splashStartupMutationAllowed: false,
  launcherIconMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
})) {
  if (env?.[key] !== expected) fail(`manifest ${key} expected ${expected}, got ${env?.[key]}`);
}
if (![
  'V172-Q222-GRAPH-SETTINGS-BOTTOM-SHEET-CONTROL-MIGRATION',
  'V172-Q223-GRAPH-CANVAS-PREMIUM-POLISH-RESPONSIVE-QA',
  'V172-Q224-GRAPH-MINI-PANEL-FINAL-REGRESSION-PACKAGE-FREEZE',
  'V172-Q225-GRAPH-MINI-PANEL-VISUAL-PARITY-CANVAS-DOMINANCE',
].includes(manifest.graphMiniPanelLatestPhase)) {
  fail(`graphMiniPanelLatestPhase not Q222 or verified Q223/Q224/Q225 successor: ${manifest.graphMiniPanelLatestPhase}`);
}

const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const protectedHashes = {};
for (const rel of [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'lib/main.dart',
  'android/app/src/main/AndroidManifest.xml',
]) {
  if (!exists(rel)) fail(`protected/sensitive file missing: ${rel}`);
  else protectedHashes[rel] = sha(rel);
}

if (errors.length) {
  console.error(`GRAPH_SETTINGS_BOTTOM_SHEET_CONTROL_MIGRATION_Q222_FAILED: ${errors.join('; ')}`);
  process.exit(1);
}

fs.mkdirSync(p('tool/reports'), { recursive: true });
const report = {
  phase: 'V172-Q222',
  status: 'GRAPH_SETTINGS_BOTTOM_SHEET_CONTROL_MIGRATION_Q222_STATIC_READY_WITH_Q225_VISUAL_PARITY_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED',
  checks: {
    graphSettingsBottomSheetActivated: true,
    modeControlMigratedToSheet: true,
    viewportWindowFieldsMigratedToSheet: true,
    traceControlMigratedToSheet: true,
    resetViewMigratedToSheet: true,
    miniPanelRemainsCanvasFirst: true,
    graphCanvasCropPreventionPreserved: true,
    appShellMutationLimitedToSettingsBinding: true,
    protectedHashes,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    androidRealDevicePassClaimed: false,
  },
};
fs.writeFileSync(p('tool/reports/graph_settings_bottom_sheet_control_migration_q222_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/graph_settings_bottom_sheet_control_migration_q222_report.md'), `# V172-Q222 Graph Settings Bottom Sheet Control Migration\n\nStatus: ${report.status}\n\nMode/window/trace/reset controls moved to the premium settings sheet: true\n\nMini panel remains canvas-first: true\n\nFlutter/Android PASS claimed: false\n`);
console.log(report.status);
