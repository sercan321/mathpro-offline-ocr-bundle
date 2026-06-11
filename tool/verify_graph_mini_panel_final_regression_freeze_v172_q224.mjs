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
  'lib/features/graph/graph_surface.dart',
  'lib/features/graph/graph_painter.dart',
  'lib/features/graph/graph_style.dart',
  'lib/features/graph/graph_mini_panel_layout_simplification_policy.dart',
  'lib/features/graph/graph_settings_bottom_sheet_control_migration_policy.dart',
  'lib/features/graph/graph_canvas_premium_polish_policy.dart',
  'lib/features/graph/graph_mini_panel_final_regression_freeze_policy.dart',
  'test/v172_q224_graph_mini_panel_final_regression_freeze_test.dart',
  'tool/verify_graph_mini_panel_final_regression_freeze_v172_q224.mjs',
  'assets/mathlive/manifest.json',
]) {
  if (!exists(required)) fail(`missing required file: ${required}`);
}

const graphCard = read('lib/features/graph/graph_card.dart');
const settingsSheet = read('lib/features/graph/graph_settings_sheet.dart');
const graphSurface = read('lib/features/graph/graph_surface.dart');
const graphPainter = read('lib/features/graph/graph_painter.dart');
const graphStyle = read('lib/features/graph/graph_style.dart');
const q224Policy = read('lib/features/graph/graph_mini_panel_final_regression_freeze_policy.dart');
const q221Policy = read('lib/features/graph/graph_mini_panel_layout_simplification_policy.dart');
const q222Policy = read('lib/features/graph/graph_settings_bottom_sheet_control_migration_policy.dart');
const q223Policy = read('lib/features/graph/graph_canvas_premium_polish_policy.dart');
const manifest = readJson('assets/mathlive/manifest.json');

for (const marker of [
  'mathpro-premium-graph-card',
  'mathpro-graph-canvas-preview',
  'mathpro-graph-canvas-fit-guard-q223',
  'canvasPixelTight',
  'pixelTight: canvasPixelTight',
  'mathpro-graph-2d-3d-elite-toggle',
  'mathpro-graph-floating-zoom-out',
  'mathpro-graph-floating-zoom-in',
  'mathpro-graph-compact-info-row',
  'mathpro-graph-window-summary',
]) {
  if (!graphCard.includes(marker)) fail(`graph_card missing freeze marker: ${marker}`);
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
  if (graphCard.includes(forbidden)) fail(`graph mini panel regressed stale clutter marker: ${forbidden}`);
}

for (const marker of [
  'mathpro-graph-settings-sheet-q222',
  'mathpro-graph-settings-mode-segment',
  'mathpro-graph-settings-window-fields',
  'mathpro-graph-settings-trace-toggle',
  'mathpro-graph-settings-reset-view',
  'Reset View',
]) {
  if (!settingsSheet.includes(marker)) fail(`settings sheet missing Q222 freeze marker: ${marker}`);
}

for (const marker of [
  'premiumSurfaceGradient',
  'GraphPainter(expression: expression, compact: compact, pixelTight: pixelTight)',
]) {
  if (!graphSurface.includes(marker)) fail(`graph_surface missing Q223 freeze marker: ${marker}`);
}

for (const marker of [
  'final bool pixelTight;',
  'samples: pixelTight ? 96',
  'if (compact || pixelTight || plotRect.height < 52 || plotRect.width < 104) return;',
  'if (compact || pixelTight || plotRect.height < 52 || plotRect.width < 104) return;',
]) {
  if (!graphPainter.includes(marker)) fail(`graph_painter missing Q223 freeze marker: ${marker}`);
}

for (const marker of [
  'premiumSurfaceGradient',
  'Color(0xFF10171A)',
  'Color(0xFF080D0F)',
  'Color(0xFF040607)',
]) {
  if (!graphStyle.includes(marker)) fail(`graph_style missing premium canvas marker: ${marker}`);
}

for (const marker of [
  'largeDomainRangePillsRemovedFromMiniPanel = true',
  'textTraceResetZoomButtonsRemovedFromMiniPanel = true',
  'graphPreviewScalesInsteadOfCroppingWhenTight = true',
]) {
  if (!q221Policy.includes(marker)) fail(`Q221 policy missing active contract: ${marker}`);
}
for (const marker of [
  'graphSettingsBottomSheetActivated = true',
  'traceControlMigratedToSheet = true',
  'resetViewMigratedToSheet = true',
  'miniPanelRemainsCanvasFirst = true',
]) {
  if (!q222Policy.includes(marker)) fail(`Q222 policy missing active contract: ${marker}`);
}
for (const marker of [
  'graphCanvasPremiumPolished = true',
  'pixelTightCanvasFitGuardAdded = true',
  'axisLabelsSuppressedWhenTooTight = true',
]) {
  if (!q223Policy.includes(marker)) fail(`Q223 policy missing active contract: ${marker}`);
}
for (const marker of [
  "phase = 'V172-Q224'",
  'finalRegressionFreezeAdded = true',
  'oldTextActionRailMustRemainAbsent = true',
  'largeDomainRangePillsMustRemainAbsent = true',
  'miniPanelMustRemainCanvasFirst = true',
  'settingsBottomSheetMustRemainSeparated = true',
  'floatingZoomControlsMustRemainInsideCanvas = true',
  'compactInfoRowMustRemainPresent = true',
  'graphPreviewMustScaleInsteadOfCroppingWhenTight = true',
  'premiumCanvasPolishMustRemainPresent = true',
  'graphRuntimeEvaluatorMutationAllowed = false',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'androidRealDevicePassClaimedByAssistant = false',
  'threeDGraphPassClaimedByAssistant = false',
]) {
  if (!q224Policy.includes(marker)) fail(`Q224 policy missing ${marker}`);
}

const env = manifest.v172Q224GraphMiniPanelFinalRegressionPackageFreeze;
if (!env || env.phase !== 'V172-Q224') fail('manifest missing Q224 envelope');
for (const [key, expected] of Object.entries({
  finalRegressionFreezeAdded: true,
  oldTextActionRailMustRemainAbsent: true,
  largeDomainRangePillsMustRemainAbsent: true,
  miniPanelMustRemainCanvasFirst: true,
  settingsBottomSheetMustRemainSeparated: true,
  floatingZoomControlsMustRemainInsideCanvas: true,
  compactInfoRowMustRemainPresent: true,
  graphPreviewMustScaleInsteadOfCroppingWhenTight: true,
  premiumCanvasPolishMustRemainPresent: true,
  noFakeThreeDPassClaimAllowed: true,
  graphRuntimeEvaluatorMutationAllowed: false,
  graphEligibilityMutationAllowed: false,
  graphFullscreenMutationAllowed: false,
  appShellMutationAllowed: false,
  keyboardMutationAllowed: false,
  moreMutationAllowed: false,
  longPressMutationAllowed: false,
  mathLiveProductionMutationAllowed: false,
  historyMutationAllowed: false,
  solutionMutationAllowed: false,
  splashStartupMutationAllowed: false,
  launcherIconMutationAllowed: false,
  solverMutationAllowed: false,
  cursorMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
  premiumVisualPassClaimedByAssistant: false,
  threeDGraphPassClaimedByAssistant: false,
})) {
  if (env?.[key] !== expected) fail(`manifest ${key} expected ${expected}, got ${env?.[key]}`);
}
const q224AcceptedLatestPhases = new Set([
  'V172-Q224-GRAPH-MINI-PANEL-FINAL-REGRESSION-PACKAGE-FREEZE',
  'V172-Q225-GRAPH-MINI-PANEL-VISUAL-PARITY-CANVAS-DOMINANCE',
]);
if (!q224AcceptedLatestPhases.has(manifest.graphMiniPanelLatestPhase)) {
  fail(`graphMiniPanelLatestPhase not Q224 or verified Q225 successor: ${manifest.graphMiniPanelLatestPhase}`);
}


const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const protectedFiles = [
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
  'android/app/src/main/res/values/styles.xml',
  'android/app/src/main/res/values-v31/styles.xml',
];
const protectedHashes = {};
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`protected/sensitive file missing: ${rel}`);
  else protectedHashes[rel] = sha(rel);
}

if (errors.length) {
  console.error(`GRAPH_MINI_PANEL_FINAL_REGRESSION_FREEZE_Q224_FAILED: ${errors.join('; ')}`);
  process.exit(1);
}

fs.mkdirSync(p('tool/reports'), { recursive: true });
const report = {
  phase: 'V172-Q224',
  status: 'GRAPH_MINI_PANEL_FINAL_REGRESSION_FREEZE_Q224_STATIC_READY_WITH_Q225_VISUAL_PARITY_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED',
  checks: {
    oldTextActionRailAbsent: true,
    largeDomainRangePillsAbsent: true,
    canvasFirstMiniPanelPreserved: true,
    separatedSettingsSheetPreserved: true,
    floatingZoomControlsInsideCanvas: true,
    compactInfoRowPresent: true,
    tightLayoutScalesInsteadOfCropping: true,
    premiumCanvasPolishPreserved: true,
    protectedHashes,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    androidRealDevicePassClaimed: false,
    premiumVisualPassClaimed: false,
    threeDGraphPassClaimed: false,
  },
};
fs.writeFileSync(p('tool/reports/graph_mini_panel_final_regression_freeze_q224_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/graph_mini_panel_final_regression_freeze_q224_report.md'), `# V172-Q224 Graph Mini Panel Final Regression / Package Freeze\n\nStatus: ${report.status}\n\nOld text action rail absent: true\n\nCanvas-first mini panel preserved: true\n\nSettings bottom sheet separated: true\n\nTight layout scales instead of cropping: true\n\nFlutter/Android/Premium PASS claimed: false\n`);
console.log(report.status);
