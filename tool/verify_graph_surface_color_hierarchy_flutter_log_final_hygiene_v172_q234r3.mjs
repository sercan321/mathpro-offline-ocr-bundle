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
const fullPhase = 'V172-Q234R3-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-FINAL-HYGIENE';

for (const required of [
  'lib/features/graph/graph_surface_color_hierarchy_flutter_log_final_hygiene_policy.dart',
  'test/v172_q234r3_graph_surface_color_hierarchy_flutter_log_final_hygiene_test.dart',
  'test/v172_q234_3d_graph_surface_color_hierarchy_test.dart',
  'test/v172_q222_graph_settings_bottom_sheet_control_migration_test.dart',
  'test/v172_q234r2_graph_surface_color_hierarchy_flutter_log_hygiene_test.dart',
  'lib/features/keyboard/long_press_popup.dart',
  'lib/features/graph/graph_surface_3d.dart',
  'tool/verify_graph_surface_color_hierarchy_flutter_log_hygiene_v172_q234r2.mjs',
  'tool/verify_graph_surface_color_hierarchy_final_hygiene_v172_q234r1.mjs',
  'tool/verify_graph_3d_route_fullscreen_binding_v172_q210.mjs',
  'tool/verify_graph_mini_panel_visual_parity_repair_v172_q225.mjs',
  'assets/mathlive/manifest.json',
  'README.md',
]) if (!exists(required)) fail(`missing Q234R3 required file: ${required}`);

const policy = read('lib/features/graph/graph_surface_color_hierarchy_flutter_log_final_hygiene_policy.dart');
const popup = read('lib/features/keyboard/long_press_popup.dart');
const q234Test = read('test/v172_q234_3d_graph_surface_color_hierarchy_test.dart');
const q222Test = read('test/v172_q222_graph_settings_bottom_sheet_control_migration_test.dart');
const q234r2Test = read('test/v172_q234r2_graph_surface_color_hierarchy_flutter_log_hygiene_test.dart');
const q234r2Verifier = read('tool/verify_graph_surface_color_hierarchy_flutter_log_hygiene_v172_q234r2.mjs');
const q234r1Verifier = read('tool/verify_graph_surface_color_hierarchy_final_hygiene_v172_q234r1.mjs');
const q210Verifier = read('tool/verify_graph_3d_route_fullscreen_binding_v172_q210.mjs');
const q225Verifier = read('tool/verify_graph_mini_panel_visual_parity_repair_v172_q225.mjs');
const graph3d = read('lib/features/graph/graph_surface_3d.dart');
const manifest = readJson('assets/mathlive/manifest.json');
const readme = read('README.md');

for (const marker of [
  "phase = 'V172-Q234R3'",
  'q234SurfaceRendererPreserved = true',
  'q234R2FlutterLogFollowUp = true',
  'remainingAnalyzerInfosClosed = true',
  'q222GraphSettingsApplyHitTestHardened = true',
  'q222UsesDragUntilVisibleForApply = true',
  'q234TestConstConstructorsRepaired = true',
  'longPressPopupAnalyzerOnlyConstCleanupApplied = true',
  'graphSurface3DRewritten = false',
  'longPressInventoryMutationAllowed = false',
  'longPressRuntimeMutationAllowed = false',
  'flutterAnalyzePassClaimedByAssistant = false',
  'flutterTestPassClaimedByAssistant = false',
]) if (!policy.includes(marker)) fail(`Q234R3 policy missing marker: ${marker}`);

for (const marker of [
  'const minLeft = edgeInset;',
  'final actualKeyCenterX = anchorCenterX?.clamp',
]) if (!popup.includes(marker)) fail(`long_press_popup final analyzer marker missing: ${marker}`);
if (popup.includes('final minLeft = edgeInset;')) fail('long_press_popup still contains non-const minLeft analyzer issue');

for (const marker of [
  'const MaterialApp(',
  'const expression = GraphExpression(',
]) if (!q234Test.includes(marker)) fail(`Q234 widget test const marker missing: ${marker}`);

for (const marker of [
  'dragUntilVisible',
  'find.byType(SingleChildScrollView)',
  "ValueKey('mathpro-graph-settings-apply')",
]) if (!q222Test.includes(marker)) fail(`Q222 Apply hit-test marker missing: ${marker}`);
if (q222Test.includes('scrollUntilVisible')) fail('Q222 test still uses scrollUntilVisible instead of dragUntilVisible');
if (!q234r2Test.includes('dragUntilVisible') || q234r2Test.includes('scrollUntilVisible')) {
  fail('Q234R2 successor test markers not aligned with Q234R3 dragUntilVisible path');
}

for (const verifier of [q234r2Verifier, q234r1Verifier, q210Verifier, q225Verifier]) {
  if (!verifier.includes(fullPhase)) fail('prior verifier missing Q234R3 successor phase compatibility');
}
for (const marker of [
  'surface-first 3D rendering',
  'void _drawSurfaceFill',
  'void _drawSparseMesh',
  'GraphSurfaceColorRamp.colorAt',
]) if (!graph3d.includes(marker)) fail(`Q234 surface renderer preservation marker missing: ${marker}`);

if (manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase !== fullPhase) {
  fail(`manifest latest expected ${fullPhase} got ${manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase}`);
}
const env = manifest.v172Q234R3GraphSurfaceColorHierarchyFlutterLogFinalHygiene;
if (!env || env.phase !== fullPhase) fail('manifest missing Q234R3 envelope');
else {
  for (const [key, expected] of Object.entries({
    q234SurfaceRendererPreserved: true,
    q234R2FlutterLogFollowUp: true,
    remainingAnalyzerInfosClosed: true,
    q222GraphSettingsApplyHitTestHardened: true,
    q222UsesDragUntilVisibleForApply: true,
    q234TestConstConstructorsRepaired: true,
    longPressPopupAnalyzerOnlyConstCleanupApplied: true,
    graphSurface3DRewritten: false,
    keyboardLayoutMutationAllowed: false,
    longPressInventoryMutationAllowed: false,
    longPressRuntimeMutationAllowed: false,
    mathLiveProductionMutationAllowed: false,
    workspaceLayoutMutationAllowed: false,
    solutionPanelMutationAllowed: false,
    historyMutationAllowed: false,
    appShellMutationAllowed: false,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    androidGraphVisualPassClaimed: false,
  })) if (env[key] !== expected) fail(`manifest Q234R3 ${key} expected ${expected} got ${env[key]}`);
}
if (!readme.includes('## V172-Q234R3 — Graph Surface Color Hierarchy Flutter Log Final Hygiene')) {
  fail('README missing Q234R3 section');
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
  'android/app/src/main/res/values/styles.xml': '986dcbc9ee5c07bfe946ec919b6df794daddddceb752e3277af4c6e7a2caa286',
  'android/app/src/main/res/values-v31/styles.xml': 'a171cce0ccb7dd572c4a2fb12cafd127f5558aedc8eb098ff075b517d69b83fa',
};
for (const [file, expected] of Object.entries(expectedHashes)) {
  if (!exists(file)) fail(`protected file missing: ${file}`);
  else {
    const actual = sha(file);
    if (actual !== expected) fail(`hash mismatch for ${file}: ${actual} expected ${expected}`);
  }
}

const report = {
  phase: 'V172-Q234R3',
  status: errors.length === 0
    ? 'GRAPH_SURFACE_COLOR_HIERARCHY_FLUTTER_LOG_FINAL_HYGIENE_Q234R3_STATIC_READY_WITH_Q235R7_ANDROID12_SMALL_ICON_SUCCESSOR_BUT_REAL_FLUTTER_AND_ANDROID_RETEST_REQUIRED'
    : 'GRAPH_SURFACE_COLOR_HIERARCHY_FLUTTER_LOG_FINAL_HYGIENE_Q234R3_BLOCKED',
  errors,
  analyzerRemainingIssuesFromUserLog: 4,
  flutterTestRemainingFailuresFromUserLog: 1,
  q222ApplyHitTestHardened: true,
  q234SurfaceRendererPreserved: true,
  longPressPopupChangeScope: 'analyzer-only const cleanup; no inventory/order/layout/input behavior mutation',
  flutterAnalyzePassClaimed: false,
  flutterTestPassClaimed: false,
  androidVisualPassClaimed: false,
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/graph_surface_color_hierarchy_flutter_log_final_hygiene_q234r3_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/graph_surface_color_hierarchy_flutter_log_final_hygiene_q234r3_report.md'), `# V172-Q234R3 Graph Surface Color Hierarchy Flutter Log Final Hygiene\n\nStatus: ${report.status}\n\nQ222 Apply hit-test hardened: true\n\nRemaining analyzer/test items from user log addressed statically: true\n\nLongPressPopup change scope: ${report.longPressPopupChangeScope}\n\nFlutter/Android PASS claimed: false\n`);

if (errors.length) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}
console.log(report.status);
