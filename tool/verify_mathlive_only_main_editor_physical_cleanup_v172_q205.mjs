#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';
import { spawnSync } from 'node:child_process';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const fail = (msg) => { console.error(`Q205_MATHLIVE_ONLY_MAIN_EDITOR_PHYSICAL_CLEANUP_FAILED: ${msg}`); process.exit(1); };
const fullPhase = 'V172-Q205-MATHLIVE-ONLY-MAIN-EDITOR-PHYSICAL-CLEANUP';
const q208FullPhase = 'V172-Q208-GRAPH-2D-3D-ELITE-TOGGLE-ARCHITECTURE';
const q205r1FullPhase = 'V172-Q205R1-MATHLIVE-ONLY-MAIN-EDITOR-ANALYZE-TEST-HYGIENE';

for (const rel of [
  'lib/features/mathlive/mathlive_mathlive_only_main_editor_physical_cleanup_policy.dart',
  'lib/app/app_shell.dart',
  'lib/features/workspace/workspace_panel.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
  'assets/mathlive/manifest.json',
]) if (!exists(rel)) fail(`missing ${rel}`);

const manifest = readJson('assets/mathlive/manifest.json');
if (![fullPhase, q205r1FullPhase, 'V172-Q205R2-MATHLIVE-ONLY-MAIN-EDITOR-FLUTTER-LOG-HYGIENE', 'V172-Q205R3-MATHLIVE-ONLY-MAIN-EDITOR-METADATA-ANALYZE-TEST-CLOSURE-HYGIENE', q208FullPhase].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase must be ${fullPhase}, ${q205r1FullPhase}, or a verified Q205R2/Q205R3 successor`);
const env = manifest.v172Q205MathLiveOnlyMainEditorPhysicalCleanup;
if (!env || env.phase !== 'V172-Q205' || env.fullPhase !== fullPhase) fail('missing Q205 manifest envelope');
for (const [key, expected] of Object.entries({
  mathLiveProductionEditorIsSingleExpressionAuthority: true,
  workspaceEditorViewportBranchRemoved: true,
  appShellLegacySnapshotBuildRemoved: true,
  appShellLegacySlotCallbacksRemoved: true,
  legacyCursorDisabledPanelRemoved: true,
  editorViewportProductionRouteAllowed: false,
  flutterCaretOverlayProductionRouteAllowed: false,
  mathJaxEditorSurfaceProductionRouteAllowed: false,
  runJavaScriptReturningResultAllowedInProduction: false,
  visibleFallbackOverlayAllowedInProduction: false,
  diagnosticOverlayAllowedInProduction: false,
  graphHistorySolutionAdapterPreserved: true,
  astCoreBlindDeletionAllowed: false,
  keyboardLayoutMutationAllowed: false,
  moreInventoryMutationAllowed: false,
  longPressMutationAllowed: false,
  graphUiMutationAllowed: false,
  historyUiMutationAllowed: false,
  solutionUiMutationAllowed: false,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
})) if (env[key] !== expected) fail(`manifest ${key} expected ${expected}, got ${env[key]}`);

const appShell = read('lib/app/app_shell.dart');
const workspace = read('lib/features/workspace/workspace_panel.dart');
const shim = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const prod = read('lib/features/mathlive/mathlive_production_editor_surface.dart');
const html = read('assets/mathlive/main_editor_prod.html');
const bridge = read('assets/mathlive/mathlive_prod_bridge.js');

if (!workspace.includes('MathLiveProductionEditorSurface(')) fail('WorkspacePanel must construct MathLiveProductionEditorSurface');
for (const token of [
  'EditorViewport(',
  '_LegacyCursorMainPathDisabledPanel',
  'useMathLiveMainEditor',
  'editorSnapshot',
  'onSlotSelected',
  'onTextCaretSelected',
]) if (workspace.includes(token)) fail(`WorkspacePanel still contains legacy editor route token ${token}`);

for (const token of [
  'MathEditorController.buildSnapshot',
  'selectEditorSlot(',
  'selectTextCaret(',
  '_useMathLiveMainEditor',
  '_syncMathLiveVisibleFallbackForRealDevice',
  '_syncMathLiveSimpleKeyFallbackForTests',
  '_safeMathLiveFallbackExpressionFor',
  'MathLiveAppShellCommandBusHardBindingPolicy',
]) if (appShell.includes(token)) fail(`AppShell still contains legacy/mirror token ${token}`);

if (!shim.includes('class MathLiveMainEditorSurface extends StatelessWidget')) fail('shim missing');
if (!shim.includes('return MathLiveProductionEditorSurface(')) fail('shim must forward to production surface');
if (!prod.includes('class MathLiveProductionEditorSurface extends StatefulWidget')) fail('production surface missing');
if (!html.includes('<math-field id="mathlive-field"')) fail('production HTML must contain native math-field');
if (!bridge.includes('window.MathProProductionMathLiveBridge')) fail('production bridge missing');

for (const rel of [
  'lib/features/workspace/editor_viewport.dart',
  'lib/features/workspace/editor_caret_overlay.dart',
  'lib/features/editor/render/mathjax_render_surface.dart',
  'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
  'assets/mathjax/tex-svg.js',
]) if (exists(rel)) fail(`retired legacy artifact still exists: ${rel}`);

for (const token of [
  'runJavaScriptReturningResult',
  'class _MathLiveMainEditorSurfaceState',
  'class _MathLiveAppShellVisibleFallbackOverlay',
  'class _MathLiveDiagnosticOverlay',
  'mathpro-q163-diagnostic-overlay',
  '_refreshRealDeviceDiagnostic',
  '_visibleFallbackExpression',
]) {
  const combined = `${appShell}\n${workspace}\n${shim}\n${prod}\n${html}\n${bridge}`;
  if (combined.includes(token)) fail(`forbidden production token present: ${token}`);
}

const protectedBaseline = JSON.parse(read('docs/audit/V172_Q204R3_PROTECTED_FILE_HASH_MANIFEST.md').match(/```json\n([\s\S]*?)\n```/)?.[1] || '{}');
const protectedFiles = [
  'lib/features/keyboard/key_config.dart',
  'lib/features/keyboard/math_keyboard.dart',
  'lib/features/keyboard/bottom_dock.dart',
  'lib/features/keyboard/premium_key.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/workspace/template_tray.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/graph/graph_controller.dart',
  'lib/features/history/history_controller.dart',
  'lib/features/history/history_panel.dart',
  'lib/features/solution/solution_steps_panel.dart',
];
function sha(rel) { return crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex'); }
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`protected file missing ${rel}`);
  if (protectedBaseline[rel] && protectedBaseline[rel] !== sha(rel) && !(manifest.latestProductionPhase === q208FullPhase && rel === 'lib/features/graph/graph_card.dart')) fail(`protected file changed: ${rel}`);
}

for (const rel of [
  'lib/features/mathlive/mathlive_production_graph_history_solution_state_finalization_policy.dart',
  'lib/features/mathlive/mathlive_production_graph_history_solution_adapter_policy.dart',
  'lib/features/editor/math_node.dart',
  'lib/features/editor/node_factory.dart',
  'lib/features/editor/tex_serializer.dart',
  'lib/features/formula_engine/templates.dart',
]) if (!exists(rel)) fail(`required retained core/adapter file missing ${rel}`);

// Q205R1 hygiene: avoid recursively spawning the entire Q204R3 suite from this
// preserved Q205 verifier. Q204R3 has its own master verifier; this verifier
// keeps Q205's physical-cleanup contract focused and bounded.
for (const rel of [
  'tool/verify_mathlive_real_device_evidence_intake_verifier_suite_hygiene_v172_q204r3.mjs',
  'tool/verify_mathlive_real_device_evidence_intake_full_test_suite_hygiene_v172_q204r2.mjs',
  'tool/verify_mathlive_real_device_evidence_intake_analyze_test_hygiene_v172_q204r1.mjs',
  'tool/verify_mathlive_real_device_evidence_intake_v172_q204.mjs',
]) if (!exists(rel)) fail(`preserved verifier file missing after Q205: ${rel}`);

const q204r3Suite = readJson('tool/evidence/V172_Q204R3_ACTIVE_VERIFIER_SUITE.json');
const q204r3VerifierTotal = (q204r3Suite.activeVerifiers || []).length + (q204r3Suite.retiredHistoricalVerifiers || []).length + 1;

const report = {
  phase: 'V172-Q205',
  fullPhase,
  status: 'STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED',
  q204r3VerifiedMathLiveVerifierCount: q204r3VerifierTotal,
  retiredPhysicalArtifactsAbsent: true,
  protectedFilesUnchanged: true,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/mathlive_only_main_editor_physical_cleanup_v172_q205_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/mathlive_only_main_editor_physical_cleanup_v172_q205_report.md'), `# V172-Q205 MathLive-Only Main Editor Physical Cleanup\n\nStatus: ${report.status}\n\nRetired physical artifacts absent: true\n\nProtected files unchanged: true\n\nFlutter/Android PASS claimed: false\n`);
console.log('MATHLIVE_ONLY_MAIN_EDITOR_PHYSICAL_CLEANUP_Q205_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
