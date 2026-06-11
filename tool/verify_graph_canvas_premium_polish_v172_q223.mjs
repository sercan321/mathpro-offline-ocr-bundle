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
  'lib/features/graph/graph_painter.dart',
  'lib/features/graph/graph_style.dart',
  'lib/features/graph/graph_canvas_premium_polish_policy.dart',
  'test/v172_q223_graph_canvas_premium_polish_responsive_qa_test.dart',
  'tool/verify_graph_canvas_premium_polish_v172_q223.mjs',
  'assets/mathlive/manifest.json',
]) {
  if (!exists(required)) fail(`missing required file: ${required}`);
}

const graphCard = read('lib/features/graph/graph_card.dart');
const graphSurface = read('lib/features/graph/graph_surface.dart');
const graphPainter = read('lib/features/graph/graph_painter.dart');
const graphStyle = read('lib/features/graph/graph_style.dart');
const policy = read('lib/features/graph/graph_canvas_premium_polish_policy.dart');
const manifest = readJson('assets/mathlive/manifest.json');

for (const marker of [
  'mathpro-graph-canvas-fit-guard-q223',
  'canvasPixelTight',
  'pixelTight: canvasPixelTight',
  'mathpro-graph-canvas-preview',
  'mathpro-graph-floating-zoom-in',
  'mathpro-graph-floating-zoom-out',
  'mathpro-graph-compact-info-row',
]) {
  if (!graphCard.includes(marker)) fail(`graph_card missing Q223 marker: ${marker}`);
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
  'this.pixelTight = false',
  'premiumSurfaceGradient',
  'GraphPainter(expression: expression, compact: compact, pixelTight: pixelTight)',
]) {
  if (!graphSurface.includes(marker)) fail(`graph_surface missing Q223 marker: ${marker}`);
}

for (const marker of [
  'this.pixelTight = false',
  'final bool pixelTight;',
  'final tightCanvas = pixelTight || size.height < 92 || size.width < 220;',
  'samples: pixelTight ? 96',
  'if (compact || pixelTight || plotRect.height < 52 || plotRect.width < 104) return;',
  'oldDelegate.pixelTight != pixelTight',
]) {
  if (!graphPainter.includes(marker)) fail(`graph_painter missing Q223 marker: ${marker}`);
}

for (const marker of [
  'premiumSurfaceGradient',
  'Color(0xFF10171A)',
  'Color(0xFF080D0F)',
  'Color(0xFF040607)',
]) {
  if (!graphStyle.includes(marker)) fail(`graph_style missing premium surface marker: ${marker}`);
}

for (const required of [
  "phase = 'V172-Q223'",
  'graphCanvasPremiumPolished = true',
  'premiumSurfaceGradientAdded = true',
  'pixelTightCanvasFitGuardAdded = true',
  'graphPreviewScalesInsteadOfCroppingWhenTight = true',
  'floatingZoomControlsScaleDownWhenTight = true',
  'gridAxisCurveVisualBalancePolished = true',
  'axisLabelsSuppressedWhenTooTight = true',
  'graphRuntimeEvaluatorMutationAllowed = false',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'androidRealDevicePassClaimedByAssistant = false',
]) {
  if (!policy.includes(required)) fail(`Q223 policy missing ${required}`);
}

const env = manifest.v172Q223GraphCanvasPremiumPolishResponsiveQa;
if (!env || env.phase !== 'V172-Q223') fail('manifest missing Q223 envelope');
for (const [key, expected] of Object.entries({
  graphCanvasPremiumPolished: true,
  premiumSurfaceGradientAdded: true,
  pixelTightCanvasFitGuardAdded: true,
  graphPreviewScalesInsteadOfCroppingWhenTight: true,
  floatingZoomControlsScaleDownWhenTight: true,
  gridAxisCurveVisualBalancePolished: true,
  axisLabelsSuppressedWhenTooTight: true,
  miniPanelRemainsCanvasFirst: true,
  settingsSheetPreserved: true,
  graphRuntimeEvaluatorMutationAllowed: false,
  graphEligibilityMutationAllowed: false,
  appShellMutationAllowed: false,
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
  'V172-Q223-GRAPH-CANVAS-PREMIUM-POLISH-RESPONSIVE-QA',
  'V172-Q224-GRAPH-MINI-PANEL-FINAL-REGRESSION-PACKAGE-FREEZE',
  'V172-Q225-GRAPH-MINI-PANEL-VISUAL-PARITY-CANVAS-DOMINANCE',
].includes(manifest.graphMiniPanelLatestPhase)) {
  fail(`graphMiniPanelLatestPhase not Q223 or verified Q224/Q225 successor: ${manifest.graphMiniPanelLatestPhase}`);
}

const forbiddenTouched = [
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
];
const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const protectedHashes = {};
for (const rel of forbiddenTouched) {
  if (!exists(rel)) fail(`protected/sensitive file missing: ${rel}`);
  else protectedHashes[rel] = sha(rel);
}

if (errors.length) {
  console.error(`GRAPH_CANVAS_PREMIUM_POLISH_Q223_FAILED: ${errors.join('; ')}`);
  process.exit(1);
}

fs.mkdirSync(p('tool/reports'), { recursive: true });
const report = {
  phase: 'V172-Q223',
  status: 'GRAPH_CANVAS_PREMIUM_POLISH_Q223_STATIC_READY_WITH_Q225_VISUAL_PARITY_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED',
  checks: {
    graphCanvasPremiumPolished: true,
    premiumSurfaceGradientAdded: true,
    pixelTightCanvasFitGuardAdded: true,
    graphPreviewScalesInsteadOfCroppingWhenTight: true,
    floatingZoomControlsScaleDownWhenTight: true,
    gridAxisCurveVisualBalancePolished: true,
    axisLabelsSuppressedWhenTooTight: true,
    protectedHashes,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    androidRealDevicePassClaimed: false,
  },
};
fs.writeFileSync(p('tool/reports/graph_canvas_premium_polish_q223_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/graph_canvas_premium_polish_q223_report.md'), `# V172-Q223 Graph Canvas Premium Polish + Responsive QA\n\nStatus: ${report.status}\n\nPixel-tight fit guard: true\n\nPremium canvas polish: true\n\nFlutter/Android PASS claimed: false\n`);
console.log(report.status);
