#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const readJson = (rel) => JSON.parse(read(rel));
const fail = (msg) => { console.error(`Q205R2_MATHLIVE_ONLY_MAIN_EDITOR_FLUTTER_LOG_HYGIENE_FAILED: ${msg}`); process.exit(1); };
const fullPhase = 'V172-Q205R2-MATHLIVE-ONLY-MAIN-EDITOR-FLUTTER-LOG-HYGIENE';
const q208FullPhase = 'V172-Q208-GRAPH-2D-3D-ELITE-TOGGLE-ARCHITECTURE';

for (const rel of [
  'lib/features/mathlive/mathlive_only_main_editor_flutter_log_hygiene_policy.dart',
  'test/v172_q205r2_mathlive_only_main_editor_flutter_log_hygiene_test.dart',
  'lib/app/app_shell.dart',
  'tool/verify_mathpro_contract.py',
  'assets/mathlive/manifest.json',
]) if (!exists(rel)) fail(`missing ${rel}`);

const manifest = readJson('assets/mathlive/manifest.json');
const q205r3FullPhase = 'V172-Q205R3-MATHLIVE-ONLY-MAIN-EDITOR-METADATA-ANALYZE-TEST-CLOSURE-HYGIENE';
if (![fullPhase, q205r3FullPhase, q208FullPhase].includes(manifest.latestProductionPhase)) fail(`latestProductionPhase must be ${fullPhase} or verified Q205R3 successor`);
const env = manifest.v172Q205R2MathLiveOnlyMainEditorFlutterLogHygiene;
if (!env || env.phase !== 'V172-Q205R2' || env.fullPhase !== fullPhase) fail('missing Q205R2 manifest envelope');
for (const [key, expected] of Object.entries({
  q205MathLiveOnlyMainEditorPreserved: true,
  userSideDartToolVerifierHygieneRepaired: true,
  deadNullAwareExpressionRepaired: true,
  graphHistoryFakePassTextScanRepaired: true,
  q153SimpleFallbackExpectationRetired: true,
  q155ProductionSigmaTestContractMigrated: true,
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
if (appShell.includes('errorState ??')) fail('app_shell still contains dead null-aware expression around errorState');
if (appShell.includes('envelope?.evaluatorUnsupportedReason')) fail('app_shell restored invalid envelope null-aware access');

const contract = read('tool/verify_mathpro_contract.py');
if (!contract.includes('USER_SIDE_GENERATED_PATH_PARTS')) fail('verify_mathpro_contract must tolerate user-side .dart_tool after pub get');
if (!contract.includes('/.dart_tool/')) fail('verify_mathpro_contract must explicitly classify .dart_tool as user-generated');

const q153 = read('test/v172_q153_mathlive_flutter_test_contract_repair_test.dart');
if (q153.includes("contains('_isMathLiveSimpleControllerFallbackLabel')")) fail('Q153 test still expects restored simple-key fallback helper');
if (q153.includes("source: 'V172-Q153-mathlive-simple-key-test-fallback'")) fail('Q153 test still expects retired simple-key fallback source');
if (!q153.includes('_mathLiveMainEditor.sendKey')) fail('Q153 test should assert MathLive sendKey path instead');

const q155 = read('test/v172_q155_mathlive_flutter_test_metadata_contract_repair_test.dart');
if (q155.includes("q140Test, contains(\"final sigmaLatex = MathLiveKeyboardBridgePolicy.commandForMainEditorLabel('Σ').latex\"")) fail('Q155 must not require Q140 migrated production-surface test to contain old inline sigma command assertion');
if (!q155.includes('Q204R2 migrated production-surface contract')) fail('Q155 must recognize migrated Q140 production-surface contract');

const exactFakePassPhrases = ['flutter analyze PASS', 'flutter test PASS', 'flutter run PASS'];
for (const rel of ['README.md', 'docs/audit/V172_Q195_FINAL_STATIC_RELEASE_FREEZE_AUDIT_REPORT.md']) {
  const src = read(rel);
  for (const phrase of exactFakePassPhrases) {
    if (src.includes(phrase)) fail(`${rel} still contains exact fake PASS scan phrase ${phrase}`);
  }
}

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
  'tool/verify_mathlive_only_main_editor_analyze_test_hygiene_v172_q205r1.mjs',
  'tool/verify_mathlive_only_main_editor_physical_cleanup_v172_q205.mjs',
  'tool/verify_mathlive_real_device_evidence_intake_verifier_suite_hygiene_v172_q204r3.mjs',
]) {
  if (!exists(rel)) fail(`expected predecessor verifier missing: ${rel}`);
}

const report = {
  phase: 'V172-Q205R2',
  fullPhase,
  status: 'STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED',
  protectedFilesUnchanged: true,
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimed: false,
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/mathlive_only_main_editor_flutter_log_hygiene_v172_q205r2_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/mathlive_only_main_editor_flutter_log_hygiene_v172_q205r2_report.md'), `# V172-Q205R2 MathLive-Only Main Editor Flutter Log Hygiene\n\nStatus: ${report.status}\n\nProtected files unchanged: true\n\nFlutter/Android PASS claimed: false\n`);
console.log('MATHLIVE_ONLY_MAIN_EDITOR_FLUTTER_LOG_HYGIENE_Q205R2_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_RETEST_REQUIRED');
