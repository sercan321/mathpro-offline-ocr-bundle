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
  'tool/verify_graph_surface_color_hierarchy_final_hygiene_v172_q234r1.mjs',
  'tool/verify_graph_mini_panel_visual_parity_repair_v172_q225.mjs',
  'tool/verify_3d_graph_surface_color_hierarchy_v172_q234.mjs',
  'lib/features/graph/graph_fullscreen_page.dart',
  'lib/features/graph/graph_settings_sheet.dart',
  'lib/features/graph/graph_color_hierarchy.dart',
  'lib/features/graph/graph_models.dart',
  'lib/features/graph/graph_surface_color_hierarchy_final_hygiene_policy.dart',
  'test/v172_q234r1_graph_surface_color_hierarchy_final_hygiene_test.dart',
  'assets/mathlive/manifest.json',
  'README.md',
]) {
  if (!exists(required)) fail(`missing required Q234R1 file: ${required}`);
}

const q225Verifier = read('tool/verify_graph_mini_panel_visual_parity_repair_v172_q225.mjs');
const fullscreen = read('lib/features/graph/graph_fullscreen_page.dart');
const settings = read('lib/features/graph/graph_settings_sheet.dart');
const policy = read('lib/features/graph/graph_surface_color_hierarchy_final_hygiene_policy.dart');
const test = read('test/v172_q234r1_graph_surface_color_hierarchy_final_hygiene_test.dart');
const hierarchy = read('lib/features/graph/graph_color_hierarchy.dart');
const models = read('lib/features/graph/graph_models.dart');
const readme = read('README.md');
const manifest = readJson('assets/mathlive/manifest.json');

for (const marker of [
  'q234SurfaceSuccessorActive',
  'graphSurfaceColorHierarchyLatestPhase',
  'graphSurfaceColorHierarchyFinalHygieneLatestPhase',
  '3D örnek üretilemedi',
  'Q234/Q234R1 surface successor accepted',
]) {
  if (!q225Verifier.includes(marker)) fail(`Q225 verifier missing successor hygiene marker: ${marker}`);
}

for (const marker of [
  'builder: (_) => GraphSettingsSheet(',
  'expression: _expression,',
  'renderMode: _renderMode,',
  'onRenderModeChanged: _setRenderMode,',
  'onApply: (updated) => setState(() => _expression = _sanitizeViewport(updated))',
]) {
  if (!fullscreen.includes(marker)) fail(`fullscreen settings binding missing marker: ${marker}`);
}

const duplicatedApplyKeyCount = (settings.match(/key: const ValueKey\('mathpro-graph-settings-apply'\)/g) || []).length;
if (duplicatedApplyKeyCount !== 1) {
  fail(`graph_settings_sheet apply key count expected 1, got ${duplicatedApplyKeyCount}`);
}
for (const marker of [
  'late String _curveColorKey',
  'GraphFunctionColorPalette.byKey(expression.graphColorKey).key',
  'graphColor: color.color',
  'graphColorKey: color.key',
]) {
  if (!settings.includes(marker)) fail(`settings sheet missing expression-level color persistence marker: ${marker}`);
}

for (const marker of [
  "phase = 'V172-Q234R1'",
  'q234SurfaceRendererPreserved = true',
  'q225VerifierAcceptsQ234SurfaceSuccessor = true',
  'fullscreenGraphSettingsRenderModeBindingRepaired = true',
  'duplicateApplyKeyAnalyzerHygieneRepaired = true',
  "graphColorPersistenceScope = 'expression-level'",
  'globalGraphColorDefaultPreferenceAdded = false',
  'graphPainterMutationAllowed = false',
  'graphSurface3DMutationAllowed = false',
  'keyboardMutationAllowed = false',
  'mathLiveProductionMutationAllowed = false',
  'workspaceLayoutMutationAllowed = false',
]) {
  if (!policy.includes(marker)) fail(`Q234R1 policy missing marker: ${marker}`);
}

for (const marker of [
  'V172-Q234R1 final hygiene policy is scoped and honest',
  'V172-Q234R1 graph color persistence scope is explicitly expression-level',
  "GraphSurfaceColorHierarchyFinalHygienePolicy.graphColorPersistenceScope, 'expression-level'",
  'GraphExpression.fromJson(expression.toJson())',
]) {
  if (!test.includes(marker)) fail(`Q234R1 test missing marker: ${marker}`);
}

for (const marker of [
  'class GraphFunctionColorPalette',
  "defaultKey = 'aquaTeal'",
  'class GraphLayerPalette',
  'class GraphSurfaceColorRamp',
]) {
  if (!hierarchy.includes(marker)) fail(`Q234 hierarchy unexpectedly missing preserved marker: ${marker}`);
}
for (const marker of [
  'final String graphColorKey',
  "'graphColorKey': graphColorKey",
  "final storedColorKey = map['graphColorKey'] as String?",
]) {
  if (!models.includes(marker)) fail(`GraphExpression stable color key marker missing: ${marker}`);
}

if (!readme.includes('## V172-Q234R1 — Graph Surface Color Hierarchy Final Hygiene')) {
  fail('README missing Q234R1 section');
}
const q234r2FinalHygieneSuccessorActive = manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase === 'V172-Q234R2-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-HYGIENE';
const q234r3FinalHygieneSuccessorActive = manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase === 'V172-Q234R3-GRAPH-SURFACE-COLOR-HIERARCHY-FLUTTER-LOG-FINAL-HYGIENE';
if (manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase !== 'V172-Q234R1-GRAPH-SURFACE-COLOR-HIERARCHY-FINAL-HYGIENE' && !q234r2FinalHygieneSuccessorActive && !q234r3FinalHygieneSuccessorActive) {
  fail(`manifest graphSurfaceColorHierarchyFinalHygieneLatestPhase expected Q234R1/Q234R2/Q234R3 got ${manifest.graphSurfaceColorHierarchyFinalHygieneLatestPhase}`);
}
const env = manifest.v172Q234R1GraphSurfaceColorHierarchyFinalHygiene;
if (!env || env.phase !== 'V172-Q234R1-GRAPH-SURFACE-COLOR-HIERARCHY-FINAL-HYGIENE') {
  fail('manifest missing Q234R1 envelope');
} else {
  for (const [key, expected] of Object.entries({
    q234SurfaceRendererPreserved: true,
    q225VerifierAcceptsQ234SurfaceSuccessor: true,
    fullscreenGraphSettingsRenderModeBindingRepaired: true,
    fullscreenGraphSettingsColorApplyPreserved: true,
    duplicateApplyKeyAnalyzerHygieneRepaired: true,
    graphColorPersistenceScope: 'expression-level',
    graphColorStoredInGraphExpression: true,
    graphColorKeyStoredInGraphJson: true,
    globalGraphColorDefaultPreferenceAdded: false,
    graphPainterMutationAllowed: false,
    graphSurface3DMutationAllowed: false,
    keyboardMutationAllowed: false,
    moreMutationAllowed: false,
    longPressMutationAllowed: false,
    mathLiveProductionMutationAllowed: false,
    workspaceLayoutMutationAllowed: false,
    solutionPanelMutationAllowed: false,
    historyMutationAllowed: false,
    appShellMutationAllowed: false,
    flutterAnalyzePassClaimed: false,
    flutterTestPassClaimed: false,
    androidGraphVisualPassClaimed: false,
  })) {
    if (env[key] !== expected) fail(`manifest Q234R1 ${key} expected ${expected} got ${env[key]}`);
  }
}

const protectedHashes = {
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
for (const [file, expected] of Object.entries(protectedHashes)) {
  if (!exists(file)) {
    fail(`protected file missing: ${file}`);
    continue;
  }
  const actual = sha(file);
  if (actual !== expected) fail(`protected hash changed for ${file}: ${actual} expected ${expected}`);
}

const report = {
  phase: 'V172-Q234R1',
  status: errors.length === 0
    ? 'GRAPH_SURFACE_COLOR_HIERARCHY_FINAL_HYGIENE_Q234R1_STATIC_READY_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_SCREENSHOT_QA_REQUIRED'
    : 'GRAPH_SURFACE_COLOR_HIERARCHY_FINAL_HYGIENE_Q234R1_BLOCKED',
  errors,
  q225VerifierSuccessorHygiene: true,
  fullscreenSettingsRenderModeBinding: true,
  graphColorPersistenceScope: 'expression-level',
  globalGraphColorDefaultPreferenceAdded: false,
  protectedMutationAllowed: false,
  flutterAnalyzePassClaimed: false,
  flutterTestPassClaimed: false,
  androidVisualPassClaimed: false,
};
fs.mkdirSync(p('tool/reports'), { recursive: true });
fs.writeFileSync(p('tool/reports/graph_surface_color_hierarchy_final_hygiene_q234r1_report.json'), JSON.stringify(report, null, 2) + '\n');
fs.writeFileSync(p('tool/reports/graph_surface_color_hierarchy_final_hygiene_q234r1_report.md'), `# V172-Q234R1 Graph Surface Color Hierarchy Final Hygiene\n\nStatus: ${report.status}\n\nQ225 verifier successor hygiene: true\n\nFullscreen settings render mode binding: true\n\nGraph color persistence scope: expression-level\n\nGlobal default preference added: false\n\nFlutter/Android visual PASS claimed: false\n`);

if (errors.length) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}
console.log(report.status);
