#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const fail = (msg) => { console.error(`Q205R1_MATHLIVE_ONLY_MAIN_EDITOR_ANALYZE_TEST_HYGIENE_FAILED: ${msg}`); process.exit(1); };
const fullPhase = 'V172-Q205R1-MATHLIVE-ONLY-MAIN-EDITOR-ANALYZE-TEST-HYGIENE';
const q208FullPhase = 'V172-Q208-GRAPH-2D-3D-ELITE-TOGGLE-ARCHITECTURE';
const q205FullPhase = 'V172-Q205-MATHLIVE-ONLY-MAIN-EDITOR-PHYSICAL-CLEANUP';

for (const rel of [
  'lib/features/mathlive/mathlive_only_main_editor_analyze_test_hygiene_policy.dart',
  'test/v172_q205r1_mathlive_only_main_editor_analyze_test_hygiene_test.dart',
  'lib/app/app_shell.dart',
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'assets/mathlive/manifest.json',
]) if (!exists(rel)) fail(`missing ${rel}`);

const manifest = readJson('assets/mathlive/manifest.json');
if (![fullPhase, 'V172-Q205R2-MATHLIVE-ONLY-MAIN-EDITOR-FLUTTER-LOG-HYGIENE', 'V172-Q205R3-MATHLIVE-ONLY-MAIN-EDITOR-METADATA-ANALYZE-TEST-CLOSURE-HYGIENE', q208FullPhase].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase must be ${fullPhase} or a verified Q205R2/Q205R3 successor`);
const env = manifest.v172Q205R1MathLiveOnlyMainEditorAnalyzeTestHygiene;
if (!env || env.phase !== 'V172-Q205R1' || env.fullPhase !== fullPhase) fail('missing Q205R1 manifest envelope');
for (const [key, expected] of Object.entries({
  q205MathLiveOnlyMainEditorPreserved: true,
  analyzerNullAwareWarningRepaired: true,
  controllerStateTypedForPrivateProductionHooks: true,
  legacySimpleKeyFallbackTestExpectationRetired: true,
  productionPlaceholderTestContractsUpdated: true,
  equalityLiteralContractPreserved: true,
  nonEditorResultDisplaySurfacePreserved: true,
  runReturningResultPathRestored: false,
  visibleFallbackOverlayRestored: false,
  diagnosticOverlayRestored: false,
  legacyMainEditorStateRestored: false,
  editorViewportRestored: false,
  editorCaretOverlayRestored: false,
  mathJaxEditorSurfaceRestored: false,
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
const mainSurface = read('lib/features/mathlive/mathlive_main_editor_surface.dart');
const prodSurface = read('lib/features/mathlive/mathlive_production_editor_surface.dart');
const q204r3Policy = read('lib/features/mathlive/mathlive_real_device_evidence_intake_verifier_suite_hygiene_policy.dart');
const q204r3Test = read('test/v172_q204r3_real_device_evidence_intake_verifier_suite_hygiene_test.dart');
const q204r2Test = read('test/v172_q204r2_real_device_evidence_intake_full_test_suite_hygiene_test.dart');
const q199Test = read('test/v172_q199_production_command_contract_finalization_test.dart');
const widgetTest = read('test/widget_test.dart');

if (appShell.includes('envelope?.evaluatorUnsupportedReason')) fail('app_shell still contains invalid null-aware envelope access');
if (!mainSurface.includes('_MathLiveProductionEditorSurfaceState? _state;')) fail('runtime controller state must be typed so private production hooks are statically referenced');
for (const token of ['_productionMayFlushQueuedCommands', '_noteFlutterKeyboardTap', '_noteBridgeSendResult', '_noteProductionQueueFlush', '_noteProductionQueueFlushCompleted']) {
  if (!mainSurface.includes(token) || !prodSurface.includes(token)) fail(`typed controller/production surface hook missing ${token}`);
}
for (const token of ['runJavaScriptReturningResultRestored', 'visibleFallbackOverlayRestored', 'diagnosticOverlayRestored', 'legacyMainEditorStateRestored']) {
  if (q204r3Policy.includes(token) || q204r3Test.includes(token)) fail(`Q204R3 test/policy still contains Q204R2 stale scanner token ${token}`);
}
for (const token of ['runJavaScriptReturningResult', 'mathpro-q163-diagnostic-overlay', '_refreshRealDeviceDiagnostic', 'appShellVisibleFallbackPhase', 'Q165 KEY:', 'Q169 KEY:', 'PAINT:', '_visibleFallbackExpression', 'visibleFallbackMayRenderStructuralTemplates', 'class _MathLiveMainEditorSurfaceState', 'class _MathLiveAppShellVisibleFallbackOverlay', 'class _MathLiveDiagnosticOverlay']) {
  if (q204r2Test.includes(token) && !q204r2Test.includes('forbiddenStaleTestMarkers')) fail(`Q204R2 scanner test contains unexpected direct stale token ${token}`);
}
for (const rel of [
  'test/v172_q139r5_mathlive_main_editor_template_polish_test.dart',
  'test/v172_q142_mathlive_semantic_template_coverage_test.dart',
  'test/v172_q151_mathlive_extended_template_court_test.dart',
  'test/v172_q154_mathlive_flutter_analyze_contract_repair_test.dart',
  'test/v172_q155_mathlive_flutter_test_metadata_contract_repair_test.dart',
]) {
  const src = read(rel);
  if (!src.includes('\\placeholder{}')) fail(`${rel} must assert production document placeholders`);
  if (src.includes("r'\\sum_{n=#?}^{#?} #0'") || src.includes("r'\\lim_{x\\to #?} #0'")) fail(`${rel} still asserts raw insert-control tokens`);
}
if (!q199Test.includes('= remains the literal equality relation')) fail('Q199 test must preserve literal equals relation contract');
if (q199Test.includes("'Maclaurin', '=']")) fail('Q199 raw-label leak loop must not treat literal = as a leaked label');
if (!widgetTest.includes('non-editor result/solution display surfaces')) fail('widget_test must distinguish non-editor result display from retired editor surface');
if (widgetTest.includes('Q205 does not synthesize legacy CalculatorController result state')) fail('widget_test still contains invalid Q205 result-surface expectation');

for (const rel of [
  'lib/features/workspace/editor_viewport.dart',
  'lib/features/workspace/editor_caret_overlay.dart',
  'lib/features/editor/render/mathjax_render_surface.dart',
  'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
  'assets/mathjax/tex-svg.js',
]) if (exists(rel)) fail(`retired legacy artifact restored: ${rel}`);

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
const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`protected file missing ${rel}`);
  if (protectedBaseline[rel] && protectedBaseline[rel] !== sha(rel) && !(manifest.latestProductionPhase === q208FullPhase && rel === 'lib/features/graph/graph_card.dart')) fail(`protected file changed: ${rel}`);
}

for (const rel of [
  'tool/verify_mathlive_only_main_editor_physical_cleanup_v172_q205.mjs',
  'tool/verify_mathlive_real_device_evidence_intake_verifier_suite_hygiene_v172_q204r3.mjs',
]) {
  if (!exists(rel)) fail(`expected predecessor verifier missing: ${rel}`);
}

const report = {
  phase: 'V172-Q205R1',
  fullPhase,
  status: 'STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED',
  q205Baseline: q205FullPhase,
  protectedFilesUnchanged: true,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/mathlive_only_main_editor_analyze_test_hygiene_v172_q205r1_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/mathlive_only_main_editor_analyze_test_hygiene_v172_q205r1_report.md'), `# V172-Q205R1 MathLive-Only Main Editor Analyze/Test Hygiene\n\nStatus: ${report.status}\n\nProtected files unchanged: true\n\nFlutter/Android PASS claimed: false\n`);
console.log('MATHLIVE_ONLY_MAIN_EDITOR_ANALYZE_TEST_HYGIENE_Q205R1_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
