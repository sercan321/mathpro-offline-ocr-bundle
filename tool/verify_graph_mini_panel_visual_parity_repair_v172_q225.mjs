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
  'lib/features/workspace/workspace_panel.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_models.dart',
  'lib/features/graph/graph_surface_3d.dart',
  'lib/features/graph/graph_settings_sheet.dart',
  'lib/features/graph/graph_mini_panel_visual_parity_repair_policy.dart',
  'test/v172_q225_graph_mini_panel_visual_parity_repair_test.dart',
  'tool/verify_graph_mini_panel_visual_parity_repair_v172_q225.mjs',
  'assets/mathlive/manifest.json',
]) {
  if (!exists(required)) fail(`missing required file: ${required}`);
}

const workspace = read('lib/features/workspace/workspace_panel.dart');
const graphCard = read('lib/features/graph/graph_card.dart');
const graphModels = read('lib/features/graph/graph_models.dart');
const graph3d = read('lib/features/graph/graph_surface_3d.dart');
const settingsSheet = read('lib/features/graph/graph_settings_sheet.dart');
const policy = read('lib/features/graph/graph_mini_panel_visual_parity_repair_policy.dart');
const manifest = readJson('assets/mathlive/manifest.json');

for (const marker of [
  'layoutHeight >= 420',
  '? 226.0',
  '? 212.0',
  '? 176.0',
  ': 148.0',
]) {
  if (!workspace.includes(marker)) fail(`workspace missing Q225 graph height marker: ${marker}`);
}
if (workspace.includes('compact ? 132.0 : 188.0')) fail('workspace still contains stale Q224 graphRequestedHeight 132/188');

for (const marker of [
  'Q225: canvas dominance pass',
  'final outerPadding = pixelTight ? 4.0',
  'final headerGap = pixelTight ? 2.0',
  'final infoGap = pixelTight ? 2.0',
  'height: tight ? 25 : compact ? 27 : 30',
  'final height = tight ? 18.0 : compact ? 20.0 : 22.0',
  'compact: canvasCompact || canvasPixelTight',
  'mathpro-graph-canvas-preview',
  'mathpro-graph-floating-zoom-out',
  'mathpro-graph-floating-zoom-in',
  'mathpro-graph-compact-info-row',
]) {
  if (!graphCard.includes(marker)) fail(`graph_card missing Q225 visual parity marker: ${marker}`);
}

for (const forbidden of [
  "label: 'Trace On'",
  "label: 'Trace Off'",
  "label: 'Reset'",
  "label: 'Zoom +'",
  "label: 'Zoom −'",
  "label: 'Domain'",
  "label: 'Range'",
  'class _ActionChipButton',
  'class _ValuePill',
]) {
  if (graphCard.includes(forbidden)) fail(`graph mini panel regressed stale clutter marker: ${forbidden}`);
}

for (const marker of [
  'this.traceEnabled = false',
  "traceEnabled: map['traceEnabled'] as bool? ?? false",
]) {
  if (!graphModels.includes(marker)) fail(`graph_models missing trace default clean-state marker: ${marker}`);
}

if (!graphCard.includes('renderMode == GraphRenderMode.twoD && expression.traceEnabled')) {
  fail('mini trace overlay must remain user/settings-gated by expression.traceEnabled');
}
if (!settingsSheet.includes('mathpro-graph-settings-trace-toggle')) fail('settings sheet trace toggle missing');

const q234SurfaceSuccessorActive = (
  graph3d.includes('surface-first 3D rendering') &&
  graph3d.includes('void _drawSurfaceFill') &&
  graph3d.includes('void _drawSparseMesh') &&
  (
    manifest.graphSurfaceColorHierarchyLatestPhase === 'V172-Q234-3D-GRAPH-SURFACE-COLOR-HIERARCHY' ||
    manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase === 'V172-Q234R1-GRAPH-SURFACE-COLOR-HIERARCHY-FINAL-HYGIENE' ||
    manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase === 'V172-Q234R2-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-HYGIENE' ||
    manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase === 'V172-Q234R3-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-FINAL-HYGIENE'
  )
);
for (const marker of [
  'GraphSurface3DPainter(expression: expression, compact: compact)',
  'if (!compact && rect.width >= 150 && rect.height >= 92)',
  'if (!compact) {',
]) {
  if (!graph3d.includes(marker)) fail(`graph_surface_3d missing Q225 compact text/fit marker: ${marker}`);
}
if (!graph3d.includes('3D surface için geçerli örnek üretilemedi') && !q234SurfaceSuccessorActive) {
  fail('graph_surface_3d missing Q225 compact unavailable marker and no Q234 surface successor was detected');
}
if (q234SurfaceSuccessorActive && !graph3d.includes('3D örnek üretilemedi')) {
  fail('Q234 surface successor active but compact-safe unavailable copy marker is missing');
}

for (const marker of [
  "phase = 'V172-Q225'",
  'canvasDominanceRepairAdded = true',
  'normalGraphCardHeightRaised = true',
  'compactGraphCardHeightRaised = true',
  'traceDefaultCleanStateAdded = true',
  'miniPanelTraceOverlayDefaultOff = true',
  'threeDMiniSurfaceCompactBindingAdded = true',
  'threeDCompactTextClutterSuppressed = true',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'threeDGraphPassClaimedByAssistant = false',
]) {
  if (!policy.includes(marker)) fail(`Q225 policy missing ${marker}`);
}

const env = manifest.v172Q225GraphMiniPanelVisualParityRepair;
if (!env || env.phase !== 'V172-Q225') fail('manifest missing Q225 envelope');
for (const [key, expected] of Object.entries({
  canvasDominanceRepairAdded: true,
  normalGraphCardHeightRaised: true,
  compactGraphCardHeightRaised: true,
  headerChromeThinnedForCanvasDominance: true,
  infoRowChromeThinnedForCanvasDominance: true,
  graphPreviewMustRemainUncroppedWhenTight: true,
  traceDefaultCleanStateAdded: true,
  miniPanelTraceOverlayDefaultOff: true,
  traceStillControlledFromSettingsSheet: true,
  threeDMiniSurfaceCompactBindingAdded: true,
  threeDCompactTextClutterSuppressed: true,
  noFakeThreeDPassClaimAllowed: true,
  graphRuntimeEvaluatorMutationAllowed: false,
  graphEligibilityMutationAllowed: false,
  graphFullscreenRuntimeMutationAllowed: false,
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
if (manifest.graphMiniPanelLatestPhase !== 'V172-Q225-GRAPH-MINI-PANEL-VISUAL-PARITY-CANVAS-DOMINANCE') {
  fail(`graphMiniPanelLatestPhase not advanced to Q225: ${manifest.graphMiniPanelLatestPhase}`);
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
  console.error(`GRAPH_MINI_PANEL_VISUAL_PARITY_REPAIR_Q225_FAILED: ${errors.join('; ')}`);
  process.exit(1);
}

fs.mkdirSync(p('tool/reports'), { recursive: true });
const report = {
  phase: 'V172-Q225',
  status: q234SurfaceSuccessorActive
    ? 'GRAPH_MINI_PANEL_VISUAL_PARITY_REPAIR_Q225_STATIC_READY_WITH_Q234_SURFACE_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED'
    : 'GRAPH_MINI_PANEL_VISUAL_PARITY_REPAIR_Q225_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED',
  checks: {
    canvasDominanceRepairAdded: true,
    traceDefaultCleanStateAdded: true,
    threeDMiniSurfaceCompactBindingAdded: true,
    q234SurfaceSuccessorAccepted: q234SurfaceSuccessorActive,
    protectedHashes,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    androidRealDevicePassClaimed: false,
    premiumVisualPassClaimed: false,
    threeDGraphPassClaimed: false,
  },
};
fs.writeFileSync(p('tool/reports/graph_mini_panel_visual_parity_repair_q225_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/graph_mini_panel_visual_parity_repair_q225_report.md'), `# V172-Q225 Graph Mini Panel Visual Parity Repair / Canvas Dominance Pass\n\nStatus: ${report.status}\n\nCanvas dominance repair: true\n\nTrace default clean state: true\n\n3D mini compact binding: true\n\nQ234/Q234R1 surface successor accepted: ${q234SurfaceSuccessorActive}\n\nFlutter/Android/Premium PASS claimed: false\n`);
console.log(report.status);
