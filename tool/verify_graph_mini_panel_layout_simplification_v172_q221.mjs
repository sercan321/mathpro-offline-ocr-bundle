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
  'lib/features/graph/graph_surface.dart',
  'lib/features/graph/graph_surface_3d.dart',
  'lib/features/graph/graph_mini_panel_layout_simplification_policy.dart',
  'test/v172_q221_graph_mini_panel_layout_simplification_test.dart',
  'assets/mathlive/manifest.json',
]) {
  if (!exists(required)) fail(`missing required file: ${required}`);
}

const graphCard = read('lib/features/graph/graph_card.dart');
const policy = read('lib/features/graph/graph_mini_panel_layout_simplification_policy.dart');
const manifest = readJson('assets/mathlive/manifest.json');

for (const marker of [
  'mathpro-graph-canvas-preview',
  'mathpro-graph-floating-zoom-in',
  'mathpro-graph-floating-zoom-out',
  'mathpro-graph-compact-info-row',
  'GraphSurface(',
  'GraphSurface3D(',
  'LayoutBuilder(',
  'BoxFit.scaleDown',
]) {
  if (!graphCard.includes(marker)) fail(`graph_card missing marker ${marker}`);
}

for (const forbidden of [
  "label: 'Trace On'",
  "label: 'Trace Off'",
  "label: 'Reset'",
  "label: 'Zoom +'",
  "label: 'Zoom −'",
  "label: 'Domain'",
  "label: 'Range'",
  'class _GraphActions',
  'class _ActionChipButton',
  'class _ValuePill',
]) {
  if (graphCard.includes(forbidden)) fail(`graph mini panel still contains old clutter marker: ${forbidden}`);
}

for (const required of [
  "phase = 'V172-Q221'",
  'graphMiniPanelSimplified = true',
  'graphCanvasIsPrimaryVisualFocus = true',
  'largeDomainRangePillsRemovedFromMiniPanel = true',
  'textTraceResetZoomButtonsRemovedFromMiniPanel = true',
  'floatingZoomControlsAddedInsideCanvas = true',
  'compactBottomInfoRowAdded = true',
  'graphPreviewScalesInsteadOfCroppingWhenTight = true',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'androidRealDevicePassClaimedByAssistant = false',
]) {
  if (!policy.includes(required)) fail(`Q221 policy missing ${required}`);
}

const env = manifest.v172Q221GraphMiniPanelLayoutSimplification;
if (!env || env.phase !== 'V172-Q221') fail('manifest missing Q221 envelope');
for (const [key, expected] of Object.entries({
  graphMiniPanelSimplified: true,
  graphCanvasIsPrimaryVisualFocus: true,
  largeDomainRangePillsRemovedFromMiniPanel: true,
  textTraceResetZoomButtonsRemovedFromMiniPanel: true,
  floatingZoomControlsAddedInsideCanvas: true,
  compactBottomInfoRowAdded: true,
  graphPreviewScalesInsteadOfCroppingWhenTight: true,
  settingsSheetDeferredToNextPhase: true,
  graphRuntimeBehaviorMutationAllowed: false,
  keyboardMutationAllowed: false,
  moreMutationAllowed: false,
  longPressMutationAllowed: false,
  mathLiveProductionMutationAllowed: false,
  historyMutationAllowed: false,
  solutionMutationAllowed: false,
  appShellMutationAllowed: false,
  splashMutationAllowed: false,
  launcherIconMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
})) {
  if (env?.[key] !== expected) fail(`manifest ${key} expected ${expected}, got ${env?.[key]}`);
}

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
  'lib/app/app_shell.dart',
  'lib/main.dart',
  'android/app/src/main/AndroidManifest.xml',
]) {
  if (!exists(rel)) fail(`protected/sensitive file missing: ${rel}`);
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
  'lib/app/app_shell.dart',
]) protectedHashes[rel] = sha(rel);

if (errors.length) {
  console.error(`GRAPH_MINI_PANEL_LAYOUT_SIMPLIFICATION_Q221_FAILED: ${errors.join('; ')}`);
  process.exit(1);
}

fs.mkdirSync(p('tool/reports'), { recursive: true });
const report = {
  phase: 'V172-Q221',
  status: 'GRAPH_MINI_PANEL_LAYOUT_SIMPLIFICATION_Q221_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED',
  checks: {
    graphCanvasIsPrimaryVisualFocus: true,
    textActionClutterRemoved: true,
    compactInfoRowAdded: true,
    floatingZoomControlsAdded: true,
    graphPreviewScalesInsteadOfCroppingWhenTight: true,
    settingsSheetDeferredToQ222: true,
    protectedHashes,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    androidRealDevicePassClaimed: false,
  },
};
fs.writeFileSync(p('tool/reports/graph_mini_panel_layout_simplification_q221_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/graph_mini_panel_layout_simplification_q221_report.md'), `# V172-Q221 Graph Mini Panel Layout Simplification\n\nStatus: ${report.status}\n\nText-action clutter removed: true\n\nFloating zoom controls added: true\n\nFlutter/Android PASS claimed: false\n`);
console.log(report.status);
