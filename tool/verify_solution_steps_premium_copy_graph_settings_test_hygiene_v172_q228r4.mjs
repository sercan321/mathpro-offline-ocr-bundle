#!/usr/bin/env node
import fs from 'node:fs';
import path from 'node:path';
import crypto from 'node:crypto';

const root = process.cwd();
const p = (rel) => path.join(root, rel);
const exists = (rel) => fs.existsSync(p(rel));
const read = (rel) => fs.readFileSync(p(rel), 'utf8');
const sha256 = (rel) => crypto.createHash('sha256').update(fs.readFileSync(p(rel))).digest('hex');
const errors = [];
const fail = (message) => errors.push(message);

for (const required of [
  'test/graph_history_regression_test.dart',
  'lib/features/graph/graph_settings_sheet.dart',
  'lib/features/graph/graph_card.dart',
  'lib/features/solution/solution_steps_panel.dart',
  'tool/verify_solution_steps_premium_copy_graph_settings_test_hygiene_v172_q228r4.mjs',
]) {
  if (!exists(required)) fail(`missing required Q228R4 file: ${required}`);
}

const graphHistoryTest = read('test/graph_history_regression_test.dart');
const graphSettings = read('lib/features/graph/graph_settings_sheet.dart');
const graphCard = read('lib/features/graph/graph_card.dart');
const solutionPanel = read('lib/features/solution/solution_steps_panel.dart');

for (const marker of [
  "expect(find.text('Graph Settings'), findsOneWidget)",
  "expect(find.byKey(const ValueKey('mathpro-graph-settings-window-fields')), findsOneWidget)",
  "find.text('Apply')",
]) {
  if (!graphHistoryTest.includes(marker)) fail(`graph history regression test missing Q228R4 current settings contract marker: ${marker}`);
}
if (graphHistoryTest.includes("expect(find.byKey(const ValueKey('mathpro-mini-graph-surface')), findsOneWidget)")) {
  fail('graph history regression test still expects stale mini graph surface inside settings sheet');
}
if (!graphSettings.includes("key: const ValueKey('mathpro-graph-settings-window-fields')")) {
  fail('graph settings sheet missing window fields key used by Q228R4 test contract');
}
if (!graphSettings.includes("key: const ValueKey('mathpro-graph-settings-sheet-q222')")) {
  fail('graph settings sheet root key missing');
}

for (const marker of [
  "import 'graph_curve_painter.dart';",
  'final evaluator = GraphExpressionEvaluator(expression.normalizedExpression);',
  'child: FittedBox(\n            fit: BoxFit.scaleDown,\n            child: Row(',
]) {
  if (!graphCard.includes(marker)) fail(`graph card lost Q228R2/R3/Q231R1 hygiene marker: ${marker}`);
}
for (const marker of [
  "key: const ValueKey('mathpro-solution-steps-scroll')",
  "key: const ValueKey('mathpro-solution-empty-state-message')",
]) {
  if (!solutionPanel.includes(marker)) fail(`solution panel lost Q227/Q228 scroll/empty marker: ${marker}`);
}

const protectedHashes = {
  'lib/features/keyboard/key_config.dart': '4ecd7270e29a27d75bdd80d36aa5b6f1064a2c3a1d3360c3edd4856432d0f1a2',
  'lib/features/workspace/template_tray.dart': 'b58f05b9f6f8b089a4335554f062e0652929bd9c2f60d3fdbf79d4bc87aca678',
  'lib/features/history/history_controller.dart': '331a6d84dbe4a940f185a69bc5623c6aaa0f2b16f4198f2149a4f4b375be3f51',
  'lib/features/history/history_panel.dart': 'fad987605894ffafc0069fa80f560908c6f529a05da81d2165e924524728537b',
  'assets/mathlive/main_editor_prod.html': 'f32e884f83f94d3ac2077f2c65d0278edbba163ca30c640605edc75c337dd9cd',
  'assets/mathlive/mathlive_prod_bridge.js': 'fdb5637820b735975b6e0c74a984896e1cd1d7ef3db725d10cdd4450658a45e4',
  'lib/features/mathlive/mathlive_production_editor_surface.dart': 'f89f6822b85870608befd20d9602c0310d2e67c300bbc5736612b5a4d90929a9',
  'lib/app/app_shell.dart': 'ac80aef66dde3b4c4a7bc863f4a4b36b0be735ea3a865ceaa90a854afacbd637',
  'lib/main.dart': '068648069a69ec196c566cc0e27feb6dcb496059f9cd606367c6cc646b602689',
  'android/app/src/main/AndroidManifest.xml': 'e788776fb08b0e63d7beb9844b34df0e198a913b715dcfbef3df6e2ef77f5b20',
  'android/app/src/main/res/values/styles.xml': '3c2cdc2835c62f5c107c2c01eef9d56107ede8190d0e5387c5f105d55c55eeb3',
  'android/app/src/main/res/values-v31/styles.xml': 'a7c6fb6d72ee0c032629ea760c9a02ff585a9dda4b9c0aacee243e30da1a23a1',
};
for (const [rel, expected] of Object.entries(protectedHashes)) {
  if (!exists(rel)) {
    fail(`protected file missing: ${rel}`);
    continue;
  }
  const actual = sha256(rel);
  if (actual !== expected) fail(`protected hash changed for ${rel}: expected ${expected}, got ${actual}`);
}

const report = {
  phase: 'V172-Q228R4-SOLUTION-STEPS-PREMIUM-COPY-GRAPH-SETTINGS-TEST-HYGIENE',
  status: errors.length === 0
    ? 'SOLUTION_STEPS_PREMIUM_COPY_GRAPH_SETTINGS_TEST_HYGIENE_Q228R4_STATIC_READY_WITH_Q231_LONG_PRESS_SUCCESSOR_WITH_Q231R1_LONG_PRESS_ANCHOR_SUCCESSOR_BUT_FLUTTER_ANALYZE_TEST_AND_ANDROID_PIXEL_QA_REQUIRED'
    : 'SOLUTION_STEPS_PREMIUM_COPY_GRAPH_SETTINGS_TEST_HYGIENE_Q228R4_BLOCKED',
  errors,
  repairs: {
    staleMiniGraphSurfaceExpectationRemovedFromSettingsSheetTest: true,
    settingsWindowFieldsKeyUsedAsContract: true,
    runtimeBehaviorChanged: false,
  },
  keyboardMoreLongPressMathLiveProtected: errors.every((e) => !e.startsWith('protected hash changed')),
  flutterAnalyzePassClaimedByAssistant: false,
  flutterTestPassClaimedByAssistant: false,
  androidRealDevicePassClaimedByAssistant: false,
};
fs.mkdirSync(p('tool/reports'), {recursive: true});
fs.writeFileSync(p('tool/reports/solution_steps_premium_copy_graph_settings_test_hygiene_q228r4_report.json'), `${JSON.stringify(report, null, 2)}\n`);
fs.writeFileSync(p('tool/reports/solution_steps_premium_copy_graph_settings_test_hygiene_q228r4_report.md'), `# ${report.phase}\n\n${report.status}\n\n- Stale settings-sheet mini graph test expectation removed: true\n- Current settings window-fields key used: true\n- Runtime behavior changed: false\n- Flutter/Android PASS claimed: false\n`);

if (errors.length > 0) {
  console.error(report.status);
  for (const error of errors) console.error(`- ${error}`);
  process.exit(1);
}
console.log(report.status);
