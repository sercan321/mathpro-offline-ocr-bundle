#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const fail = (msg) => { console.error(`Q205R3_MATHLIVE_ONLY_MAIN_EDITOR_METADATA_ANALYZE_TEST_CLOSURE_FAILED: ${msg}`); process.exit(1); };
const fullPhase = 'V172-Q205R3-MATHLIVE-ONLY-MAIN-EDITOR-METADATA-ANALYZE-TEST-CLOSURE-HYGIENE';
const q208FullPhase = 'V172-Q208-GRAPH-2D-3D-ELITE-TOGGLE-ARCHITECTURE';
const q209FullPhase = 'V172-Q209-REAL-3D-GRAPH-SURFACE-FOUNDATION';
const q210FullPhase = 'V172-Q210-GRAPH-3D-ROUTE-FULLSCREEN-BINDING';
const q211FullPhase = 'V172-Q211-LAUNCHER-ICON-SURGICAL-REPLACEMENT';
const q212FullPhase = 'V172-Q212-GAUSS-SPLASH-SCREEN-SURGICAL-INTEGRATION';
const q213FullPhase = 'V172-Q213-ANALYZE-TEST-HYGIENE-LOG-REPAIR';

for (const rel of [
  'lib/features/mathlive/mathlive_only_main_editor_metadata_analyze_test_closure_policy.dart',
  'test/v172_q205r3_mathlive_only_main_editor_metadata_analyze_test_closure_test.dart',
  'lib/app/app_shell.dart',
  'pubspec.yaml',
  'assets/mathlive/manifest.json',
]) if (!exists(rel)) fail(`missing ${rel}`);

const manifest = readJson('assets/mathlive/manifest.json');
const acceptedSuccessorPhases = new Set([fullPhase, q208FullPhase, q209FullPhase, q210FullPhase, q211FullPhase, q212FullPhase, q213FullPhase]);
if (!acceptedSuccessorPhases.has(manifest.latestProductionPhase)) fail(`latestProductionPhase must be ${fullPhase} or verified Q208/Q209/Q210/Q211/Q212/Q213 successor`);
const env = manifest.v172Q205R3MathLiveOnlyMainEditorMetadataAnalyzeTestClosure;
if (!env || env.phase !== 'V172-Q205R3' || env.fullPhase !== fullPhase) fail('missing Q205R3 manifest envelope');
for (const [key, expected] of Object.entries({
  q205MathLiveOnlyMainEditorPreserved: true,
  legacyPubspecDescriptionCompatibilityBlockPresent: true,
  activePubspecDescriptionUpdatedToQ205R3: true,
  deadNullAwareExpressionRemainsRepaired: true,
  q87ToQ90MetadataTestsMayUseCompatibilityBlock: true,
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

const pubspec = read('pubspec.yaml');
const contract = read('lib/logic/mathpro_package_contract.dart');
const match = contract.match(/static const String pubspecDescription =\n\s*'([\s\S]*?)';/);
if (!match) fail('could not read MathProPackageContract.pubspecDescription');
const description = match[1];
if (!pubspec.includes('Q205R3 MathLive-only main editor metadata/analyze-test closure hygiene')) fail('active pubspec description must identify Q205R3');
if (!pubspec.includes('V172-Q205R3 legacy metadata compatibility block')) fail('pubspec missing Q205R3 compatibility block label');
if (!pubspec.includes(description)) fail('pubspec missing historical pubspecDescription compatibility text required by legacy Q83-Q90 tests');

const appShell = read('lib/app/app_shell.dart');
if (appShell.includes('errorState ??')) fail('app_shell still has dead null-aware expression around errorState');
if (appShell.includes('envelope?.evaluatorUnsupportedReason')) fail('app_shell restored invalid envelope null-aware access');

for (const rel of [
  'lib/features/workspace/editor_viewport.dart',
  'lib/features/workspace/editor_caret_overlay.dart',
  'lib/features/editor/render/mathjax_render_surface.dart',
  'lib/features/editor_adapter/legacy_flutter_slot_editor_adapter.dart',
  'assets/mathjax/tex-svg.js',
]) if (exists(rel)) fail(`retired legacy artifact restored: ${rel}`);

const forbiddenRuntimePatterns = [
  'runJavaScriptReturningResult',
  'class _MathLiveMainEditorSurfaceState',
  'class _MathLiveAppShellVisibleFallbackOverlay',
  'class _MathLiveDiagnosticOverlay',
  '_visibleFallbackExpression',
  '_refreshRealDeviceDiagnostic',
];
for (const rel of [
  'lib/features/mathlive/mathlive_main_editor_surface.dart',
  'lib/features/mathlive/mathlive_production_editor_surface.dart',
  'assets/mathlive/main_editor_prod.html',
  'assets/mathlive/mathlive_prod_bridge.js',
]) {
  const src = read(rel);
  for (const pat of forbiddenRuntimePatterns) if (src.includes(pat)) fail(`${rel} contains retired runtime pattern ${pat}`);
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
const sha = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
for (const rel of protectedFiles) {
  if (!exists(rel)) fail(`protected file missing ${rel}`);
  if (
    protectedBaseline[rel] &&
    protectedBaseline[rel] !== sha(rel) &&
    !(
      [q208FullPhase, q209FullPhase, q210FullPhase].includes(manifest.latestProductionPhase) &&
      rel === 'lib/features/graph/graph_card.dart'
    )
  ) fail(`protected file changed: ${rel}`);
}

for (const rel of [
  'tool/verify_mathlive_only_main_editor_flutter_log_hygiene_v172_q205r2.mjs',
  'tool/verify_mathlive_only_main_editor_analyze_test_hygiene_v172_q205r1.mjs',
  'tool/verify_mathlive_only_main_editor_physical_cleanup_v172_q205.mjs',
  'tool/verify_mathlive_real_device_evidence_intake_verifier_suite_hygiene_v172_q204r3.mjs',
]) {
  if (!exists(rel)) fail(`expected predecessor verifier missing: ${rel}`);
}

const report = {
  phase: 'V172-Q205R3',
  fullPhase,
  status: 'STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED',
  protectedFilesUnchanged: true,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/mathlive_only_main_editor_metadata_analyze_test_closure_v172_q205r3_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/mathlive_only_main_editor_metadata_analyze_test_closure_v172_q205r3_report.md'), `# V172-Q205R3 MathLive-Only Main Editor Metadata / Analyze-Test Closure Hygiene\n\nStatus: ${report.status}\n\nProtected files unchanged: true\n\nFlutter/Android success claimed: false\n`);
console.log('MATHLIVE_ONLY_MAIN_EDITOR_METADATA_ANALYZE_TEST_CLOSURE_Q205R3_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
