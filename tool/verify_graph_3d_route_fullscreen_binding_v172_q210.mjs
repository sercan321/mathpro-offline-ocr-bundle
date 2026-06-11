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
const fail = (msg) => { console.error(`GRAPH_3D_ROUTE_FULLSCREEN_BINDING_Q210_FAILED: ${msg}`); process.exit(1); };
const fullPhase = 'V172-Q210-GRAPH-3D-ROUTE-FULLSCREEN-BINDING';

for (const rel of [
  'lib/features/graph/graph_models.dart',
  'lib/features/graph/graph_eligibility.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_fullscreen_page.dart',
  'lib/features/graph/graph_surface_3d.dart',
  'lib/app/app_shell.dart',
  'lib/features/graph/graph_3d_route_fullscreen_binding_policy.dart',
  'test/v172_q210_graph_3d_route_fullscreen_binding_test.dart',
  'assets/mathlive/manifest.json',
]) if (!exists(rel)) fail(`missing ${rel}`);

const manifest = readJson('assets/mathlive/manifest.json');
const q221Successor = manifest.v172Q221GraphMiniPanelLayoutSimplification?.phase === 'V172-Q221';
const q234SurfaceOrHygieneSuccessor = manifest.graphSurfaceColorHierarchyLatestPhase === 'V172-Q234-3D-GRAPH-SURFACE-COLOR-HIERARCHY'
  || manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase === 'V172-Q234R1-GRAPH-SURFACE-COLOR-HIERARCHY-FINAL-HYGIENE'
  || manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase === 'V172-Q234R2-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-HYGIENE'
  || manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase === 'V172-Q234R3-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-FINAL-HYGIENE';
if (manifest.latestProductionPhase !== fullPhase) fail(`latestProductionPhase must be ${fullPhase}, got ${manifest.latestProductionPhase}`);
const env = manifest.v172Q210Graph3DRouteFullscreenBinding;
if (!env || env.phase !== 'V172-Q210' || env.fullPhase !== fullPhase) fail('missing Q210 manifest envelope');
for (const [key, expected] of Object.entries({
  zFunctionEligibilityAdded: true,
  xySurfaceEligibilityAdded: true,
  graphExpressionPreferredRenderModeAdded: true,
  previewHeaderUsesRenderModeExpression: true,
  preview3DDomainShowsXAndYRanges: true,
  fullscreenReceivesInitialRenderMode: true,
  fullscreenCanRenderGraphSurface3D: true,
  fullscreenHas2D3DToggle: true,
  fullscreenReturnsRenderMode: true,
  graph3DClampTypeHardened: true,
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

const models = read('lib/features/graph/graph_models.dart');
const eligibility = read('lib/features/graph/graph_eligibility.dart');
const card = read('lib/features/graph/graph_card.dart');
const fullscreen = read('lib/features/graph/graph_fullscreen_page.dart');
const app = read('lib/app/app_shell.dart');
const surface3d = read('lib/features/graph/graph_surface_3d.dart');
const q208Verifier = read('tool/verify_graph_2d_3d_elite_toggle_architecture_v172_q208.mjs');
const q209Verifier = read('tool/verify_graph_3d_surface_foundation_v172_q209.mjs');

if (!models.includes('bool get prefersThreeDimensionalSurface')) fail('GraphExpression must detect 3D surface preference');
if (!models.includes('GraphRenderMode get preferredRenderMode')) fail('GraphExpression preferred render mode missing');
if (!models.includes('String displayExpressionFor(GraphRenderMode renderMode)')) fail('render-mode-aware display expression missing');
if (!eligibility.includes('startsWithZEquals')) fail('z=f(x,y) eligibility branch missing');
if (!eligibility.includes("message: '3D yüzey grafik için hazır.'")) fail('3D graphable message missing');
if (!eligibility.includes('if (hasX || hasY)')) fail('raw xy surface eligibility missing');
if (!q221Successor) {
  if (!card.includes('expression.displayExpressionFor(renderMode)')) fail('preview header must use render-mode display expression');
  if (!card.includes('• y ∈')) fail('preview 3D domain must display both x and y ranges');
  if (!card.includes('expression.displayExpressionFor(GraphRenderMode.threeD)')) fail('preview 3D value bar must use z expression label');
} else {
  if (!card.includes('mathpro-graph-canvas-preview')) fail('Q221 successor graph canvas preview marker missing');
  if (!card.includes('mathpro-graph-compact-info-row')) fail('Q221 successor compact info row marker missing');
  if (!card.includes('mathpro-graph-floating-zoom-in')) fail('Q221 successor floating zoom-in marker missing');
  if (!card.includes('mathpro-graph-floating-zoom-out')) fail('Q221 successor floating zoom-out marker missing');
}
if (!fullscreen.includes('class GraphFullscreenResult')) fail('fullscreen result object missing');
if (!fullscreen.includes('initialRenderMode')) fail('fullscreen initial render mode missing');
if (!fullscreen.includes('GraphSurface3D(')) fail('fullscreen must render GraphSurface3D in 3D mode');
if (!fullscreen.includes('mathpro-fullscreen-graph-2d-3d-toggle')) fail('fullscreen 2D/3D toggle missing');
if (!fullscreen.includes('Navigator.of(context).pop(GraphFullscreenResult')) fail('fullscreen must return render mode with expression');
if (!fullscreen.includes('renderMode == GraphRenderMode.twoD && _expression.traceEnabled')) fail('trace overlay must remain 2D-only');
if (!app.includes('GraphFullscreenPage(expression: graph, initialRenderMode: _graphRenderMode)')) fail('AppShell must pass render mode to fullscreen');
if (!app.includes('_applyGraphUpdate(updated.expression, renderMode: updated.renderMode)')) fail('AppShell must preserve fullscreen render mode on return');
if (!app.includes('_graphRenderMode = openedGraph.preferredRenderMode')) fail('AppShell must auto-open 3D-capable expressions in 3D');
const q234SurfaceSuccessorActive = surface3d.includes('GraphSurfaceColorRamp.colorAt')
  && surface3d.includes('quad.meanZ')
  && surface3d.includes('clamp(-0.22, 1.22).toDouble()')
  && surface3d.includes('3D Ribbon')
  && surface3d.includes('3D Surface');
if (!q234SurfaceSuccessorActive) {
  if (!surface3d.includes('mean.clamp(0.0, 1.0).toDouble()')) fail('3D color lerp clamp must be double-hardened');
  if (!surface3d.includes('point.zNormalized.clamp(0.0, 1.0).toDouble()')) fail('3D glow radius clamp must be double-hardened');
}
if (!surface3d.includes('expression.displayExpressionFor(GraphRenderMode.threeD)')) fail('3D surface label must reflect actual z expression');
if (!q208Verifier.includes(fullPhase)) fail('Q208 verifier must accept Q210 successor');
if (!q209Verifier.includes(fullPhase)) fail('Q209 verifier must accept Q210 successor');

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

const protectedBaselineMatch = read('docs/audit/V172_Q209_PROTECTED_FILE_HASH_MANIFEST.md').match(/```json\n([\s\S]*?)\n```/);
if (protectedBaselineMatch && !q234SurfaceOrHygieneSuccessor) {
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

console.log('GRAPH_3D_ROUTE_FULLSCREEN_BINDING_Q210_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_3D_RETEST_REQUIRED');
