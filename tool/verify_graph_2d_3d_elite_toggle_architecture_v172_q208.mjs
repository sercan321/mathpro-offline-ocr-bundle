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
const fail = (msg) => { console.error(`GRAPH_2D_3D_ELITE_TOGGLE_ARCHITECTURE_Q208_FAILED: ${msg}`); process.exit(1); };
const fullPhase = 'V172-Q208-GRAPH-2D-3D-ELITE-TOGGLE-ARCHITECTURE';
const successorPhases = new Set([
  fullPhase,
  'V172-Q209-REAL-3D-GRAPH-SURFACE-FOUNDATION',
  'V172-Q210-GRAPH-3D-ROUTE-FULLSCREEN-BINDING',
]);

for (const rel of [
  'lib/features/graph/graph_models.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/workspace/workspace_panel.dart',
  'lib/app/app_shell.dart',
  'lib/features/graph/graph_2d_3d_elite_toggle_architecture_policy.dart',
  'test/v172_q208_graph_2d_3d_elite_toggle_architecture_test.dart',
  'assets/mathlive/manifest.json',
]) if (!exists(rel)) fail(`missing ${rel}`);

const manifest = readJson('assets/mathlive/manifest.json');
if (!successorPhases.has(manifest.latestProductionPhase)) fail(`latestProductionPhase must be Q208 or verified successor, got ${manifest.latestProductionPhase}`);
const env = manifest.v172Q208Graph2D3DEliteToggleArchitecture;
if (!env || env.phase !== 'V172-Q208' || env.fullPhase !== fullPhase) fail('missing Q208 manifest envelope');
for (const [key, expected] of Object.entries({
  graphRenderModeEnumAdded: true,
  graphCardElite2D3DToggleAdded: true,
  twoDUsesExistingGraphSurface: true,
  threeDUsesGuardedReadinessPanel: true,
  fake3DRendererClaimed: false,
  real3DRendererDeferredToQ209: true,
  q207OverflowRepairPreserved: true,
  duplicateSettingsChipRestored: false,
  keyboardLayoutMutationAllowed: false,
  moreInventoryMutationAllowed: false,
  longPressMutationAllowed: false,
  mathLiveEditorMutationAllowed: false,
  historyUiMutationAllowed: false,
  solutionUiMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
})) if (env[key] !== expected) fail(`manifest ${key} expected ${expected}, got ${env[key]}`);

const models = read('lib/features/graph/graph_models.dart');
const graph = read('lib/features/graph/graph_card.dart');
const workspace = read('lib/features/workspace/workspace_panel.dart');
const app = read('lib/app/app_shell.dart');
if (!models.includes('enum GraphRenderMode') || !models.includes('twoD') || !models.includes('threeD')) fail('GraphRenderMode enum missing twoD/threeD');
if (!graph.includes('mathpro-graph-2d-3d-elite-toggle')) fail('premium 2D/3D toggle marker missing');
if (!graph.includes('class _GraphRenderModeToggle')) fail('Graph render mode toggle class missing');
if (!graph.includes('class _GraphModeIconPainter')) fail('custom 2D/3D icon painter missing');
if (!graph.includes('_Graph3DReadinessPanel') && !graph.includes('GraphSurface3D(')) fail('3D route missing readiness panel or Q209 real surface');
if (!graph.includes('GraphSurface(')) fail('existing 2D GraphSurface must remain');
if (graph.includes("_ActionChipButton(label: 'Settings'")) fail('duplicate Settings chip restored; Q207 overflow repair not preserved');
if (!workspace.includes('renderMode: graphRenderMode')) fail('WorkspacePanel must pass graph render mode to GraphCard');
if (!workspace.includes('onRenderModeChanged: onGraphRenderModeChanged')) fail('WorkspacePanel must pass render mode callback');
if (!app.includes('GraphRenderMode _graphRenderMode = GraphRenderMode.twoD;')) fail('AppShell must own graph render mode state with 2D default');
if (!app.includes('void _setGraphRenderMode(GraphRenderMode mode)')) fail('AppShell must expose render mode setter');

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

const protectedBaseline = read('docs/audit/V172_Q205R3_PROTECTED_FILE_HASH_MANIFEST.md').match(/```json\n([\s\S]*?)\n```/);
if (protectedBaseline) {
  const baseline = JSON.parse(protectedBaseline[1]);
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

console.log('GRAPH_2D_3D_ELITE_TOGGLE_ARCHITECTURE_Q208_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_3D_RETEST_REQUIRED');
