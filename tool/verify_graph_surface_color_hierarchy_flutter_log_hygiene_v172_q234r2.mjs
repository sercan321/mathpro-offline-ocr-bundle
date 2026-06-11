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
const errors = [];
const fail = (message) => errors.push(message);

for (const required of [
  'lib/features/graph/graph_surface_color_hierarchy_flutter_log_hygiene_policy.dart',
  'test/v172_q234r2_graph_surface_color_hierarchy_flutter_log_hygiene_test.dart',
  'test/v172_q156_mathlive_popup_envelope_final_rebalance_test.dart',
  'test/v172_q210_graph_3d_route_fullscreen_binding_test.dart',
  'test/v172_q225_graph_mini_panel_visual_parity_repair_test.dart',
  'test/v172_q222_graph_settings_bottom_sheet_control_migration_test.dart',
  'lib/features/graph/graph_color_hierarchy.dart',
  'lib/features/graph/graph_settings_sheet.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'tool/verify_graph_3d_route_fullscreen_binding_v172_q210.mjs',
  'tool/verify_graph_mini_panel_visual_parity_repair_v172_q225.mjs',
  'assets/mathlive/manifest.json',
  'README.md',
]) {
  if (!exists(required)) fail(`missing Q234R2 required file: ${required}`);
}

const policy = read('lib/features/graph/graph_surface_color_hierarchy_flutter_log_hygiene_policy.dart');
const q234r2Test = read('test/v172_q234r2_graph_surface_color_hierarchy_flutter_log_hygiene_test.dart');
const q156Test = read('test/v172_q156_mathlive_popup_envelope_final_rebalance_test.dart');
const q210Test = read('test/v172_q210_graph_3d_route_fullscreen_binding_test.dart');
const q225Test = read('test/v172_q225_graph_mini_panel_visual_parity_repair_test.dart');
const q222Test = read('test/v172_q222_graph_settings_bottom_sheet_control_migration_test.dart');
const q210Verifier = read('tool/verify_graph_3d_route_fullscreen_binding_v172_q210.mjs');
const hierarchy = read('lib/features/graph/graph_color_hierarchy.dart');
const popup = read('lib/features/keyboard/long_press_popup.dart');
const settings = read('lib/features/graph/graph_settings_sheet.dart');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');

for (const marker of [
  "phase = 'V172-Q234R2'",
  'q234SurfaceRendererPreserved = true',
  'q156PopupEnvelopeTestAlignedWithQ231Successor = true',
  'q210ThreeDRouteTestAlignedWithQ234SurfaceSuccessor = true',
  'q225MiniPanelTestAlignedWithQ234SurfaceSuccessor = true',
  'q222GraphSettingsTestScrollsToApplyAfterColorPicker = true',
  'q234AnalyzerInfoCleanupApplied = true',
  'graphSurface3DRewritten = false',
  'longPressInventoryMutationAllowed = false',
  'longPressRuntimeMutationAllowed = false',
  'longPressPopupAnalyzerOnlyCleanupApplied = true',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
]) if (!policy.includes(marker)) fail(`Q234R2 policy missing marker: ${marker}`);

for (const marker of [
  'greaterThanOrEqualTo(96)',
  'GraphSurfaceColorRamp.colorAt',
  'quad.meanZ',
  '3D örnek üretilemedi',
  'dragUntilVisible',
  "ValueKey('mathpro-graph-settings-apply')",
]) {
  const bundle = `${q156Test}\n${q210Test}\n${q225Test}\n${q222Test}`;
  if (!bundle.includes(marker)) fail(`Flutter test hygiene marker missing: ${marker}`);
}
if (q156Test.includes('LongPressPopup.boundedIntegralChipWidth, greaterThanOrEqualTo(104)')) {
  fail('Q156 Flutter test still hard-fails Q231 compact 98px successor with >=104 expectation');
}
for (const marker of [
  'q234SurfaceSuccessorActive',
  'GraphSurfaceColorRamp.colorAt',
  'quad.meanZ',
  'clamp(-0.22, 1.22).toDouble()',
]) if (!q210Verifier.includes(marker)) fail(`Q210 verifier missing Q234 successor marker: ${marker}`);

for (const marker of [
  'const gridBase = Color(0xFF94A5A8)',
  'const axisBase = Color(0xFFC5D0D2)',
]) if (!hierarchy.includes(marker)) fail(`graph color hierarchy analyzer cleanup missing: ${marker}`);
for (const marker of [
  'const edgeInset = PremiumPopupFitPolicy.longPressPanelHorizontalInset',
  'final actualKeyCenterX = anchorCenterX?.clamp',
  'return const Padding(',
]) if (!popup.includes(marker)) fail(`long_press_popup analyzer cleanup missing: ${marker}`);
for (const marker of [
  'padding: const EdgeInsets.fromLTRB(18, 12, 18, 14)',
  'mathpro-graph-settings-function-color-picker-q234',
]) if (!settings.includes(marker)) fail(`settings sheet compact-fit marker missing: ${marker}`);

const q234r3FinalHygieneSuccessorActive = manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase === 'V172-Q234R3-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-FINAL-HYGIENE';
if (manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase !== 'V172-Q234R2-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-HYGIENE' && !q234r3FinalHygieneSuccessorActive) {
  fail(`manifest latest Q234R2/Q234R3 phase missing/incorrect: ${manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase}`);
}
const env = manifest.v172Q234R2GraphSurfaceColorHierarchyFlutterLogHygiene;
if (!env || env.phase !== 'V172-Q234R2-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-HYGIENE') {
  fail('manifest missing Q234R2 envelope');
} else {
  for (const [key, expected] of Object.entries({
    q234SurfaceRendererPreserved: true,
    q234R1FullscreenBindingPreserved: true,
    q156PopupEnvelopeTestAlignedWithQ231Successor: true,
    q210ThreeDRouteTestAlignedWithQ234SurfaceSuccessor: true,
    q225MiniPanelTestAlignedWithQ234SurfaceSuccessor: true,
    q222GraphSettingsTestScrollsToApplyAfterColorPicker: true,
    q234AnalyzerInfoCleanupApplied: true,
    graphSurface3DRewritten: false,
    keyboardLayoutMutationAllowed: false,
    longPressInventoryMutationAllowed: false,
    longPressRuntimeMutationAllowed: false,
    longPressPopupAnalyzerOnlyCleanupApplied: true,
    mathLiveProductionMutationAllowed: false,
    workspaceLayoutMutationAllowed: false,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    androidGraphVisualPassClaimed: false,
  })) {
    if (env[key] !== expected) fail(`manifest Q234R2 ${key} expected ${expected} got ${env[key]}`);
  }
}
if (!readme.includes('## V172-Q234R2 — Graph Surface Color Hierarchy Flutter Log Hygiene')) {
  fail('README missing Q234R2 section');
}

const expectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/keyboard/math_keyboard.dart': 'fc8e6504448bbdd64bdbb674fd000c04511ab185a8a110eecb7102dce19d116c',
  'lib/features/keyboard/bottom_dock.dart': 'a6e8c25369faa0cac016314c42a93be76ac5ca21c0b16c4152b279a339f9c354',
  'lib/features/keyboard/premium_key.dart': '4311a54f0f4e21b3b134552af2613d2ff30fed2078ebd6279a222d877fa21b43',
  'lib/features/keyboard/long_press_popup.dart': '4bb7e11846efd80d831cc3178b72f57207e458dd7e72bb27f1615d7218769369',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9',
  'lib/features/solution/solution_steps_panel.dart': '558c0f232dd4bb81bbf92ffa7687ff8d77fb450daf95f5e04a98f277f1625f2b',
  'lib/features/solution/solution_step_models.dart': 'faab66d941f841911989bee8fae44d0d1edc546fabb6f65fd7dab777405cc248',
  'lib/features/history/history_panel.dart': 'fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b',
  'lib/features/history/history_controller.dart': '331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51',
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
  'android/app/src/main/AndroidManifest.xml': 'e788776fb08b0e63d7beb9844b34df0e198a913b715dcfbef3df6e2ef77f5b20',
  'android/app/src/main/res/values/styles.xml': '3c2cdc2835c62f5c107c2c01eef9d56107ede8190d0e5387c5f105d55c55eeb3',
  'android/app/src/main/res/values-v31/styles.xml': 'a7c6fb6d72ee0c032629ea760c9a02ff585a9dda4b9c0aacee243e30da1a23a1',
};
for (const [file, expected] of Object.entries(expectedHashes)) {
  if (!exists(file)) fail(`protected file missing: ${file}`);
  else {
    const actual = sha(file);
    if (actual !== expected) fail(`hash mismatch for ${file}: ${actual} expected ${expected}`);
  }
}

const report = {
  phase: 'V172-Q234R2',
  status: errors.length === 0
    ? 'GRAPH_SURFACE_COLOR_HIERARCHY_FLUTTER_LOG_HYGIENE_Q234R2_STATIC_READY_BUT_REAL_FLUTTER_AND_ANDROID_RETEST_REQUIRED'
    : 'GRAPH_SURFACE_COLOR_HIERARCHY_FLUTTER_LOG_HYGIENE_Q234R2_BLOCKED',
  errors,
  q156FlutterTestHygiene: true,
  q210FlutterTestHygiene: true,
  q225FlutterTestHygiene: true,
  q222GraphSettingsApplyScrollHygiene: true,
  analyzerInfoCleanupApplied: true,
  longPressPopupChangeScope: 'analyzer-only const/null-aware cleanup; no inventory/order/layout/input logic mutation',
  flutterAnalyzePassClaimed: false,
  flutterTestPassClaimed: false,
  androidVisualPassClaimed: false,
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/graph_surface_color_hierarchy_flutter_log_hygiene_q234r2_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/graph_surface_color_hierarchy_flutter_log_hygiene_q234r2_report.md'), `# V172-Q234R2 Graph Surface Color Hierarchy Flutter Log Hygiene\n\nStatus: ${report.status}\n\nQ156/Q210/Q225/Q222 Flutter-test hygiene: true\n\nAnalyzer-info cleanup applied: true\n\nLongPressPopup change scope: ${report.longPressPopupChangeScope}\n\nFlutter/Android PASS claimed: false\n`);

if (errors.length) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}
console.log(report.status);
