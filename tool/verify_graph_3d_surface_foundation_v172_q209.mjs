#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const fail = (msg) => { console.error(`GRAPH_3D_SURFACE_FOUNDATION_Q209_FAILED: ${msg}`); process.exit(1); };
const fullPhase = 'V172-Q209-REAL-3D-GRAPH-SURFACE-FOUNDATION';
const successorPhases = new Set([
  fullPhase,
  'V172-Q210-GRAPH-3D-ROUTE-FULLSCREEN-BINDING',
]);

for (const rel of [
  'lib/features/graph/graph_models.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_painter.dart',
  'lib/features/graph/graph_surface.dart',
  'lib/features/graph/graph_surface_3d.dart',
  'lib/features/graph/graph_3d_surface_foundation_policy.dart',
  'test/v172_q209_real_3d_graph_surface_foundation_test.dart',
  'assets/mathlive/manifest.json',
]) if (!exists(rel)) fail(`missing ${rel}`);

const manifest = readJson('assets/mathlive/manifest.json');
const q221Successor = manifest.v172Q221GraphMiniPanelLayoutSimplification?.phase === 'V172-Q221';
if (!successorPhases.has(manifest.latestProductionPhase)) fail(`latestProductionPhase must be ${fullPhase} or verified successor, got ${manifest.latestProductionPhase}`);
const env = manifest.v172Q209Real3DGraphSurfaceFoundation;
if (!env || env.phase !== 'V172-Q209' || env.fullPhase !== fullPhase) fail('missing Q209 manifest envelope');
for (const [key, expected] of Object.entries({
  graph3DSurfaceWidgetAdded: true,
  graph3DPainterAdded: true,
  graphExpressionEvaluatorSupportsY: true,
  threeDModeUsesRealSurfacePainter: true,
  threeDReadinessPanelRetired: true,
  fake3DRendererClaimed: false,
  twoDRendererPreserved: true,
  q207OverflowRepairPreserved: true,
  mathLiveEditorMutationAllowed: false,
  keyboardLayoutMutationAllowed: false,
  moreInventoryMutationAllowed: false,
  longPressMutationAllowed: false,
  historyUiMutationAllowed: false,
  solutionUiMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevice3DPassClaimed: false,
})) if (env[key] !== expected) fail(`manifest ${key} expected ${expected}, got ${env[key]}`);

const graph = read('lib/features/graph/graph_card.dart');
const surface3d = read('lib/features/graph/graph_surface_3d.dart');
const painter = read('lib/features/graph/graph_painter.dart');
const workspace = read('lib/features/workspace/workspace_panel.dart');
const app = read('lib/app/app_shell.dart');
const q208Verifier = read('tool/verify_graph_2d_3d_elite_toggle_architecture_v172_q208.mjs');

if (!graph.includes('GraphSurface3D(')) fail('GraphCard must route 3D mode to GraphSurface3D');
if (graph.includes('_Graph3DReadinessPanel')) fail('Q208 readiness panel must be retired by Q209 real surface foundation');
if (!q221Successor) {
  if (!graph.includes('3D Surface')) fail('3D action chip must identify real 3D surface mode');
  if (!graph.includes('SingleChildScrollView')) fail('Q207 single-rail overflow repair must remain in GraphActions');
} else {
  if (!graph.includes('mathpro-graph-canvas-preview')) fail('Q221 successor graph canvas preview marker missing');
  if (!graph.includes('mathpro-graph-floating-zoom-in')) fail('Q221 successor floating zoom control marker missing');
  if (graph.includes("label: '3D Surface'")) fail('Q221 successor must not restore old 3D Surface text chip');
}
if (graph.includes("_ActionChipButton(label: 'Settings'")) fail('duplicate Settings chip restored');
if (!surface3d.includes('class GraphSurface3D') || !surface3d.includes('class GraphSurface3DPainter')) fail('3D surface widget/painter missing');
if (!surface3d.includes('evaluate2D(x, y)')) fail('3D surface must sample z=f(x,y) through evaluate2D');
if (!surface3d.includes('mathpro-graph-3d-surface')) fail('3D surface widget key missing');
if (!surface3d.includes('z = f(x,y)')) fail('3D surface must label z=f(x,y) foundation');
if (!painter.includes('double? evaluate2D(double x, double y)')) fail('GraphExpressionEvaluator must expose evaluate2D');
if (!painter.includes("if (id == 'y') return _y;")) fail('GraphExpressionEvaluator must support y variable');
if (!painter.includes("RegExp(r'^[yz]")) fail('normalizer must remove y= or z= leading equation prefixes');
if (!workspace.includes('renderMode: graphRenderMode')) fail('WorkspacePanel must keep renderMode forwarding');
if (!app.includes('GraphRenderMode _graphRenderMode = GraphRenderMode.twoD;')) fail('AppShell must keep graph render mode state');
if (!q208Verifier.includes('V172-Q209-REAL-3D-GRAPH-SURFACE-FOUNDATION')) fail('Q208 verifier must recognize Q209 as verified successor');

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
]) if (!exists(rel)) fail(`guarded file missing ${rel}`);

const protectedBaselineMatch = read('docs/audit/V172_Q208_PROTECTED_FILE_HASH_MANIFEST.md').match(/```json\n([\s\S]*?)\n```/);
if (protectedBaselineMatch) {
  const baseline = JSON.parse(protectedBaselineMatch[1]);
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
  ]) if (baseline[rel] && baseline[rel] !== sha(rel)) fail(`unexpected guarded file mutation: ${rel}`);
}

for (const rel of [
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
]) {
  const src = read(rel);
  for (const pat of ['runJavaScriptReturningResult', 'class _MathLiveMainEditorSurfaceState', 'class _MathLiveDiagnosticOverlay', 'class _MathLiveAppShellVisibleFallbackOverlay']) {
    if (src.includes(pat)) fail(`${rel} restored retired runtime pattern ${pat}`);
  }
}

console.log('GRAPH_3D_SURFACE_FOUNDATION_Q209_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_3D_RETEST_REQUIRED');
